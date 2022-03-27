#!/bin/sh

# SNMP extension for DD-WRT - count of active tcp/udp/unknown connections #
#
grep -c "^$1 " /proc/net/ip_conntrack
