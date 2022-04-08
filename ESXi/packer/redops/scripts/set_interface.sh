STATIC_IP=$(ip a | grep -E '([0-9]{1,3}\.){3}[0-9]{1,3}\/24' | cut -d '/' -f1 | cut -d " " -f6 | sed 's/inet/address/g')

ip a
rm /etc/network/interfaces
echo "\n127.0.0.1       ts-redops" >>/etc/hosts

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
" >> /etc/network/interfaces

sudo ifdown ens33
ifup ens33
sleep 5
