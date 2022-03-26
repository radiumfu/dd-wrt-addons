#!/bin/sh

# SNMP extension for DD-WRT - wireless primary channel #
#
wl assoc | awk '/Primary channel:/ {print $3}'
