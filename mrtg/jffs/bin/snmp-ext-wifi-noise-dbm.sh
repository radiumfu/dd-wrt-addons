#!/bin/sh

# SNMP extension for DD-WRT - wireless noise floor [dBm] #
# $1 is optional offset to get positive numbers for mrtg (default 100)
let n=${1:-100}+$(wl noise)
echo $n
