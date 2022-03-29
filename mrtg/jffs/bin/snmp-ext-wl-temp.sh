#!/bin/sh

# SNMP extension for DD-WRT - WL temperatue * 10 [C] #
#
#cat /proc/dmu/temperature
curl -u admin:squid=3128 -s -o - http://localhost/Status_Router.asp \
   | grep -o "WL0 ...." | cut -d' ' -f2 | tr -d .
