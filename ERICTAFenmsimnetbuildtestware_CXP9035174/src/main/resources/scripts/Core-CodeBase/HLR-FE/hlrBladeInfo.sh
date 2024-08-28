#!/bin/bash
########################################################################
# Version     : 18.12
# Revision    :
# Purpose     : Loads features for HLR nodes based on node type
# Description : Adding Blade information for BSP,IS and vHLR on HLR-FE nodes
# Date        : Jul 2018
# Who         : zyamkan
########################################################################
########################################################################
#Script Usage#
########################################################################
usage (){

echo "Usage  : $0 <sim name> "

echo "Example: $0 CORE-ST-HLR-16B-V4x1"

}
neType(){

echo "ERROR: The script runs only for HLR nodes"
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
#To check the if simname is HLR#
########################################################################
if [[ $simName != *"HLR"* ]]
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

CREATE
(
    parent "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:HardwareMgmt=1"
    identity "0.0.0.0"
    moType AxeEquipment:Shelf
    exception none
    nrOfAttributes 1
    "shelfId" String "0.0.0.0"
)

CREATE
(
    parent "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:HardwareMgmt=1,AxeEquipment:Shelf=0.0.0.0"
    identity "3"
    moType AxeEquipment:ApBlade
    exception none
    nrOfAttributes 4
    "apBladeId" String "3"
    "systemNumber" Uint16 0
    "side" Integer -1
    "functionalBoardName" Integer 300
)

SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:HardwareMgmt=1,AxeEquipment:Shelf=0.0.0.0,AxeEquipment:ApBlade=3,AxeEquipment:ApBladeInfo=1"
    exception none
    nrOfAttributes 13
    "apBladeInfoId" String "1"
    "temperatureStatus" Integer "null"
    "biosRunningMode" Integer "null"
    "storageStatus" Integer "null"
    "boardStatus" Integer "null"
    "alarmInterfaceStatus" Integer "null"
    "biosVersion" String ""
    "nicInfo" Array Struct 0
    "productInfo" Struct
        nrOfElements 6
        "productRevision" String ""
        "productName" String ""
        "manufacturingDate" String ""
        "productVendor" String ""
        "productNumber" String ""
        "serialNumber" String ""

    "operationalLed" Struct
        nrOfElements 3
        "colour" Integer 0
        "status" Integer 1
        "supported" Boolean true

    "faultLed" Struct
        nrOfElements 3
        "colour" Integer 0
        "status" Integer 1
        "supported" Boolean true

    "maintenanceLed" Struct
        nrOfElements 3
        "colour" Integer 0
        "status" Integer 1
        "supported" Boolean true

    "statusLed" Struct
        nrOfElements 3
        "colour" Integer 0
        "status" Integer 1
        "supported" Boolean true

)

CREATE
(
    parent "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:HardwareMgmt=1,AxeEquipment:Shelf=0.0.0.0"
    identity "1"
    moType AxeEquipment:ApBlade
    exception none
    nrOfAttributes 4
    "apBladeId" String "1"
    "systemNumber" Uint16 0
    "side" Integer -1
    "functionalBoardName" Integer 300
)

SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:HardwareMgmt=1,AxeEquipment:Shelf=0.0.0.0,AxeEquipment:ApBlade=1,AxeEquipment:ApBladeInfo=1"
    exception none
    nrOfAttributes 13
    "apBladeInfoId" String "1"
    "temperatureStatus" Integer "null"
    "biosRunningMode" Integer "null"
    "storageStatus" Integer "null"
    "boardStatus" Integer "null"
    "alarmInterfaceStatus" Integer "null"
    "biosVersion" String ""
    "nicInfo" Array Struct 0
    "productInfo" Struct
        nrOfElements 6
        "productRevision" String ""
        "productName" String ""
        "manufacturingDate" String ""
        "productVendor" String ""
        "productNumber" String ""
        "serialNumber" String ""

    "operationalLed" Struct
        nrOfElements 3
        "colour" Integer 0
        "status" Integer 1
        "supported" Boolean true

    "faultLed" Struct
        nrOfElements 3
        "colour" Integer 0
        "status" Integer 1
        "supported" Boolean true

    "maintenanceLed" Struct
        nrOfElements 3
        "colour" Integer 0
        "status" Integer 1
        "supported" Boolean true

    "statusLed" Struct
        nrOfElements 3
        "colour" Integer 0
        "status" Integer 1
        "supported" Boolean true

)

