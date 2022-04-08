STATIC_IP=$(ip a | grep -E '([0-9]{1,3}\.){3}[0-9]{1,3}\/24' | cut -d '/' -f1 | cut -d " " -f6 | sed 's/inet/address/g')

ip link
sudo rm /etc/network/interfaces

echo "\n127.0.0.1       ts-elastic" >>/etc/hosts


echo "
source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
allow-hotplug ens33
auto ens33
iface ens33 inet static
      address ${STATIC_IP}
      netmask 255.255.255.0
      gateway 192.168.1.1

auto ens34
iface ens34 inet static
      address 192.168.56.10
      netmask 255.255.255.0
" >> /etc/network/interfaces

sleep 5
sudo ifdown ens34
ifup ens34
