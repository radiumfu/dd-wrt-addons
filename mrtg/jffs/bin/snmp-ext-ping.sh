#!/bin/sh

# SNMP extension for DD-WRT - average ping time to $1 from $2 times [ms] with $3 timeout #
#
target=${1:-localhost}
ping -c ${2:-3} -w ${3:-5} ${target} | awk -F/ '/min\/avg\/max/ {print $4}'
