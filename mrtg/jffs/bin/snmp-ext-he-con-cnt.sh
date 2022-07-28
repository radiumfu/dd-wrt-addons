#!/bin/sh

# SNMP extension for DD-WRT - count of He vlan3 connections #
#
vlan2='192.168.1.'
vlan3='192.168.3.'
gw2=${vlan2}11
gw3=${vlan3}11

grep $vlan3 /proc/net/nf_conntrack | grep -v $gw3 | grep -v $vlan2 | grep -c "$1"
