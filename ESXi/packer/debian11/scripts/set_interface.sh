STATIC_IP=$(ip a | grep -E '([0-9]{1,3}\.){3}[0-9]{1,3}\/24' | cut -d '/' -f1 | cut -d " " -f6 | sed 's/inet/address/g')


ip a
sudo rm /etc/network/interfaces
echo "\n127.0.0.1       ts-debian11" >>/etc/hosts

echo "
source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
allow-hotplug eth0
auto eth0
iface eth0 inet static
      address ${STATIC_IP}
      netmask 255.255.255.0
      gateway 192.168.1.1
" >> /etc/network/interfaces
