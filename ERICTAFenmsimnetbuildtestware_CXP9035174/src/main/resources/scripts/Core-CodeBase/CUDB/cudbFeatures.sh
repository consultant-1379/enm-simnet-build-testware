#!/bin/bash
########################################################################
# Version     : 16.16
# Revision    : CXP 903 5174-1-1
# Purpose     : Loads features for WCG nodes based on node type
# Description : Creates Mos and sets attributes
# Date        : Oct 2016
# Who         : xgouhar
########################################################################
########################################################################
#Script Usage#
########################################################################
usage (){

echo "Usage  : $0 <sim name> "

echo "Example: $0 CORE-ST-WCG-16A-V3x5"

}
neType(){

echo "ERROR: The script runs only for WCG nodes"
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
#To check the if simname is WCG#
########################################################################
if [[ $simName != *"CUDB"* ]]
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
mkdir /netsim/netsimdir/$simName/pm
cp test.xml /netsim/netsimdir/$simName/pm
########################################################################
#Reading product data from file AssignProductData
########################################################################
productData=$($Path/../bin/AssignProductData.sh $simName)
productNumber=`echo $productData | cut -d ":" -f1`
productRevision=`echo $productData | cut -d ":" -f2`
########################################################################
#Making MO script#
########################################################################
for nodeName in ${neNames[@]}
do
########################################################################
#Making MML script#
########################################################################
cat >> cudb.mml << ABC
.open $simName
.select $nodeName
.start
pmdata:disable;
suspendPMScanners;
e tsp_pm_lib:get_fstime().
e statistics_mgr:list_workers().
ABC
########################################################################
moFiles+=($nodeName.mo)
done

/netsim/inst/netsim_pipe < cudb.mml
rm cudb.mml *.txt
echo "$0 ended at" $( date +%T );


