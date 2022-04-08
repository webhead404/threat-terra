#!/bin/bash

echo "
auto ens34
iface ens34 inet static
      address 192.168.56.10
      netmask 255.255.255.0
" >> /etc/network/interfaces

ifup ens34
