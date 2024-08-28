#!/bin/bash
########################################################################
# Version     : 18.01
# Revision    : CXP 903 5174-1-1
# Purpose     : Loads features for SIU02 nodes based on node type
# Description : Sets ProductData values by calling AssignProductData.sh script
# Date        : NOV 2017
# Who         : xmedkar
########################################################################
########################################################################
#Script Usage#
########################################################################
usage (){

echo "Usage  : $0 <sim name> "

echo "Example: $0 CORE-1K-SIU02-17A-V2x138-06 (or) CORE-1K-SIU02-17A-V2x138-06 CORE1SIU0 "

}
neType(){

echo "ERROR: The script runs only for siu02 nodes"
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
########################################################################
#To check the if simname is SIU02#
########################################################################
if [[ $simName != *"SIU02"* ]]
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

########################################################################
#Making MO script#
########################################################################
for nodeName in ${neNames[@]}
do
cat >> $nodeName.mo << DEF
SET
(
    mo "STN=0"
    // moid = 1
    exception none
    nrOfAttributes 1
    "lastConfigChange" String "2017-08-02 11:29:05"
)

DEF
########################################################################
#Making MML script#
########################################################################
cat >> siu02.mml << ABC
.open $simName
.select $nodeName
.start
kertayle:file="$Path/$nodeName.mo";
ABC
########################################################################
moFiles+=($nodeName.mo)
done

/netsim/inst/netsim_pipe < siu02.mml
for filenum in ${moFiles[@]}
do
rm $filenum
done
rm siu02.mml
echo "$0 ended at" $( date +%T );

