#!/bin/sh

# SNMP extension for DD-WRT - DHCP clients count #
# file with active dhcp leases
DB=/tmp/bw.db
# subtract header (for positive offset include + sign)
OFS=-1
# diplay line count corrected by offset
echo $(( $(cat $DB | wc -l) $OFS ))