CREATE
(
    parent "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:HardwareMgmt=1,AxeEquipment:Shelf=0.0.0.0"
    identity "7"
    moType AxeEquipment:CpBlade
    exception none
    nrOfAttributes 13
    "cpBladeId" String "7"
    "cpArchitecture" Integer 0
    "systemNumber" Uint16 0
    "side" Integer -1
    "sequenceNumber" Int32 -1
    "ipAliasEthB" String "0.0.0.0"
    "ipAliasEthA" String "0.0.0.0"
    "ipAddressEthB" String "0.0.0.0"
    "ipAddressEthA" String "0.0.0.0"
    "functionalBoardName" Integer 200
    "aliasNetmaskEthB" String "0.0.0.0"
    "productInfo" Struct
        nrOfElements 6
        "productRevision" String ""
        "productName" String ""
        "manufacturingDate" String ""
        "productVendor" String ""
        "productNumber" String ""
        "serialNumber" String ""

    "aliasNetmaskEthA" String "0.0.0.0"
)

CREATE
(
    parent "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:HardwareMgmt=1,AxeEquipment:Shelf=0.0.0.0"
    identity "5"
    moType AxeEquipment:CpBlade
    exception none
    nrOfAttributes 13
    "cpBladeId" String ""
    "cpArchitecture" Integer 0
    "systemNumber" Uint16 0
    "side" Integer -1
    "sequenceNumber" Int32 -1
    "ipAliasEthB" String "0.0.0.0"
    "ipAliasEthA" String "0.0.0.0"
    "ipAddressEthB" String "0.0.0.0"
    "ipAddressEthA" String "0.0.0.0"
    "functionalBoardName" Integer 200
    "aliasNetmaskEthB" String "0.0.0.0"
    "productInfo" Struct
        nrOfElements 6
        "productRevision" String ""
        "productName" String ""
        "manufacturingDate" String ""
        "productVendor" String ""
        "productNumber" String ""
        "serialNumber" String ""

    "aliasNetmaskEthA" String "0.0.0.0"
)

CREATE
(
    parent "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:HardwareMgmt=1,AxeEquipment:Shelf=0.0.0.0"
    identity "13"
    moType AxeEquipment:CpBlade
    exception none
    nrOfAttributes 13
    "cpBladeId" String "13"
    "cpArchitecture" Integer 0
    "systemNumber" Uint16 0
    "side" Integer -1
    "sequenceNumber" Int32 -1
    "ipAliasEthB" String "0.0.0.0"
    "ipAliasEthA" String "0.0.0.0"
    "ipAddressEthB" String "0.0.0.0"
    "ipAddressEthA" String "0.0.0.0"
    "functionalBoardName" Integer 200
    "aliasNetmaskEthB" String "0.0.0.0"
    "productInfo" Struct
        nrOfElements 6
        "productRevision" String ""
        "productName" String ""
        "manufacturingDate" String ""
        "productVendor" String ""
        "productNumber" String ""
        "serialNumber" String ""

    "aliasNetmaskEthA" String "0.0.0.0"
)

CREATE
(
    parent "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:HardwareMgmt=1,AxeEquipment:Shelf=0.0.0.0"
    identity "11"
    moType AxeEquipment:CpBlade
    exception none
    nrOfAttributes 13
    "cpBladeId" String "11"
    "cpArchitecture" Integer 0
    "systemNumber" Uint16 0
    "side" Integer -1
    "sequenceNumber" Int32 -1
    "ipAliasEthB" String "0.0.0.0"
    "ipAliasEthA" String "0.0.0.0"
    "ipAddressEthB" String "0.0.0.0"
    "ipAddressEthA" String "0.0.0.0"
    "functionalBoardName" Integer 200
    "aliasNetmaskEthB" String "0.0.0.0"
    "productInfo" Struct
        nrOfElements 6
        "productRevision" String ""
        "productName" String ""
        "manufacturingDate" String ""
        "productVendor" String ""
        "productNumber" String ""
        "serialNumber" String ""

    "aliasNetmaskEthA" String "0.0.0.0"
)

