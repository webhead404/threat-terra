

rm /etc/network/interfaces

echo "Setting the interface IP to ${debian11_host_address} for Ansible"

echo "
source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
allow-hotplug eth0
auto eth0
iface eth0 inet static
      address ${debian11_host_address}
      netmask 255.255.255.0
      gateway 192.168.1.1
" >> /etc/network/interfaces
