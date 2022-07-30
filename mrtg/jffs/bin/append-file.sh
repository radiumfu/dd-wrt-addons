#!/bin/sh

# append srcfile line-by-line at the end of dstfile if line is not in dstfile yet #

# usage example to add snmpd extensions (place in /jffs/etc/name.startup):
# > /jfss/bin/$0 -log snmpd.conf -reload snmpd /jffs/bin/snmpd.conf.ext /var/snmp/snmpd.conf

# version
#
VER=2022.07.26

# default output to stdout
#
msg=echo

# usage
#
[ $# -lt 2 ] && echo "usage: $0 [-log tag] [-reload process] srcfile dstfile" && exit 255

# cli pars parser
#
while [ $# -gt 0 ]
do
    case $1 in
    -l|-log)
        shift
    	msg="logger -t $1"
    	;;
    -r|-reload)
        shift
        reload=$1
    	;;
    *)
        if [ ! $ext ]
        then
            ext=$1
        else
            [ ! $dst ] && dst=$1
        fi
        ;;
    esac
    shift
done

# info
#
$msg "$0 - read line-by-line $(wc -l $ext) >> $(wc -l $dst)"

# read src file line by line and append to dst if not already present
#
while read -r line
do
    grep -qF -- "$line" "$dst" || ( $msg "+ $line"; echo "$line" >> "$dst" )
done < "$ext"

# info
#
$msg "$0 - done $(wc -l $dst)"

# reread process named $reload config if running
#
[ $reload ] && pid=$(pidof $reload) && kill -HUP $pid && $msg "$0 - $reload pid $pid reloaded"
