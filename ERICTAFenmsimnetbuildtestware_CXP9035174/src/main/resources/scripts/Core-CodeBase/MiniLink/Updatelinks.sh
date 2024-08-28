#!/bin/bash

usage (){

    echo "Usage  : $0 <sim name> "

    echo "Example: $0 CORE-FT-ML6693-1-8x2-CORE81"

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

if [[ $simName == *"ML6693"* && $simName == *"CORE81"* ]]
then

for node in "${neNames[@]}"
do
cat >> ML6693_RLT.mml << ABC
.open $simName
.select ${node}
add_table_entry:mibname="XF-RADIOLINK-RLT-MIB",tablename="xfRLTTable",index="[14]",entry="[{7,\"PE-ML6693.2\"}]";
add_table_entry:mibname="XF-RADIOLINK-RLT-MIB",tablename="xfRLTTable",index="[16]",entry="[{7,\"PE-ML6693.2\"}]";
add_table_entry:mibname="XF-RADIOLINK-RLT-MIB",tablename="xfRLTTable",index="[13]",entry="[{8,\"PE-ML6693.2\"}]";
add_table_entry:mibname="XF-RADIOLINK-RLT-MIB",tablename="xfRLTTable",index="[15]",entry="[{8,\"PE-ML6693.2\"}]";
add_table_entry:mibname="XF-RADIOLINK-RLT-MIB",tablename="xfRLTTable",index="[14]",entry="[{5,\"PE-ML6693.2\"}]";
add_table_entry:mibname="XF-RADIOLINK-RLT-MIB",tablename="xfRLTTable",index="[16]",entry="[{5,\"PE-ML6693.2\"}]";

ABC
done
/netsim/inst/netsim_pipe < ML6693_RLT.mml
rm ML6693_RLT.mml

fi
echo "$0 ended at" $( date +%T );