CREATE
(
    parent "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:HardwareMgmt=1,AxeEquipment:Shelf=0.0.0.0"
    identity "9"
    moType AxeEquipment:CpBlade
    exception none
    nrOfAttributes 13
    "cpBladeId" String "9"
    "cpArchitecture" Integer 0
    "systemNumber" Uint16 0
    "side" Integer -1
    "sequenceNumber" Int32 -1
    "ipAliasEthB" String "0.0.0.0"
    "ipAliasEthA" String "0.0.0.0"
    "ipAddressEthB" String "0.0.0.0"
    "ipAddressEthA" String "0.0.0.0"
    "functionalBoardName" Integer 200
    "aliasNetmaskEthB" String "0.0.0.0"
    "productInfo" Struct
        nrOfElements 6
        "productRevision" String ""
        "productName" String ""
        "manufacturingDate" String ""
        "productVendor" String ""
        "productNumber" String ""
        "serialNumber" String ""

    "aliasNetmaskEthA" String "0.0.0.0"
)

CREATE
(
    parent "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:LogicalMgmt=1"
    identity "AP1"
    moType AxeEquipment:Apg
    exception none
    nrOfAttributes 2
    "apgId" String "AP1"
    "apBladesDn" Array Ref 0
)

SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:LogicalMgmt=1,AxeEquipment:Apg=AP1"
    exception none
    nrOfAttributes 1
    "apBladesDn" Array Ref 2
        ManagedElement=$nodeName,SystemFunctions=1,AxeFunctions=1,SystemComponentHandling=1,EquipmentM=1,HardwareMgmt=1,Shelf=0.0.0.0,ApBlade=3
        ManagedElement=$nodeName,SystemFunctions=1,AxeFunctions=1,SystemComponentHandling=1,EquipmentM=1,HardwareMgmt=1,Shelf=0.0.0.0,ApBlade=1
)

CREATE
(
    parent "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:LogicalMgmt=1,"
    identity "CP1"
    moType AxeEquipment:DualSidedCp
    exception none
    nrOfAttributes 6
    "dualSidedCpId" String "CP1"
    "apzSystem" String "0"
    "cpType" Uint16 "null"
    "cpBladesDn" Array Ref 0
    "cpAlias" String "-"
    "mauType" Integer 0
)

SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:LogicalMgmt=1,AxeEquipment:DualSidedCp=CP1,AxeEquipment:SwMau=1"
    exception none
    nrOfAttributes 3
    "swMauId" String "1"
    "administrativeState" Integer "null"
    "operationalState" Integer "null"
)

SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:LogicalMgmt=1,AxeEquipment:DualSidedCp=CP1"
    exception none
    nrOfAttributes 4
    "cpType" Uint16 21260
    "apzSystem" String "APZ21260"
    "mauType" Integer 2
    "cpBladesDn" Array Ref 2
        ManagedElement=$nodeName,SystemFunctions=1,AxeFunctions=1,SystemComponentHandling=1,EquipmentM=1,HardwareMgmt=1,Shelf=0.0.0.0,CpBlade=7
        ManagedElement=$nodeName,SystemFunctions=1,AxeFunctions=1,SystemComponentHandling=1,EquipmentM=1,HardwareMgmt=1,Shelf=0.0.0.0,CpBlade=5

)

SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:LogicalMgmt=1,AxeEquipment:DualSidedCp=CP1,AxeEquipment:SwMau=1"
    exception none
    nrOfAttributes 2
    "operationalState" Integer 1
    "administrativeState" Integer 1
)

SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:LogicalMgmt=1,AxeEquipment:CpCluster=1"
    exception none
    nrOfAttributes 6
    "reportProgress" Struct
        nrOfElements 5
        "state" Integer 2
        "reason" String ""
        "actionId" Integer 1
        "result" Integer 1
        "timeOfLastAction" String "2017-09-08 09:17:00"

    "operativeGroup" Array String 2
        "BC1"
        "BC2"
    "clusterOpMode" Integer 2
    "clockMaster" Uint16 1001
    "allBcGroup" Array String 2
        "BC1"
        "BC2"
    "alarmMaster" Uint16 1001
)

SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:LogicalMgmt=1,AxeEquipment:CpCluster=1,AxeEquipment:OmProfileManager=1"
    exception none
    nrOfAttributes 3
    "reportProgress" Struct
        nrOfElements 5
        "state" Integer 2
        "reason" String ""
        "actionId" Integer 2
        "result" Integer 1
        "timeOfLastAction" String "2017-12-04 18:37:35"

    "omProfile" String "PROFILE 709"
    "activeCcFile" String "7"
)

CREATE
(
    parent "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:LogicalMgmt=1,AxeEquipment:CpCluster=1,AxeEquipment:OmProfileManager=1,AxeEquipment:CcFileManager=1"
    identity "MmlCommandRules_709.xml"
    moType AxeEquipment:CandidateCcFile
    exception none
    nrOfAttributes 2
    "candidateCcFileId" String "MmlCommandRules_709.xml"
    "reportProgress" Struct
        nrOfElements 5
        "state" Integer 0
        "reason" String ""
        "actionId" Integer 0
        "result" Integer 3
        "timeOfLastAction" String ""

)

SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:LogicalMgmt=1,AxeEquipment:CpCluster=1,AxeEquipment:OmProfileManager=1,AxeEquipment:CcFileManager=1,AxeEquipment:CandidateCcFile=MmlCommandRules_709.xml"
    exception none
    nrOfAttributes 1
    "reportProgress" Struct
        nrOfElements 5
        "state" Integer 2
        "reason" String ""
        "actionId" Integer 5
        "result" Integer 1
        "timeOfLastAction" String "2017-12-04 15:33:23"

)

CREATE
(
    parent "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:LogicalMgmt=1,AxeEquipment:CpCluster=1,AxeEquipment:OmProfileManager=1,AxeEquipment:CcFileManager=1"
    identity "MmlCommandRules_703.xml"
    moType AxeEquipment:CandidateCcFile
    exception none
    nrOfAttributes 2
    "candidateCcFileId" String "MmlCommandRules_703.xml"
    "reportProgress" Struct
        nrOfElements 5
        "state" Integer 0
        "reason" String ""
        "actionId" Integer 0
        "result" Integer 3
        "timeOfLastAction" String ""

)

SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:LogicalMgmt=1,AxeEquipment:CpCluster=1,AxeEquipment:OmProfileManager=1,AxeEquipment:CcFileManager=1,AxeEquipment:CandidateCcFile=MmlCommandRules_703.xml"
    exception none
    nrOfAttributes 1
    "reportProgress" Struct
        nrOfElements 5
        "state" Integer 2
        "reason" String ""
        "actionId" Integer 5
        "result" Integer 1
        "timeOfLastAction" String "2017-11-01 16:33:14"

)

CREATE
(
    parent "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:LogicalMgmt=1,AxeEquipment:CpCluster=1,AxeEquipment:OmProfileManager=1,AxeEquipment:CcFileManager=1"
    identity "MmlCommandRules_100.xml"
    moType AxeEquipment:CandidateCcFile
    exception none
    nrOfAttributes 2
    "candidateCcFileId" String "MmlCommandRules_100.xml"
    "reportProgress" Struct
        nrOfElements 5
        "state" Integer 0
        "reason" String ""
        "actionId" Integer 0
        "result" Integer 3
        "timeOfLastAction" String ""

)

SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:LogicalMgmt=1,AxeEquipment:CpCluster=1,AxeEquipment:OmProfileManager=1,AxeEquipment:CcFileManager=1,AxeEquipment:CandidateCcFile=MmlCommandRules_100.xml"
    exception none
    nrOfAttributes 1
    "reportProgress" Struct
        nrOfElements 5
        "state" Integer 2
        "reason" String ""
        "actionId" Integer 5
        "result" Integer 1
        "timeOfLastAction" String "2017-09-08 09:09:02"

)

CREATE
(
    parent "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:LogicalMgmt=1,AxeEquipment:CpCluster=1,AxeEquipment:OmProfileManager=1"
    identity "709"
    moType AxeEquipment:OmProfile
    exception none
    nrOfAttributes 4
    "omProfileId" String "709"
    "apzProfile" String "-"
    "aptProfile" String "-"
    "state" Integer 0
)

SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:LogicalMgmt=1,AxeEquipment:CpCluster=1,AxeEquipment:OmProfileManager=1,AxeEquipment:OmProfile=709,AxeEquipment:CcFile=1"
    // moid = 161
    exception none
    nrOfAttributes 3
    "ccFileId" String "1"
    "state" Integer "null"
    "rulesVersion" String "null"
)

SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:LogicalMgmt=1,AxeEquipment:CpCluster=1,AxeEquipment:OmProfileManager=1,AxeEquipment:OmProfile=709"
    exception none
    nrOfAttributes 3
    "state" Integer 1
    "apzProfile" String "100"
    "aptProfile" String "709"
)

CREATE
(
    parent "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:LogicalMgmt=1,AxeEquipment:CpCluster=1,AxeEquipment:OmProfileManager=1,AxeEquipment:OmProfile=709"
    identity "7"
    moType AxeEquipment:CcFile
    exception none
    nrOfAttributes 3
    "ccFileId" String "7"
    "state" Integer "null"
    "rulesVersion" String "null"
)

SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:LogicalMgmt=1,AxeEquipment:CpCluster=1,AxeEquipment:OmProfileManager=1,AxeEquipment:OmProfile=709,AxeEquipment:CcFile=7"
    exception none
    nrOfAttributes 2
    "state" Integer 1
    "rulesVersion" String "HLRFE1.9_CM1744_HLRFE1.9_LSV0000_MSC18_CM1739_MSC17A_CM1645_MSC17A_LSV1605_MSC14B_CM1419_MSC14B_LSV1325_APZ24.0_CM002_APZ24.0_LSV0000_APZ23.0FD1_LSV09_APZ23.0FD1_LSV0000_APZ23.0_CM003_APZ23.0_LSV0000_APZ22.0_CM003_APZ22.0_LSV0000_APZ21.0_LSV00_2017-11-01_101019"
)

CREATE
(
    parent "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:LogicalMgmt=1,AxeEquipment:CpCluster=1,AxeEquipment:OmProfileManager=1,AxeEquipment:OmProfile=709"
    identity "6"
    moType AxeEquipment:CcFile
    exception none
    nrOfAttributes 3
    "ccFileId" String "6"
    "state" Integer "null"
    "rulesVersion" String "null"
)

SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:LogicalMgmt=1,AxeEquipment:CpCluster=1,AxeEquipment:OmProfileManager=1,AxeEquipment:OmProfile=709,AxeEquipment:CcFile=6"
    exception none
    nrOfAttributes 2
    "state" Integer 2
    "rulesVersion" String "HLRFE1.9_LSV1739_HLRFE1.9_LSV0000_MSC18_CM1739_MSC17A_CM1645_MSC17A_LSV1605_MSC14B_CM1419_MSC14B_LSV1325_APZ24.0_RM001_APZ24.0_LSV0000_APZ23.0FD1_LSV09_APZ23.0FD1_LSV0000_APZ23.0_CM003_APZ23.0_LSV0000_APZ22.0_CM003_APZ22.0_LSV0000_APZ21.0_LSV00_2017-10-02_134525"
)

CREATE
(
    parent "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:LogicalMgmt=1,AxeEquipment:CpCluster=1,AxeEquipment:OmProfileManager=1"
    identity "703"
    moType AxeEquipment:OmProfile
    exception none
    nrOfAttributes 4
    "omProfileId" String "703"
    "apzProfile" String "-"
    "aptProfile" String "-"
    "state" Integer 0
)

SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:LogicalMgmt=1,AxeEquipment:CpCluster=1,AxeEquipment:OmProfileManager=1,AxeEquipment:OmProfile=703,AxeEquipment:CcFile=1"
    exception none
    nrOfAttributes 3
    "ccFileId" String "1"
    "state" Integer "null"
    "rulesVersion" String "null"
)

SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:LogicalMgmt=1,AxeEquipment:CpCluster=1,AxeEquipment:OmProfileManager=1,AxeEquipment:OmProfile=703"
    exception none
    nrOfAttributes 3
    "state" Integer 2
    "apzProfile" String "100"
    "aptProfile" String "703"
)

SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:LogicalMgmt=1,AxeEquipment:CpCluster=1,AxeEquipment:OmProfileManager=1,AxeEquipment:OmProfile=703,AxeEquipment:CcFile=1"
    exception none
    nrOfAttributes 2
    "state" Integer 0
    "rulesVersion" String "HLRFE1.3_LSV1718_HLRFE1.3_LSV0000_MSC17A_CM1645_MSC17A_LSV1605_MSC14B_CM1419_MSC14B_LSV1325_APZ23.0_CM003_APZ23.0_LSV0000_APZ22.0_CM003_APZ22.0_LSV0000_APZ21.0_LSV00_2017-04-24_131014"
)

CREATE
(
    parent "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:LogicalMgmt=1,AxeEquipment:CpCluster=1,AxeEquipment:OmProfileManager=1"
    identity "100"
    moType AxeEquipment:OmProfile
    exception none
    nrOfAttributes 4
    "omProfileId" String "100"
    "apzProfile" String "-"
    "aptProfile" String "-"
    "state" Integer 0
)

SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:LogicalMgmt=1,AxeEquipment:CpCluster=1,AxeEquipment:OmProfileManager=1,AxeEquipment:OmProfile=100,AxeEquipment:CcFile=1"
    exception none
    nrOfAttributes 3
    "ccFileId" String "1"
    "state" Integer "null"
    "rulesVersion" String "null"
)

SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:LogicalMgmt=1,AxeEquipment:CpCluster=1,AxeEquipment:OmProfileManager=1,AxeEquipment:OmProfile=100"
    exception none
    nrOfAttributes 3
    "state" Integer 2
    "apzProfile" String "100"
    "aptProfile" String "100"
)

CREATE
(
    parent "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:LogicalMgmt=1,AxeEquipment:CpCluster=1"
    identity "BC2"
    moType AxeEquipment:ClusterCp
    exception none
    nrOfAttributes 5
    "clusterCpId" String "BC2"
    "cpBladesDn" Ref "null"
    "apzSystem" String "0"
    "cpType" Uint16 "null"
    "cpAlias" String "-"
)

SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:LogicalMgmt=1,AxeEquipment:CpCluster=1,AxeEquipment:ClusterCp=BC2"
    exception none
    nrOfAttributes 3
    "cpType" Uint16 21260
    "cpBladesDn" Ref "ManagedElement=$nodeName,SystemFunctions=1,AxeFunctions=1,SystemComponentHandling=1,EquipmentM=1,HardwareMgmt=1,Shelf=0.0.0.0,CpBlade=13"
    "apzSystem" String "APZ21410"
)

CREATE
(
    parent "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:LogicalMgmt=1,AxeEquipment:CpCluster=1"
    identity "BC1"
    moType AxeEquipment:ClusterCp
    exception none
    nrOfAttributes 5
    "clusterCpId" String "BC1"
    "cpBladesDn" Ref "null"
    "apzSystem" String "0"
    "cpType" Uint16 "null"
    "cpAlias" String "-"
)

SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,AxeFunctions:AxeFunctions=1,AxeFunctions:SystemComponentHandling=1,AxeEquipment:EquipmentM=1,AxeEquipment:LogicalMgmt=1,AxeEquipment:CpCluster=1,AxeEquipment:ClusterCp=BC1"
    exception none
    nrOfAttributes 3
    "cpType" Uint16 21260
    "cpBladesDn" Ref "ManagedElement=$nodeName,SystemFunctions=1,AxeFunctions=1,SystemComponentHandling=1,EquipmentM=1,HardwareMgmt=1,Shelf=0.0.0.0,CpBlade=11"
    "apzSystem" String "APZ21410"
)


DEF
########################################################################
#Making MML script#
########################################################################
cat >> hlr.mml << ABC
.open $simName
.select network
.start
.selectnetype HLR-FE-BSP*
.selectnetype HLR-FE-IS*
.selectnetype vHLR-BS*
kertayle:file="$Path/$nodeName.mo";
ABC
########################################################################
moFiles+=($nodeName.mo)
done

/netsim/inst/netsim_pipe < hlr.mml
for filenum in ${moFiles[@]}
do
rm $filenum
done
rm hlr.mml *.txt
echo "$0 ended at" $( date +%T );


