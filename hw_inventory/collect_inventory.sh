#!/bin/bash

# motherboard
board_sn=$(dmidecode -t baseboard | grep -i serial | cut -d ':' -f 2 | xargs)
echo -e "board SN:\t${board_sn}"

# ssd + hdd

nvme_sn=$(nvme list help | grep -v Node | grep -v "\-\-" | awk '{print $2}' | xargs)
echo -e "NVME SN:\t${nvme_sn}"

# IB
ib_sys_guid=$(ibstat | grep 'System image GUID' | cut -d ':' -f 2 | xargs)
echo -e "IB sys GUID:\t${ib_sys_guid}"

# IPMI

# cables

# eth MAC
eth_mac=$(ip link show | grep ether | awk '{print $2}' | xargs | tr ' ' ',')
echo -e "ETH macs:\t${eth_mac}"

# PSU

psu_1_sn=$(ipmitool fru print 2 | grep Serial | cut -d ':' -f 2 | xargs)
echo -e "PSU 1 SN:\t${psu_1_sn}"
