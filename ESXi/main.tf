#########################################
#  ESXI Provider host/login details
#########################################
#
#   Use of variables here to hide/move the variables to a separate file
#
provider "esxi" {
  esxi_hostname = var.esxi_hostname
  esxi_hostport = var.esxi_hostport
  esxi_username = var.esxi_username
  esxi_password = var.esxi_password
}

#########################################
#  ESXI Guest resource
#########################################
resource "esxi_guest" "Elastomic_Packer" {
  guest_name = "ts-elastomic"
  disk_store = var.esxi_datastore
  guestos    = "rhel7-64"

  boot_disk_type = "thin"

  memsize            = "4096"
  numvcpus           = "2"
  resource_pool_name = "/"
  power              = "on"
  clone_from_vm = "Elastomic_Packer"

    provisioner "remote-exec" {
    inline = [
      "sudo ifconfig eth0 up && echo 'eth0 up' || echo 'unable to bring eth0 interface up",
      "sudo ifconfig eth1 up && echo 'eth1 up' || echo 'unable to bring eth1 interface up"
    ]

    connection {
      host        = self.ip_address
      type        = "ssh"
      user        = "vagrant"
      password    = "vagrant"
    }
  }
  # This is the network that bridges your host machine with the ESXi VM
  # If this interface doesn't provide connectivity, you will have to uncomment
  # the interface below and add a virtual network that does
  network_interfaces {
    virtual_network = var.vm_network
    mac_address     = "00:50:56:a3:b1:c2"
    nic_type        = "e1000"
  }
  # This is the local network that will be used for 192.168.33.x addressing
  network_interfaces {
    virtual_network = var.hostonly_network
    mac_address     = "00:50:56:a3:b1:c4"
    nic_type        = "e1000"
  }
  # OPTIONAL: Uncomment out this interface stanza if your vm_network doesn't 
  # provide internet access
  # network_interfaces {
  #  virtual_network = var.nat_network
  #  mac_address     = "00:50:56:a3:b1:c3"
  #  nic_type        = "e1000"
  # }
  guest_startup_timeout  = 45
  guest_shutdown_timeout = 30
}

resource "esxi_guest" "Centos_Packer" {
  guest_name = "ts-centos7"
  disk_store = var.esxi_datastore
  guestos    = "rhel7-64"

  boot_disk_type = "thin"

  memsize            = "4096"
  numvcpus           = "2"
  resource_pool_name = "/"
  power              = "on"
  clone_from_vm = "Centos_Packer"
  # This is the network that bridges your host machine with the ESXi VM
  network_interfaces {
    virtual_network = var.vm_network
    mac_address     = "00:50:56:a1:b1:c2"
    nic_type        = "e1000"
  }
  # This is the local network that will be used for 192.168.33.x addressing
  network_interfaces {
    virtual_network = var.hostonly_network
    mac_address     = "00:50:56:a1:b1:c4"
    nic_type        = "e1000"
  }
  guest_startup_timeout  = 45
  guest_shutdown_timeout = 30
}

resource "esxi_guest" "Windows10_Packer" {
  guest_name = "ts-windows10"
  disk_store = var.esxi_datastore
  guestos    = "windows9-64"

  boot_disk_type = "thin"

  memsize            = "2048"
  numvcpus           = "2"
  resource_pool_name = "/"
  power              = "on"
  clone_from_vm = "Windows10_Packer"
  # This is the network that bridges your host machine with the ESXi VM
  network_interfaces {
    virtual_network = var.vm_network
    mac_address     = "00:50:56:a2:b1:c2"
    nic_type        = "e1000"
  }
  # This is the local network that will be used for 192.168.33.x addressing
  network_interfaces {
    virtual_network = var.hostonly_network
    mac_address     = "00:50:56:a2:b1:c4"
    nic_type        = "e1000"
  }
  guest_startup_timeout  = 45
  guest_shutdown_timeout = 30
}
