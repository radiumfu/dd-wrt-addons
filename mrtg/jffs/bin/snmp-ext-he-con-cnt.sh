#!/bin/sh

# SNMP extension for DD-WRT - count vlan connections to wan #
# usage: $0 <vlan-gateway> <local-gateway> [<filter>]

gw3=${1:-192.168.3.1}
gw1=${2:-192.168.1.1}
match=$3
# connection tracking
con=/proc/net/nf_conntrack
# extract subnet from gateway
vlan3=${gw3%.*}.
vlan1=${gw1%.*}.
# get vlan conn  - vlan.gw conn - local.lan conn - filter.count
grep $vlan3 $con | grep -v $gw3 | grep -v $vlan1 | grep -c "$match"
