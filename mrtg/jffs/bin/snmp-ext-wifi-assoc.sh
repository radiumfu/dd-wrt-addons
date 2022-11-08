#!/bin/sh

# SNMP extension for DD-WRT - wireless associated clients count #
# radio is off
[ $(wl radio) = "0x0001" ] && echo "0" && exit
# radio is on - get count of associated MAC addresses
wl assoclist | wc -l
