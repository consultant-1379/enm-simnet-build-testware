#!/bin/sh
########################################################################
# Version1    : 20.07
# Revision    : CXP 903 5174-1-13
# Purpose     : Support for ALD links in ML6691
# Date        : April 2020
# Who         : xharidu
########################################################################

if [ "$#" -ne 1  ]
then
 echo
 echo "Please give proper Inputs .. !!"
 echo
 echo "Usage: $0 <sim name>"
 echo
 echo "Example: $0 CORE-FT-ML6691-1-5-1x2-CORE91"
 echo
 exit 1
fi
#-------------------------------------------------------
# Input Parameters

SIMNAME=$1

#####################################################
# The below parameters should be same across the network
#
NETWORK=8300 #Number of nodes in the network
RINGCOUNT=50 #Number of nodes that single ring contains
########################################
# MAIN PROGRAM
###########i#############################
SIMSTR=$(echo ${SIMNAME//Transport/})
SIMVAR=(${SIMSTR//-/ })
SIMNUM=$(echo ${SIMVAR[${#SIMVAR[@]}-1]})
SIMNUM=$(expr $SIMNUM + 0)
BORDERNUM=0
NUMOFNODES=$(echo $SIMNAME | awk -F"x" '{print $2}' | cut -d"-" -f1)
if [ $(expr $NETWORK % $RINGCOUNT ) -ne 0 ]
then
   BORDERNUM=$(expr $NETWORK - $(expr $NETWORK % $RINGCOUNT ) + 1)
fi
BORDERRING=$(expr $(expr $NETWORK / $RINGCOUNT ) + 1)
if [ $RINGCOUNT -gt $NETWORK ]
then
   echo "ERROR:The nodes in the ring exceeded the network count..!!"
   exit 1
fi

# Creating the MML script ###
MMLSCRIPT=$SIMNAME"_alds.mml"
if [ -e $MMLSCRIPT ]
then
   rm $MMLSCRIPT
fi
cat >> $MMLSCRIPT << MML
.open $SIMNAME
.select network
.start
MML
########################################
NODECOUNT=1
VERSION=`echo $SIMNAME | awk -F 'ML6691' '{print $2}' | awk -F 'x' '{print $1}'`
if [ $SIMNUM -le 9 ]
then
   SIMBASE="Transport0"$SIMNUM"ML6691$VERSION"
else
   SIMBASE="Transport"$SIMNUM"ML6691$VERSION"
fi

while [ $NODECOUNT -le $NUMOFNODES ]
do
   if [ $NODECOUNT -le 9 ]
   then
      NODENAME=$SIMBASE"-0"$NODECOUNT
   else
      NODENAME=$SIMBASE"-"$NODECOUNT
   fi
   NODEPOSITION=$(expr $(expr $NUMOFNODES \* $(expr $SIMNUM - 1)) + $NODECOUNT)
   DIV=$(expr $NODEPOSITION / $RINGCOUNT)
   REM=$(expr $NODEPOSITION % $RINGCOUNT)
   if [ $REM -eq 0 ]
   then
      RINGPOS=$DIV
   else
      RINGPOS=$(expr $DIV + 1)
   fi
   if [ $NODEPOSITION -ge $BORDERNUM ] && [ $BORDERNUM -ne 0 ]
   then
      RINGPOS=$BORDERRING
      LOWERRINGLIMIT=$BORDERNUM
      UPPERRINGLIMIT=$NETWORK
   else
      LOWERRINGLIMIT=$(expr $(expr $(expr $RINGPOS - 1) \* $RINGCOUNT ) + 1)
      UPPERRINGLIMIT=$(expr $RINGPOS \* $RINGCOUNT )
   fi
   REMOTENODEPOS=$(expr $NODEPOSITION - 1)
   if [ $REMOTENODEPOS -lt $LOWERRINGLIMIT ]
   then
      REMOTENODEPOS=$UPPERRINGLIMIT
   fi
   NEXTNODEPOS=$(expr $NODEPOSITION + 1)
   if [ $NEXTNODEPOS -gt $UPPERRINGLIMIT ]
   then
   NEXTNODEPOS=$LOWERRINGLIMIT
   fi
   REMOTEDIV=$(expr $REMOTENODEPOS / $NUMOFNODES)
   REMOTEMOD=$(expr $REMOTENODEPOS % $NUMOFNODES)
   if [ $REMOTEMOD -eq 0 ]
   then
      REMOTESIMNUM=$REMOTEDIV
	  REMOTENODECOUNT=$NUMOFNODES
   else
      REMOTESIMNUM=$(expr $REMOTEDIV + 1)
	  REMOTENODECOUNT=$REMOTEMOD
   fi
   if  [ $REMOTESIMNUM -le 9 ]
   then
      REMOTESIMBASE="Transport0"$REMOTESIMNUM"ML6691$VERSION"
   else
      REMOTESIMBASE="Transport"$REMOTESIMNUM"ML6691$VERSION"
   fi
   if [ $REMOTENODECOUNT -le 9 ]
   then
      REMOTE_NODE=$REMOTESIMBASE"-0"$REMOTENODECOUNT
   else
      REMOTE_NODE=$REMOTESIMBASE"-"$REMOTENODECOUNT
   fi
   NEXTNODEDIV=$(expr $NEXTNODEPOS / $NUMOFNODES)
    NEXTNODEMOD=$(expr $NEXTNODEPOS % $NUMOFNODES)
     if [ $NEXTNODEMOD -eq 0 ]
     then
        NEXTSIMNUM=$NEXTNODEDIV
           NEXTNODECOUNT=$NUMOFNODES
     else
        NEXTSIMNUM=$(expr $NEXTNODEDIV + 1)
            NEXTNODECOUNT=$NEXTNODEMOD
    fi
    if  [ $NEXTSIMNUM -le 9 ]
     then
        NEXTSIMBASE="Transport0"$NEXTSIMNUM"ML6691$VERSION"
    else
        NEXTSIMBASE="Transport"$NEXTSIMNUM"ML6691$VERSION"
    fi
     if [ $NEXTNODECOUNT -le 9 ]
    then
        NEXT_NODE=$NEXTSIMBASE"-0"$NEXTNODECOUNT
   else
       NEXT_NODE=$NEXTSIMBASE"-"$NEXTNODECOUNT
       fi
   
   echo "RING: $RINGPOS ; $NODENAME ; $REMOTE_NODE  ; $NEXT_NODE" 
cat >> $MMLSCRIPT << MML
.select ${NODENAME}
add_table_entry:mibname="LLDP-V2-MIB",tablename="lldpV2PortConfigTableV2",index="[2134638849,33]",entry="[\{3,3}]";
set_scalar:mibname="LLDP-V2-MIB",scalar="lldpV2LocSysName",value="${NODENAME}";
add_table_entry:mibname="LLDP-V2-MIB",tablename="lldpV2LocPortTable",index="[2134638849]",entry="[{3,\"LAN 1/2/1\"}]";


add_table_entry:mibname="LLDP-V2-MIB",tablename="lldpV2PortConfigTableV2",index="[2134639368,33]",entry="[\{3,3}]";
add_table_entry:mibname="LLDP-V2-MIB",tablename="lldpV2RemTable",index="[1,2134639368,33,44]",entry="[\{8,\"LAN 1/2/1\"},\{10,\"${REMOTE_NODE}\"}]";


add_table_entry:mibname="LLDP-V2-MIB",tablename="lldpV2PortConfigTableV2",index="[2134639366,33]",entry="[\{3,3}]";
add_table_entry:mibname="LLDP-V2-MIB",tablename="lldpV2LocPortTable",index="[2134639366]",entry="[{3,\"LAN 1/6/6\"}]";


add_table_entry:mibname="LLDP-V2-MIB",tablename="lldpV2PortConfigTableV2",index="[2134639367,33]",entry="[\{3,3}]";
add_table_entry:mibname="LLDP-V2-MIB",tablename="lldpV2RemTable",index="[1,2134639367,33,44]",entry="[\{8,\"LAN 1/6/6\"},\{10,\"${REMOTE_NODE}\"}]";


add_table_entry:mibname="XF-RADIOLINK-RLT-MIB",tablename="xfRLTTable",index="[9]",entry="[{5,\"${NODENAME}\"}]";
add_table_entry:mibname="XF-RADIOLINK-RLT-MIB",tablename="xfRLTTable",index="[7]",entry="[{5,\"${NODENAME}\"},{7,\"RLT 1/5/1\"}]";
add_table_entry:mibname="XF-RADIOLINK-RLT-MIB",tablename="xfRLTTable",index="[10]",entry="[{7,\"RLT 1/5/1\"},{5,\"${REMOTE_NODE}\"},{2,\"FRLT 1/5/1\"}]";
add_table_entry:mibname="XF-RADIOLINK-RLT-MIB",tablename="xfRLTTable",index="[8]",entry="[{7,\"RLT 1/4/1\"},{5,\"${NEXT_NODE}\"},{2,\"FRLT 1/4/1\"}]";
MML

   NODECOUNT=$(expr $NODECOUNT + 1)

done

## executing the netsim commands ##
/netsim/inst/netsim_shell < $MMLSCRIPT
rm $MMLSCRIPT
