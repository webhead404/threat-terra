output "Centos_Packer_interfaces" {
  value = esxi_guest.Centos_Packer.network_interfaces
}

output "Centos_Packer_ips" {
  value = esxi_guest.Centos_Packer.ip_address
}

output "Elastomic_Packer_interfaces" {
  value = esxi_guest.Elastomic_Packer.network_interfaces
}

output "Elastomic_Packer_ips" {
  value = esxi_guest.Elastomic_Packer.ip_address
}

output "Windows10_Packer_interfaces" {
  value = esxi_guest.Windows10_Packer.network_interfaces
}

output "Windows10_Packer_ips" {
  value = esxi_guest.Windows10_Packer.ip_address
}