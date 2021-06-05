## ThremulationStation can be installed within ESXi by using Packer and Terraform. This method requires some extra setup and other tooling will also be needed. This still a huge work in progress with a fair amount of changes needing to be made. If something doesn't work, feel free to file an issue! (Viewer discretion is advised.) ##

All of the previous prerequisites are still required. You will still need Ansible and Git and will need to additionally install Packer, PyWinRM, OVFTool from VMWare and Terraform.

1. Make sure SSH is enabled on ESXi.

2. Create a HostOnly portgroup and VSwitch within ESXi. 

3. SSH to your ESXi host as root and run esxcli system settings advanced set -o /Net/GuestIPHack -i 1. This allows Packer to infer the guest IP from ESXi, without the VM needing to report it itself.

4. Download and install the OVFTool for your OS and make sure it is in your path. https://code.vmware.com/web/tool/4.4.0/ovf

5. Install Terraform, Ansible and PyWinRM.

6. Git clone this repo and `cd` into ESXi

7. We will use Packer to build the boxes directly on an ESXi datastore. We can do this by using a `variables.json` file with Packer A cookie cutter file has been provided and you will just need to change it to match your ESXi deployment. If you’re using ESXi 7.x (as opposed to 6.x) VNC over websocket will have to be used. For convenience both directives have been added to the Packer files. Download Packer and run the following: 
- `PACKER_CACHE_DIR=../../packer/packer_cache packer build -var-file variables.json windows10-local.json`
- `PACKER_CACHE_DIR=../../packer/packer_cache packer build -var-file variables.json elastomic-local.json`
- `PACKER_CACHE_DIR=../../packer/packer_cache packer build -var-file variables.json centos-local.json`

Depending on your network connection it could take awhile to build the VM's. 

8. Use Terraform to provision the Packer VM's for deployment and make sure OVFTool is installed and in your $PATH. Add a .tfvars file for your ESXi environment, and run `terraform init` followed by `terraform apply` inside the ESXi folder. 

I recommend snapshotting the newly provisioned VM's before running Ansible against them that way if something doesn't work correctly you can debug it easier.

Additionally, check that your VM's second NIC (HostOnly) is set to the right port group on all VMs. In the past I have had to disconnect/reconnect the interface on each. Normally, the NIC is disabled on a VM until customization completes, so if something prevents it from completing, the NIC will remain disabled. This is part of the design on vSphere so that a VM will not have network access until the necessary attributes have been updated. Currently there is an issue with the remote-exec provisioner but the build will still have all the VM's as needed. Until then, further troubleshooting will be done until this is fixed. 

4. The VM's should be provisioned and now it is time to run Ansible against them! Windows10 will not be provisioned without PyWinRM so make sure you have downloaded and installed that as well. Change the `inventory.yml` file with your VM IP addresses and run `ansible-playbook -v terrastation.yml`

Sometimes the playbook can fail on the Windows tasks and have found that running this can help in those cases: 

`export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES`
