#!/bin/bash

usage (){

echo "Usage  : $0 <sim name> "

echo "Example: $0 ML6352-R2-8x2-CORE42"

}
neType(){

echo "ERROR: The script runs only for MiniLink nodes"
}
########################################################################
#To check commandline arguments#
########################################################################
if [ $# -ne 1 ]
then
usage
exit 1
fi
########################################################################
#Variables
########################################################################
simName=$1
Path=`pwd`
echo $Path
########################################################################
#To check the if simname belongs to MiniLink type#
########################################################################
if [[ $simName != *"ML"* ]]
then
neType
exit 1
fi

echo "$0 started running at" $(date +%T)
#######################################################################
#Extracting nodenames#
#######################################################################
$Path/../bin/extractNeNames.pl $simName
neNames=( $( cat $Path/dumpNeName.txt ) )
nodeName=${neNames[0]}



Version=`echo $simName | awk -F 'x' '{print $1}' | awk -F 'R' '{print $2}' | sed 's/-//g'`
#########################################################################
#Configuration of RLT parameters for ML6352 nodes
#########################################################################
if [[ $simName == *"ML6352"* && $simName == *"Transport42"* && $Version -ge 218 ]]
then
cat >> ML6352_RLT.mml << ABC1
.open $simName
.select ${neNames[0]}
add_table_entry:mibname="PT-RADIOLINK-MIB",tablename="rltTable",index="[120101]",entry="[{6,\"111\"}]";
add_table_entry:mibname="PT-RADIOLINK-MIB",tablename="rltTable",index="[120101]",entry="[{4,\"${nodeName}h\"}]";
e mmldb:update(ne_name,"${nodeName}L").
e mmldb:update(ne_id,"112").
.select ${neNames[1]}
add_table_entry:mibname="PT-RADIOLINK-MIB",tablename="rltTable",index="[120101]",entry="[{6,\"112\"}]";
add_table_entry:mibname="PT-RADIOLINK-MIB",tablename="rltTable",index="[120101]",entry="[{4,\"${nodeName}L\"}]";
e mmldb:update(ne_name,"${nodeName}h").
e mmldb:update(ne_id,"111").
ABC1
/netsim/inst/netsim_pipe < ML6352_RLT.mml
rm ML6352_RLT.mml

fi
################################################################################
#LLDP command support for ML6352
################################################################################
if [[ $simName == *"ML6352"* && $simName == *"Transport42"* && $Version -ge 219 ]]
then
cat >> ML6352_LLDP.mml <<ABC2
.open $simName
.select ${neNames[0]}
lldpchange:OperationType=set,ClassName=lan,slot=1,port=4,systemname="ML6352[10-223-200-169]",systemdescription="MINI-LINK 6352 80/21H",portid="1/1/4",portidtype="interface-name",managementaddress="10.223.200.169",managementaddressipv6="::",chassisid="CR9L253642",chassisidtype=local,localinterface="lldp_0104";
.select ${neNames[1]}
lldpchange:OperationType=set,ClassName=lan,slot=1,port=4,systemname="ML6352[10-223-200-168]",systemdescription="MINI-LINK 6352 80/21L",portid="1/1/4",portidtype="interface-name",managementaddress="10.223.200.168",managementaddressipv6="::",chassisid="CR9L236156",chassisidtype=local,localinterface="lldp_0104";
.select ${neNames[2]}
lldpchange:OperationType=set,ClassName=wan,slot=1,port=5,systemname="ML6352[10-223-200-171]",systemdescription="MINI-LINK 6352 80/21H",portid="1/1/5",portidtype="interface-name",managementaddress="10.223.200.171",managementaddressipv6="::",chassisid="CR9L253643",chassisidtype=local,localinterface="lldp_0105";
.select ${neNames[3]}
lldpchange:OperationType=set,ClassName=wan,slot=1,port=5,systemname="ML6352[10-223-200-170]",systemdescription="MINI-LINK 6352 80/21L",portid="1/1/5",portidtype="interface-name",managementaddress="10.223.200.170",managementaddressipv6="::",chassisid="CR9L236157",chassisidtype=local,localinterface="lldp_0105";
ABC2
/netsim/inst/netsim_pipe < ML6352_LLDP.mml

rm ML6352_LLDP.mml

fi

echo "$0 ended at" $( date +%T );

