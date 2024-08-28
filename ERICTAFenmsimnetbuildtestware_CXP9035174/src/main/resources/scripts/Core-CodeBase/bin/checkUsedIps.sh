#!/bin/sh
PWD=`pwd`
echo ".show allsimnes" | ~/inst/netsim_shell | awk -F" " '{print $2}' | sed '/^$/d' | grep -v "[a-z][A-Z]*"  | awk -F":" '{print $1}'| grep -v ":" | sed '/^NE/d' > dat/dumpUsedIps_Intermediate.txt

cat dat/dumpUsedIps_Intermediate.txt | awk -F"," '{print $1}'  > dat/dumpUsedIps.txt

cat dat/dumpUsedIps_Intermediate.txt | awk -F"," '{print $2}' | sed '/^$/d' >> dat/dumpUsedIps.txt

cat dat/dumpUsedIps_Intermediate.txt | awk -F"," '{print $3}' | sed '/^$/d' >> dat/dumpUsedIps.txt

rm dat/dumpUsedIps_Intermediate.txt
