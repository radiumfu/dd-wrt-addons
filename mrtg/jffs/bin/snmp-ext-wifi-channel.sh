#!/bin/sh

# SNMP extension for DD-WRT - wireless primary channel #
# radio is off
[ $(wl radio) = "0x0001" ] && echo "0" && exit
# radio is on - get primary channel (even if rdio is off primary channel is displayed)
wl assoc | awk '/Primary channel:/ {print $3}'
