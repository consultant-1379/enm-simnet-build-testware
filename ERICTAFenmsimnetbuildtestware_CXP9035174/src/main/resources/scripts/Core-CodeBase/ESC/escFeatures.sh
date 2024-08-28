#!/bin/bash
########################################################################
# Version        : 1
# Revision       : CXP 903 5174-1-1
# Purpose        : Configuring Product Data for ESC nodes to sync
# Description    : Creates Mos and sets attributes
# Date           : Oct 2021
# Who            : zmogsiv
########################################################################
########################################################################
# Version        : 2
# Revision       : CXP 903 5174-1-43
# Purpose        : CM,SHM and Brm features for ESC nodes based on node type
# Description    : sets attributes
# Date           : Oct 2021
# Who            : zmogsiv
########################################################################
########################################################################
#Script Usage#
########################################################################
usage (){

echo "Usage  : $0 <sim name>  "

echo "Example: $0 Transport-FT-ERS-SN-ESC-22-Q1-V1x9-Transport102 "

}
neType(){

echo "ERROR: The script runs only for ESC nodes"
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
if [[ $simName != *"ESC"* ]]
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
    mo "SCU_Top:ManagedElement=1,SCU_Top:SystemFunctions=1,SCU_SwIM:SwInventory=1,SCU_SwIM:SwVersion=1"
    // moid = 15
    exception none
    nrOfAttributes 1
    "administrativeData" Struct
         nrOfElements 6
         "productName" String "$nodeName"
         "productNumber" String "$productNumber"
         "productRevision" String "$productRevision"
         "productionDate" String "2021-10-21T08:04:52"
         "description" String "$nodeName"
         "type" String "1"

)

SET
(
    mo "SCU_Top:ManagedElement=1,SCU_Top:SystemFunctions=1,SCU_SecM:SecM=1,SCU_CertM:CertM=1,SCU_CertM:CertMCapabilities=1"
    // moid = 21
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
    // moid = 23
    exception none
    nrOfAttributes 8
    "vendorName" String "Ericsson AB"
    "serialNumber" String "CN81023028"
    "productData" Struct
    nrOfElements 6
           "productName" String "Ericsson Site Controller"
           "productNumber" String "KDU 127 170/1"
           "productRevision" String "R2B"
           "productionDate" String "2021-11-08T13:24:49+00:00"
           "description" String ""
           "type" String "ESC"
    "manualDataEntry" Integer 0
    "hwType" String "ESC"
    "hwModel" String "Ericsson Site Controller"
    "hwCapability" String "Ericsson Site Controller"
    "dateOfLastService" String "2021-11-08T13:24:49Z"
)

// Set Statement generated: 2021-11-23 10:34:53
SET
(
    mo "SCU_Top:ManagedElement=1,SCU_Top:SystemFunctions=1,SCU_BrM:BrM=1,SCU_BrM:BrmBackupManager=1"
    // moid = 26
    exception none
    nrOfAttributes 2
    "backupType" String "Systemdata"
    "backupDomain" String "System"
)


SET
(
    mo "SCU_Top:ManagedElement=1,SCU_Top:SystemFunctions=1,SCU_BrM:BrM=1,SCU_BrM:BrmBackupManager=1,SCU_BrM:BrmBackup=1"
    // moid = 30
    exception none
    nrOfAttributes 1
    "creationType" Integer 3
)

// Set Statement generated: 2021-11-16 10:59:36
SET
(
    mo "SCU_Top:ManagedElement=1,SCU_Top:SystemFunctions=1,SCU_BrM:BrM=1,SCU_BrM:BrmBackupManager=1,SCU_BrM:BrmBackup=1"
    // moid = 30
    exception none
    nrOfAttributes 3
    "swVersion" Array Struct 1
     nrOfElements 6
         "productName" String "Transport-FT-ERS-SN-ESC-22-Q1-V1x6-Transport102"
         "productNumber" String "19003-CXP9017878/3"
         "productRevision" String "R26A"
         "productionDate" String "2021-11-16T10:44:19"
         "description" String "Product Data for 22.Q1"
         "type" String "ESC"
 
     "creationTime" String "2021-11-16T10:44:19"
     "backupName" String "1"
)
DEF
for count in {2..61}
do
cat >> $nodeName.mo << KSD
CREATE
(
    parent "SCU_Top:ManagedElement=1,SCU_Top:SystemFunctions=1,SCU_HwIM:HwInventory=1"
	identity "$count"
	moType SCU_HwIM:HwItem
    exception none
    nrOfAttributes 16
    "hwItemId" String "$count"
    "vendorName" String "Ericsson AB"
    "hwModel" String "Ericsson Site Controller"
    "hwType" String "ESC"
    "hwName" String ""
    "hwCapability" String "Ericsson Site Controller"
    "equipmentMoRef" Array Ref 0
    "additionalInformation" String ""
    "hwUnitLocation" String ""
    "manualDataEntry" Integer 1
    "serialNumber" String "CN81023028"
    "dateOfLastService" String "2021-11-08T13:24:49Z"
    "swInvMoRef" Array Ref 0
    "licMgmtMoRef" Array Ref 0
    "additionalAttributes" Array Struct 0
    "productData" Struct
        nrOfElements 6
        "productName" String "Ericsson Site Controller"
        "productNumber" String "KDU 127 170/1"
        "productRevision" String "R2B"
        "productionDate" String "2021-11-08T13:24:49+00:00"
        "description" String ""
        "type" String "ESC"

)

CREATE
(
    parent "SCU_Top:ManagedElement=1,SCU_Top:SystemFunctions=1,SCU_Lm:Lm=1"
	identity "$count"
	moType SCU_Lm:FeatureKey
    exception none
    nrOfAttributes 8
    "featureKeyId" String "$count"
    "state" Ref "null"
    "name" String ""
    "validFrom" String "2020-11-08T00:00:00"
    "expiration" String "2021-11-08T00:00:00"
    "shared" Boolean false
    "keyId" String "null"
    "productType" String "null"
)

CREATE
(
    parent "SCU_Top:ManagedElement=1,SCU_Top:SystemFunctions=1,SCU_Lm:Lm=1"
    identity "$count"
	moType SCU_Lm:FeatureState
	exception none
    nrOfAttributes 7
    "featureStateId" String "$count"
    "featureState" Integer 0
    "licenseState" Integer 0
    "serviceState" Integer 0
    "description" String ""
    "featureKey" Ref "null"
    "keyId" String ""
)
KSD
done

cat >> esc.mml << ABC
.open $simName
.select $nodeName
.start
kertayle:file="$Path/$nodeName.mo";
ABC
########################################################################
moFiles+=($nodeName.mo)
done

/netsim/inst/netsim_pipe < esc.mml
for filenum in ${moFiles[@]}
do
rm $filenum
done
rm esc.mml
echo "$0 ended at" $( date +%T );

