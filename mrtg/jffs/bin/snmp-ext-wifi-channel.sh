#!/bin/sh

# SNMP extension for DD-WRT - wireless primary channel #
# if radio is not on
[ $(wl radio) != 0x0000 ] && echo "0" && exit
# radio is on - get primary channel (even if rdio is off primary channel is displayed)
wl assoc | awk '/Primary channel:/ {print $3}'
