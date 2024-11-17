# dd-wrt-addons
dd-wrt extensions and addons - mostly Asus RT-N16/N18U related, tested works on Netgear R7000, AC1900 might work on other routers

    Please note that scripts ending with .sample suffix have to be manually edited to provide
    specific parameters (like authentiction, ip addresses, gateways etc) to become fully functional.
    
Then save edited (and configured) scripts without .sample extension.

### SNMP Extension for MRTG
Extensions is the simplest and efficient way to extend SNMPd OID modality with user implemented probes. 
Then standard SNMP retrieval and visualization by mrtg (or any other SNMP kit) takes place.

#### implemented extension probes
Each probe is a short bash shell script to return single numeric value:

* [cpu temperature](mrtg/jffs/bin/snmp-ext-cpu-temp.sh) - router CPU temperature 

* [wl temperature](mrtg/jffs/bin/snmp-ext-wl-temp.sh.sample) - wireless module temperature

* [connection count](mrtg/jffs/bin/snmp-ext-connection-cnt.sh) - router connection count (parameter tcp/udp/unknown)

* [wifi noise floor dBm](mrtg/jffs/bin/snmp-ext-wifi-noise-dbm.sh) - wifi noise floor in dBm (parameter offset)

* [wifi channel](mrtg/jffs/bin/snmp-ext-wifi-channel.sh) - active primary wifi channel

* [avg ping timw](mrtg/ffs/bin/snmp-ext-ping.sh) - average ping time to ping server in ms (parameter ping server, number of pings, timeout)

* [vlan connection count](mrtg/jffs/bin/snmp-ext-he-con-cnt.sh) - router vlan-wan connection count

* [dhcp leases](mrtg/jffs/bin/snmp-ext-dhcp-clients.sh) - active dhcp clients count

* [wifi associations](mrtg/jffs/bin/snmp-ext-wifi-assoc.sh) - associated wifi clients count

The results are avaiiable in **NET-SNMP-EXTEND-MIB** OIDs tree:

    NET-SNMP-EXTEND-MIB::nsExtendOutLine."string-id"

Each extension has to be added to SNMPd config file (do not remove any existing lines):
    
    /vat/snmp/snmpd.conf
    
Extension config line has the following format (consult snmpd doc for more details):

    extend <string-id> <full-path-to-script> <par1> ... <parN>

There are helper scripts to automate process of adding extensions to **/vat/snmp/snmpd.conf** on each boot/reboot:

* [append-file.sh](mrtg/jffs/bin/append-file.sh) - script to add extensions to snmpd.conf

* [snmpd.conf.ext.sample](mrtg/jffs/etc/config/snmpd.conf.ext.sample) - sample extension file

* [snmpd.startup](mrtg/jffs/etc/config/snmpd.startup) - startup script (executed on boot/reboot)

#### testing extensions
To test and verify extension functionality use either **snmpwalk** or **snmpget** tools:

    > snmpwalk -c public -v 2c router NET-SNMP-EXTEND-MIB::nsExtendOutLine
    NET-SNMP-EXTEND-MIB::nsExtendOutLine."ping".1 = STRING: 23.202
    NET-SNMP-EXTEND-MIB::nsExtendOutLine."tcpcnt".1 = STRING: 57
    NET-SNMP-EXTEND-MIB::nsExtendOutLine."udpcnt".1 = STRING: 91
    NET-SNMP-EXTEND-MIB::nsExtendOutLine."wltemp".1 = STRING: 465
    NET-SNMP-EXTEND-MIB::nsExtendOutLine."cputemp".1 = STRING: 630
    NET-SNMP-EXTEND-MIB::nsExtendOutLine."ping8844".1 = STRING: 27.646
    NET-SNMP-EXTEND-MIB::nsExtendOutLine."vlan3all".1 = STRING: 13
    NET-SNMP-EXTEND-MIB::nsExtendOutLine."vlan3est".1 = STRING: 6
    NET-SNMP-EXTEND-MIB::nsExtendOutLine."dhcplease".1 = STRING: 3
    NET-SNMP-EXTEND-MIB::nsExtendOutLine."wifiassoc".1 = STRING: 3
    NET-SNMP-EXTEND-MIB::nsExtendOutLine."wifichannel".1 = STRING: 1
    NET-SNMP-EXTEND-MIB::nsExtendOutLine."wifinoisedbm".1 = STRING: 3

    > snmpget -c public -v 2c router NET-SNMP-EXTEND-MIB::nsExtendOutLine.\"ping\".1
    NET-SNMP-EXTEND-MIB::nsExtendOutLine."ping".1 = STRING: 23.390
