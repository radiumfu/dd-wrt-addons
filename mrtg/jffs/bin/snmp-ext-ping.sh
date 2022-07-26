#!/bin/sh

# SNMP extension for DD-WRT
# average ping time to target $1 (default localhost) avg $2 times (default 3) [ms] with timeout $3 (default 5) sec #
#
target=${1:-localhost}
ping -c ${2:-3} -w ${3:-5} ${target} | awk -F/ '/min\/avg\/max/ {print $4}'
