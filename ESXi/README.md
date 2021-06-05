## ThremulationStation can be installed within ESXi by using Packer and Terraform. This method requires some extra setup and other tooling will also be needed. This still a huge work in progress with a fair amount of changes needing to be made. If something doesn't work, feel free to file an issue! (Viewer discretion is advised.) ##

All of the previous prerequisites are still required. You will still need Ansible and Git and will need to additionally install Packer, PyWinRM, OVFTool from VMWare and Terraform.

1. Git clone this repo and `cd` into ESXi

2. We will use Packer to build the boxes directly on an ESXi datastore. We can do this by using a `variables.json` file with Packer A cookie cutter file has been provided and you will just need to change it to match your ESXi deployment. If you’re using ESXi 7.x (as opposed to 6.x) VNC over websocket will have to be used. For convenience both directives have been added to the Packer files. Download Packer and run the following: 
- `PACKER_CACHE_DIR=../../packer/packer_cache packer build -var-file variables.json windows10-local.json`
- `PACKER_CACHE_DIR=../../packer/packer_cache packer build -var-file variables.json elastomic-local.json`
- `PACKER_CACHE_DIR=../../packer/packer_cache packer build -var-file variables.json centos-local.json`

Depending on your network connection it could take awhile to build the VM's. 

3. Use Terraform to provision the Packer VM's for deployment and make sure OVFTool is installed and in your $PATH. Add a .tfvars file for your ESXi environment, and run `terraform init` followed by `terraform apply` inside the ESXi folder. 

I recommend snapshotting the newly provisioned VM's before running Ansible against them that way if something doesn't work correctly you can debug it easier.

4. The VM's should be provisioned and now it is time to run Ansible against them! Windows10 will not be provisioned without PyWinRM so make sure you have downloaded and installed that as well. Change the `inventory.yml` file with your VM IP addresses and run `ansible-playbook -v terrastation.yml`

Sometimes the playbook can fail on the Windows tasks and have found that running this can help in those cases: 

`export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES`