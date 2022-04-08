Write-Host "Staging Static IP for Ansible"

# Change MacAddress
#Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\0001" -Name 'NetworkAddress' -Value '005056A2B1C2' -Type String 

# Set vars
$nic_id=((Get-NetAdapter | where {$_.Name -eq 'Ethernet0'}).DeviceID.ToLower())
$reg_path="HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\$nic_id"

# Turn off DHCP
Set-ItemProperty -Path "$reg_path" -Name 'EnableDHCP' -Value 0 -Type DWord

# Stage static IP
New-ItemProperty -Path "$reg_path" -Name 'IPAddress' -Value '$Env:PRIMARY_INTERFACE' -Type MultiString
New-ItemProperty -Path "$reg_path" -Name 'DefaultGateway' -Value '$Env:PRIMARY_INTERFACE_GATEWAY' -Type MultiString
New-ItemProperty -Path "$reg_path" -Name 'SubnetMask' -Value '255.255.255.0' -Type MultiString
New-ItemProperty -Path "$reg_path" -Name 'NameServer' -Value '$Env:PRIMARY_INTERFACE_GATEWAY' -Type String 
