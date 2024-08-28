#!/bin/bash
########################################################################
# Version        : 2.4
# Product Number : CXP 903 5174
# Revision       :
# Purpose        : Loads features for NELS nodes based on node type
# Description    : Creates Mos and sets attributes
# Date           : August 2019
# Who            : zchianu
########################################################################
########################################################################
#Script Usage#
########################################################################
usage (){

echo "Usage  : $0 <sim name> "

echo "Example: $0 CORE-FT-NELS-2.4-V2x5-CORE205"

}
neType(){

echo "ERROR: The script runs only for NELS nodes"
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
#To check the if simname is NELS#
########################################################################
if [[ $simName != *"NELS"* ]]
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
cat >> $nodeName.mo << DEF
 SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,BrM:BrM=1,BrM:BrmBackupManager=1"
    exception none
    nrOfAttributes 2
    "backupType" String "type"
    "backupDomain" String "domain"
)

SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,BrM:BrM=1,BrM:BrmBackupManager=1,BrM:BrmBackup=1"
    exception none
    nrOfAttributes 2
    "creationType" Integer 3
    "backupName" String "1"
)


SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,CmwSwIM:SwInventory=1,CmwSwIM:SwItem=1"
    exception none
    nrOfAttributes 1
    "administrativeData" Struct
        nrOfElements 6
        "productName" String "$nodeName"
        "productNumber" String "$productNumber"
        "productRevision" String "$productRevision"
        "productionDate" String "2019-01-23T07:57:43"
        "description" String "$nodeName"
        "type" String "N/A"

)


SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,CmwSwIM:SwInventory=1,CmwSwIM:SwVersion=1"
    exception none
    nrOfAttributes 1
    "administrativeData" Struct
        nrOfElements 6
        "productName" String "$nodeName"
        "productNumber" String "$productNumber"
        "productRevision" String "$productRevision"
        "productionDate" String "2019-01-23T07:57:43"
        "description" String "$nodeName"
        "type" String "N/A"

)
SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,SecSecM:SecM=1,SEC_CertM:CertM=1,SEC_CertM:CertMCapabilities=1"
    exception none
    nrOfAttributes 1
    "enrollmentSupport" Array Integer 3
         0
         1
         3
) 
DEF
########################################################################
#Making MML script#
########################################################################
cat >> dsc.mml << ABC
.open $simName
.select $nodeName
.start
kertayle:file="$Path/$nodeName.mo";
ABC
########################################################################
moFiles+=($nodeName.mo)
done

/netsim/inst/netsim_pipe < dsc.mml
for filenum in ${moFiles[@]}
do
rm $filenum
done
rm dsc.mml
echo "$0 ended at" $( date +%T );
