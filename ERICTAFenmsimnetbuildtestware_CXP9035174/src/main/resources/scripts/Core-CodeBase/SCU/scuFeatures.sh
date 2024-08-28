#!/bin/bash
########################################################################
# Version        : 1
# Revision       : CXP 903 5174-1-1
# Purpose        : Loads features for SCU nodes based on node type
# Description    : Creates Mos and sets attributes
# Date           : Mar 2021
# Who            : zhainic
########################################################################
########################################################################
# Version        : 2
# Revision       : CXP 903 5174-1-43
# Purpose        : HW features for SCU nodes based on node type
# Description    : sets attributes
# Date           : Aug 2021
# Who            : zjaisai
########################################################################
# Version3       : 21.16
# Revision       : CXP 903 5174-1-47
# Purpose        : Sysmtem Backup Mos creation
# Date           : 27th Sep 2021
# Who            : zyamkan
########################################################################
########################################################################
#Script Usage#
########################################################################
usage (){

echo "Usage  : $0 <sim name>  "

echo "Example: $0 Transport-FT-SCU-21-Q1-V1x6-Transport101 "

}
neType(){

echo "ERROR: The script runs only for SCU nodes"
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
#To check the if simname is BSP#
########################################################################
if [[ $simName != *"SCU"* ]]
then
neType
exit 1
fi

echo "$0 started running at" $(date +%T)
#######################################################################
#Extracting nodenames#
#######################################################################
time=`date '+%FT04:04:04.666%:z'`
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
    mo "SCU_Top:ManagedElement=1,SCU_Top:SystemFunctions=1,SCU_SwIM:SwInventory=1,SCU_SwIM:SwVersion=1"
    exception none
    nrOfAttributes 1
    "administrativeData" Struct
        nrOfElements 6
        "productName" String "$nodeName"
        "productNumber" String "$productNumber"
        "productRevision" String "$productRevision"
        "productionDate" String "2021-02-11T01:39:55"
        "description" String "$nodeName"
        "type" String "1"

)
SET
(
    mo "SCU_Top:ManagedElement=1,SCU_Top:SystemFunctions=1,SCU_SecM:SecM=1,SCU_CertM:CertM=1,SCU_CertM:CertMCapabilities=1"
    exception none
    nrOfAttributes 2
    "keySupport" Array Integer 1
         1
    "enrollmentSupport" Array Integer 1
         3
)

SET
(
    mo "SCU_Top:ManagedElement=1,SCU_Top:SystemFunctions=1,SCU_HwIM:HwInventory=1,SCU_HwIM:HwItem=1"
    exception none
    nrOfAttributes 8
    "vendorName" String "Ericsson AB"
    "serialNumber" String "CN81043259"
    "productData" Struct
        nrOfElements 6
        "productName" String "Support Control Unit"
        "productNumber" String "KDU 127 170/3"
        "productRevision" String "R1D"
        "productionDate" String "2018-09-19T00:00:00+00:00"
        "description" String ""
        "type" String "SCU"

     "manualDataEntry" Integer 0
     "hwType" String "SCU"
     "hwModel" String "Support Control Unit"
     "hwCapability" String "Support Control Unit"
     "dateOfLastService" String "2021-03-24T13:22:54Z"
)
SET
(
    mo "SCU_Top:ManagedElement=1,SCU_Top:SystemFunctions=1,SCU_BrM:BrM=1,SCU_BrM:BrmBackupManager=1"
    exception none
    nrOfAttributes 2
    "backupType" String "Systemdata"
    "backupDomain" String "System"
)
SET
(
    mo "SCU_Top:ManagedElement=1,SCU_Top:SystemFunctions=1,SCU_BrM:BrM=1,SCU_BrM:BrmBackupManager=1,SCU_BrM:BrmBackup=1"
    exception none
    nrOfAttributes 3
    "backupName" String "1"
    "creationType" Integer 3
    "creationTime" String "$time"
    "swVersion" Array Struct 1
        nrOfElements 6
       "productName" String "SCU"
       "productNumber" String "$productNumber"
       "productRevision" String "$productRevision"
       "productionDate" String "$time"
       "description" String "SW package for system release 20.Q2"
       "type" String "SCU"

)
DEF

cat >> scu.mml << ABC
.open $simName
.select $nodeName
.start
kertayle:file="$Path/$nodeName.mo";
ABC
########################################################################
moFiles+=($nodeName.mo)
done

/netsim/inst/netsim_pipe < scu.mml
for filenum in ${moFiles[@]}
do
rm $filenum
done
rm scu.mml
echo "$0 ended at" $( date +%T );

