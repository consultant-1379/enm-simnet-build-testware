#!/bin/bash
########################################################################
# Version6    : 22.03
# Revision    : CXP 903 5174-1-56
# Purpose     : Create etherport mo for interface
# Description : creates interfaces
# Date        : dec 2021
# Who         : zsivtar
########################################################################
# Version5    : 21.15
# Revision    : CXP 903 5174-1-33
# Purpose     : Corrected Certs for Controller
# Description : Sets certs
# Date        : Aug 2021
# Who         : zhainic
########################################################################
########################################################################
# Version5    : 21.08
# Revision    : CXP 903 5174-1-32
# Purpose     : To create HcRules
# Description : Creates HcRule MOs under HealthCheckM MO
# Date        : Apr 2021
# Who         : zsujmad
########################################################################
########################################################################
# Version4    : 21.06
# Revision    : CXP 903 5174-1-25
# Purpose     : Added Support for UnitTemperatureLevelLog
# Description : Added Support for UnitTemperatureLevelLog
# Date        : Feb 2021
# Who         : zsujmad
########################################################################
########################################################################
# Version3    : 21.05
# Revision    : CXP 903 5174-1-23
# Purpose     : Added Security Support
# Description : Configured SecM, SysM and Pm MOs
# Date        : Feb 2021
# Who         : zsujmad
########################################################################
########################################################################
# Version2    : 21.04
# Revision    : CXP 903 5174-1-22
# Purpose     : Changed FieldReplaceableUnit value
# Description : Creates Mos and sets attributes
# Date        : Jan 2021
# Who         : zsujmad
########################################################################
########################################################################
# Version1    : 21.04
# Revision    : CXP 903 5174-1-21
# Purpose     : Loads features for Controller nodes based on node type
# Description : Creates Mos and sets attributes
# Date        : Jan 2021
# Who         : zsujmad
########################################################################
########################################################################
#Script Usage#
########################################################################
usage (){

echo "Usage  : $0 <sim name> "

echo "Example: $0 CONTROLLER6610-20-Q4-V1x2-Transport121"

}
neType(){

echo "ERROR: The script runs only for Controller nodes"
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
time=`date '+%FT04:04:04.666%:z'`
########################################################################
#To check if the simname is Controller#
########################################################################
if [[ $simName != *"CONTROLLER"* ]]
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
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,RcsBrM:BrM=1,RcsBrM:BrmBackupManager=1"
    exception none
    nrOfAttributes 2
    "backupType" String "Systemdata"
    "backupDomain" String "System"
)
SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,RcsBrM:BrM=1,RcsBrM:BrmBackupManager=1,RcsBrM:BrmBackupLabelStore=1"
    exception none
    nrOfAttributes 4
    "lastRestoredBackup" String "${nodeName}_Restored"
    "lastImportedBackup" String "${nodeName}_Imported"
    "lastExportedBackup" String "${nodeName}_Exported"
    "lastCreatedBackup" String "${nodeName}_Created"
)
SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,RcsBrM:BrM=1,RcsBrM:BrmBackupManager=1,RcsBrM:BrmBackup=1"
    exception none
    nrOfAttributes 3
    "backupName" String "1"
    "creationType" Integer 3
    "creationTime" String "$time"
    "swVersion" Array Struct 1
        nrOfElements 6
        "productName" String "Controller"
        "productNumber" String "$productNumber"
        "productRevision" String "$productRevision"
        "productionDate" String "$time"
        "description" String "SW package for system release 20.Q2"
        "type" String "Controller6610"

)
SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,RcsFm:Fm=1"
    exception none
    nrOfAttributes 3
    "lastSequenceNo" Uint64 4
    "lastChanged" String "$time"
    "heartbeatInterval" Uint32 100
)
SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,RcsFm:Fm=1,RcsFm:FmAlarmModel=1,RcsFm:FmAlarmType=1"
    // moid = 304
    exception none
    nrOfAttributes 9
    "specificProblem" String "Alternate Oam Connection In Use"
    "probableCause" Uint32 305
    "moClasses" String "OamAccessPoint"
    "minorType" Uint32 9175162
    "majorType" Uint32 193
    "isStateful" Boolean true
    "fmAlarmTypeId" String "AlternateOAMConnectionInUse"
    "eventType" Integer 2
    "additionalText" String "A management session is utilizing the alternate connection service"
)
SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,RcsHcm:HealthCheckM=1"
    // moid = 300
    exception none
    nrOfAttributes 1
    "lastStatus" Integer 3
)
SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,RcsHwIM:HwInventory=1"
    // moid = 298
    exception none
    nrOfAttributes 1
    "timeOfLatestInvChange" String "$time"
)
SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,RcsLM:Lm=1"
    // moid = 287
    exception none
    nrOfAttributes 5
    "lmState" Integer 1
    "lastLicenseInventoryRefresh" String "$time"
    "lastInventoryChange" String "$time"
    "fingerprintUpdateable" Boolean false
    "fingerprint" String "G2_CI_MSR"
)
CREATE
(
    parent "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,RcsLM:Lm=1"
    // moid = 410
    identity "1"
    moType RcsLM:CapacityKey
    exception none
    nrOfAttributes 11
    "capacityKeyId" String "1"
)
SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,RcsLM:Lm=1,RcsLM:CapacityKey=1"
    // moid = 410
    exception none
    nrOfAttributes 9
    "validFrom" String "2020-06-22T00:00:00"
    "state" Ref "ManagedElement=$nodeName,SystemFunctions=1,Lm=1,CapacityState=1"
    "productType" String "Baseband"
    "licensedCapacityLimitReached" Boolean false
    "licensedCapacityLimit" Struct
        nrOfElements 2
        "value" Int32 9999
        "noLimit" Boolean false

    "keyId" String "1"
    "grantedCapacityLevel" Int32 9999
    "expiration" String "2021-06-21T00:00:00"
    "capacityKeyId" String "1"
)
CREATE
(
    parent "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,RcsLM:Lm=1"
    // moid = 411
    identity "1"
    moType RcsLM:CapacityState
    exception none
    nrOfAttributes 11
    "capacityStateId" String "1"
)
SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,RcsLM:Lm=1,RcsLM:CapacityState=1"
    // moid = 411
    exception none
    nrOfAttributes 7
    "serviceState" Integer 1
    "licenseState" Integer 1
    "licensedCapacityLimitReached" Boolean false
    "keyId" String "1"
    "grantedCapacityLevel" Int32 250
    "currentCapacityLimit" Struct
        nrOfElements 2
        "value" Int32 250
        "noLimit" Boolean false
    "capacityKey" Array Ref 1
        ManagedElement=$nodeName,SystemFunctions=1,Lm=1,CapacityKey=1
)
SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,RcsLM:Lm=1,RcsLM:EmergencyUnlock=1"
    // moid = 293
    exception none
    nrOfAttributes 1
    "activationsLeft" Uint8 2
)
SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,RcsLM:Lm=1,RcsLM:KeyFileManagement=1"
    // moid = 288
    exception none
    nrOfAttributes 1
    "reportProgress" Struct
        nrOfElements 11
        "actionName" String "installKeyFile"
        "additionalInfo" Array String 1
        "Installing Key File"
        "progressInfo" String "Key File Installed"
        "progressPercentage" Uint8 100
        "result" Integer 1
        "resultInfo" String "Key File installed successfully"
        "state" Integer 1
        "actionId" Uint16 1
        "timeActionStarted" String "2020-10-13T12:52:00"
        "timeActionCompleted" String "2020-10-13T12:53:12"
        "timeOfLastStatusUpdate" String "2020-10-13T12:53:12"

)
SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,RcsLM:Lm=1,RcsLM:KeyFileManagement=1,RcsLM:KeyFileInformation=1"
    // moid = 289
    exception none
    nrOfAttributes 3
    "sequenceNumber" Int32 1001
    "productType" String "Baseband"
    "installationTime" String "$time"
)
CREATE
(
        parent "ManagedElement=$nodeName,SystemFunctions=1,LogM=1"
        moType RcsLogM:Log
        identity AiLog
        exception none
        nrOfAttributes 1
        "logId" String "AiLog"
)
CREATE
(
        parent "ManagedElement=$nodeName,SystemFunctions=1,LogM=1"
        moType RcsLogM:Log
        identity HealthCheckLog
        exception none
        nrOfAttributes 1
        "logId" String "HealthCheckLog"
)
CREATE
(
        parent "ManagedElement=$nodeName,SystemFunctions=1,LogM=1"
        moType RcsLogM:Log
        identity AlertLog
        exception none
        nrOfAttributes 1
        "logId" String "AlertLog"
)
CREATE
(
        parent "ManagedElement=$nodeName,SystemFunctions=1,LogM=1"
        moType RcsLogM:Log
        identity AlarmLog
        exception none
        nrOfAttributes 1
        "logId" String "AlarmLog"
)
CREATE
(
        parent "ManagedElement=$nodeName,SystemFunctions=1,LogM=1"
        moType RcsLogM:Log
        identity AuditTrailLog
        exception none
        nrOfAttributes 1
        "logId" String "AuditTrailLog"
)
CREATE
(
        parent "ManagedElement=$nodeName,SystemFunctions=1,LogM=1"
        moType RcsLogM:Log
        identity SecurityLog
        exception none
        nrOfAttributes 1
        "logId" String "SecurityLog"
)
CREATE
(
        parent "ManagedElement=$nodeName,SystemFunctions=1,LogM=1"
        moType RcsLogM:Log
        identity SwmLog
        exception none
        nrOfAttributes 1
        "logId" String "SwmLog"
)
CREATE
(
        parent "ManagedElement=$nodeName,SystemFunctions=1,LogM=1"
        moType RcsLogM:Log
        identity TnApplicationLog
        exception none
        nrOfAttributes 1
        "logId" String "TnApplicationLog"
)
CREATE
(
        parent "ManagedElement=$nodeName,SystemFunctions=1,LogM=1"
        moType RcsLogM:Log
        identity TnNetworkLog
        exception none
        nrOfAttributes 1
        "logId" String "TnNetworkLog"
)
CREATE
(
        parent "ManagedElement=$nodeName,SystemFunctions=1,LogM=1"
        moType RcsLogM:Log
        identity BatteryLog
        exception none
        nrOfAttributes 1
        "logId" String "BatteryLog"
)
CREATE
(
        parent "ManagedElement=$nodeName,SystemFunctions=1,LogM=1"
        moType RcsLogM:Log
        identity ClimateLog
        exception none
        nrOfAttributes 1
        "logId" String "ClimateLog"
)
CREATE
(
        parent "ManagedElement=$nodeName,SystemFunctions=1,LogM=1"
        moType RcsLogM:Log
        identity HWInvHistoryLog
        exception none
        nrOfAttributes 1
        "logId" String "HWInvHistoryLog"
)
CREATE
(
        parent "ManagedElement=$nodeName,SystemFunctions=1,LogM=1"
        moType RcsLogM:Log
        identity PowerDistributionLog
        exception none
        nrOfAttributes 1
        "logId" String "PowerDistributionLog"
)
CREATE
(
        parent "ManagedElement=$nodeName,SystemFunctions=1,LogM=1"
        moType RcsLogM:Log
        identity PowerSupplyLog
        exception none
        nrOfAttributes 1
        "logId" String "PowerSupplyLog"
)
CREATE
(
        parent "ManagedElement=$nodeName,SystemFunctions=1,LogM=1"
        moType RcsLogM:Log
        identity SupportUnitLog
        exception none
        nrOfAttributes 1
        "logId" String "SupportUnitLog"
)
CREATE
(
        parent "ManagedElement=$nodeName,SystemFunctions=1,LogM=1"
        moType RcsLogM:Log
        identity SwErrorAlarmLog
        exception none
        nrOfAttributes 1
        "logId" String "SwErrorAlarmLog"
)
CREATE
(
        parent "ManagedElement=$nodeName,SystemFunctions=1,LogM=1"
        moType RcsLogM:Log
        identity VesLog
        exception none
        nrOfAttributes 1
        "logId" String "VesLog"
)
CREATE
(
        parent "ManagedElement=$nodeName,SystemFunctions=1,LogM=1"
        moType RcsLogM:Log
        identity UnitTemperatureLevelLog
        exception none
        nrOfAttributes 1
        "logId" String "UnitTemperatureLevelLog"
)
SET
(
    mo "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,CertM=1,CertMCapabilities=1"
    exception none
    nrOfAttributes 2
    "fingerprintSupport" Integer 0
    "enrollmentSupport" Array Integer 3
         0
         1
         3
)
CREATE
(
    parent "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,RcsSwIM:SwInventory=1"
    // moid = 408
        identity "1"
        moType RcsSwIM:SwItem
    exception none
    nrOfAttributes 1
    "swItemId" String "1"
)
CREATE
(
    parent "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,RcsSwIM:SwInventory=1"
    // moid = 409
        identity "1"
        moType RcsSwIM:SwVersion
    exception none
    nrOfAttributes 1
    "swVersionId" String "1"
)
SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,RcsSwIM:SwInventory=1,RcsSwIM:SwItem=1"
    // moid = 44
    exception none
    nrOfAttributes 3
    "consistsOf" Array Ref 1
        ManagedElement=$nodeName,SystemFunctions=1,SwInventory=1,SwVersion=1
    "administrativeData" Struct
        nrOfElements 6
        "productName" String "FRUDESCRIPTIONFILEAPC"
        "productNumber" String "$productNumber"
        "productRevision" String "$productRevision"
        "productionDate" String "$time"
        "description" String "FRUDESCRIPTIONFILEAPC load module container (LMC)"
        "type" String "For the RBS Control System, compiled for arch=aarch64, os=linux, ltt=sdk"
    "additionalInfo" String "Item is included in active SwVersion"
)
SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,RcsSwIM:SwInventory=1,RcsSwIM:SwVersion=1"
    // moid = 43
    exception none
    nrOfAttributes 4
    "timeOfInstallation" String "$time"
    "timeOfActivation" String "$time"
    "consistsOf" Array Ref 1
        ManagedElement=$nodeName,SystemFunctions=1,SwInventory=1,SwItem=1
    "administrativeData" Struct
        nrOfElements 6
        "productName" String "Controller"
        "productNumber" String "$productNumber"
        "productRevision" String "$productRevision"
        "productionDate" String "$time"
        "description" String "SW package for system release 20.Q2"
        "type" String "Controller6610"
)
SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,RcsSwIM:SwInventory=1"
    // moid = 42
    exception none
    nrOfAttributes 1
    "active" Array Ref 1
        ManagedElement=$nodeName,SystemFunctions=1,SwInventory=1,SwVersion=1
)
SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,RcsSwM:SwM=1"
    // moid = 40
    exception none
    nrOfAttributes 2
    "timeRemainingBeforeFallback" Int16 -1
    "timeoutFallbackCapability" Integer 1
)
SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,RcsSwM:SwM=1,RcsSwM:UpgradePackage=1"
    // moid = 41
    exception none
    nrOfAttributes 4
    "state" Integer 7
    "created" String "$time"
    "administrativeData" Array Struct 1
        nrOfElements 6
        "productName" String "Controller"
        "productNumber" String "$productNumber"
        "productRevision" String "$productRevision"
        "productionDate" String "$time"
        "description" String "SW package for system release 20.Q2"
        "type" String "Controller6610"
    "activationStep" Array Struct 1
        nrOfElements 3
        "serialNumber" Int16 1
        "name" String "Activate"
        "description" String "Activates this upgrade package"

)
SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,RcsSysM:SysM=1"
    exception none
    nrOfAttributes 1
    "userLabel" String "value"
)
CREATE
(
    parent "ComTop:ManagedElement=$nodeName,ComTop:Transport=1"
    // moid = 397
    identity "TN_B"
    moType RtnL2EthernetPort_SSC:EthernetPort
    exception none
    nrOfAttributes 12
    "administrativeState" Integer 0
    "admOperatingMode" Integer 1
    "autoNegEnable" Boolean true
    "availabilityStatus" Array Integer 0
    "encapsulation" Ref ""
    "ethernetPortId" String "TN_B"
    "holdDownTimer" Uint32 "null"
    "mtu" Int32 0
    "operationalState" Integer 0
    "operOperatingMode" Integer 1
    "reservedBy" Array Ref 0
    "userLabel" String "null"
)
CREATE
(
    parent "ComTop:ManagedElement=$nodeName,ComTop:Transport=1"
    // moid = 397
    identity "TN_A"
    moType RtnL2EthernetPort_SSC:EthernetPort
    exception none
    nrOfAttributes 12
    "administrativeState" Integer 0
    "admOperatingMode" Integer 1
    "autoNegEnable" Boolean true
    "availabilityStatus" Array Integer 0
    "encapsulation" Ref ""
    "ethernetPortId" String "TN_A"
    "holdDownTimer" Uint32 "null"
    "mtu" Int32 0
    "operationalState" Integer 0
    "operOperatingMode" Integer 5
    "reservedBy" Array Ref 0
    "userLabel" String "null"
)
CREATE
(
    parent "ComTop:ManagedElement=$nodeName,ComTop:Transport=1"
    // moid = 397
    identity "TN_C"
    moType RtnL2EthernetPort_SSC:EthernetPort
    exception none
    nrOfAttributes 12
    "administrativeState" Integer 0
    "admOperatingMode" Integer 1
    "autoNegEnable" Boolean true
    "availabilityStatus" Array Integer 0
    "encapsulation" Ref ""
    "ethernetPortId" String "TN_C"
    "holdDownTimer" Uint32 "null"
    "mtu" Int32 0
    "operationalState" Integer 0
    "operOperatingMode" Integer 6
    "reservedBy" Array Ref 0
    "userLabel" String "null"
)
CREATE
(
    parent "ComTop:ManagedElement=$nodeName"
    // moid = 393
    identity "1"
    moType ResEquipmentSupportFunction:EquipmentSupportFunction
    exception none
    nrOfAttributes 6
    "equipmentSupportFunctionId" String "1"
    "autoCreateUnits" Boolean true
    "supportSystemControl" Boolean true
    "reservedBy" Array Ref 0
    "userLabel" String "null"
    "release" String "Not known"
)
SET
(
    mo "ComTop:ManagedElement=$nodeName,ReqEquipment:Equipment=1"
    // moid = 11
    exception none
    nrOfAttributes 1
    "userLabel" String "Equip_1"
)
CREATE
(
    parent "ComTop:ManagedElement=$nodeName,ReqEquipment:Equipment=1"
    // moid = 398
    identity "1"
    moType ReqFieldReplaceableUnit:FieldReplaceableUnit
    exception none
    nrOfAttributes 20
    "fieldReplaceableUnitId" String "1"
    "administrativeState" Integer 0
    "operationalState" Integer 1
    "availabilityStatus" Array Integer 0
    "climateZoneRef" Ref "null"
    "operationalIndicator" Integer 3
    "statusIndicator" Integer 2
    "faultIndicator" Integer 2
    "maintenanceIndicator" Integer 2
    "productData" Struct
        nrOfElements 5
        "productionDate" String "20200629"
        "productName" String "C6610"
        "productNumber" String "$productNumber"
        "productRevision" String "$productRevision"
        "serialNumber" String "E23B594023"

    "userLabel" String "null"
    "reservedBy" Array Ref 0
    "hwTestResult" Struct
        nrOfElements 2
        "timeStamp" String "$time"
        "hwTestStatus" Integer 1

    "specialIndicator" Array Struct 0
    "positionRef" Ref "null"
    "positionInformation" Array String 0
    "supportUnitRef" Array Ref 0
    "positionCoordinates" Struct
        nrOfElements 4
        "altitude" Int32 0
        "geoDatum" String "WGS84"
        "latitude" Int32 0
        "longitude" Int32 0

    "isSharedWithExternalMe" Boolean "false"
    "floorInformation" Struct
        nrOfElements 2
        "floorNumber" Int16 -101
        "heightOfDot" Int16 -1

)
CREATE
(
    parent "ComTop:ManagedElement=$nodeName,ReqEquipment:Equipment=1,ReqFieldReplaceableUnit:FieldReplaceableUnit=1"
    // moid = 405
    identity "1"
    moType ReqSerialPort:SerialPort
    exception none
    nrOfAttributes 3
    "serialPortId" String "1"
    "userLabel" String "null"
    "reservedBy" Array Ref 0
)
CREATE
(
    parent "ComTop:ManagedElement=$nodeName,ReqEquipment:Equipment=1,ReqFieldReplaceableUnit:FieldReplaceableUnit=1"
    // moid = 406
    identity "2"
    moType ReqSerialPort:SerialPort
    exception none
    nrOfAttributes 3
    "serialPortId" String "2"
    "userLabel" String "null"
    "reservedBy" Array Ref 0
)
CREATE
(
    parent "ComTop:ManagedElement=$nodeName,ReqEquipment:Equipment=1,ReqFieldReplaceableUnit:FieldReplaceableUnit=1"
    // moid = 407
    identity "TN_B"
    moType ReqTnPort_SSC:TnPort
    exception none
    nrOfAttributes 3
    "reservedBy" Array Ref 1
        ManagedElement=$nodeName,Transport=1,EthernetPort=TN_B
    "tnPortId" String "TN_B"
    "userLabel" String "null"
)
SET
(
    mo "ComTop:ManagedElement=$nodeName,ReqEquipment:Equipment=1,ReqFieldReplaceableUnit:FieldReplaceableUnit=1"
    // moid = 398
    exception none
    nrOfAttributes 1
    "reservedBy" Array Ref 1
        ManagedElement=$nodeName,SystemFunctions=1,HwInventory=1,HwItem=1
)
SET
(
    mo "ComTop:ManagedElement=$nodeName,RmeSupport:NodeSupport=1"
    // moid = 2
    exception none
    nrOfAttributes 1
    "release" String "R1A16"
)

SET
(
    mo "ComTop:ManagedElement=$nodeName,RmeSupport:NodeSupport=1,RmeAI:AutoProvisioning=1"
    // moid = 9
    exception none
    nrOfAttributes 1
    "rbsConfigLevel" Integer 4
)
SET
(
    mo "ComTop:ManagedElement=$nodeName,RmeSupport:NodeSupport=1,RmeLicenseSupport:LicenseSupport=1,RmeLicenseSupport:InstantaneousLicensing=1"
    // moid = 8
    exception none
    nrOfAttributes 3
    "swltId" String "G2_CI_MSR_DUS32_200623"
    "euft" String "946060"
    "availabilityStatus" Array Integer 1
         5
)
SET
(
    mo "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,Ssh=1"
    exception none
    nrOfAttributes 6
    "supportedKeyExchanges" Array String 10
        ecdh-sha2-nistp384
        ecdh-sha2-nistp521
        ecdh-sha2-nistp256
        diffie-hellman-group-exchange-sha256
        diffie-hellman-group16-sha512
        diffie-hellman-group18-sha512
        diffie-hellman-group14-sha256
        diffie-hellman-group14-sha1
        diffie-hellman-group-exchange-sha1
        diffie-hellman-group1-sha1
    "supportedCiphers" Array String 9
        aes256-gcm@openssh.com
        aes256-ctr
        aes192-ctr
        aes128-gcm@openssh.com
        aes128-ctr
        AEAD_AES_256_GCM
        AEAD_AES_128_GCM
        aes128-cbc
        3des-cbc
    "supportedMacs" Array String 5
        hmac-sha2-256
        hmac-sha2-512
        hmac-sha1
        AEAD_AES_128_GCM
        AEAD_AES_256_GCM
    "selectedKeyExchanges" Array String 10
        ecdh-sha2-nistp384
        ecdh-sha2-nistp521
        ecdh-sha2-nistp256
        diffie-hellman-group-exchange-sha256
        diffie-hellman-group16-sha512
        diffie-hellman-group18-sha512
        diffie-hellman-group14-sha256
        diffie-hellman-group14-sha1
        diffie-hellman-group-exchange-sha1
        diffie-hellman-group1-sha1
    "selectedCiphers" Array String 9
        aes256-gcm@openssh.com
        aes256-ctr
        aes192-ctr
        aes128-gcm@openssh.com
        aes128-ctr
        AEAD_AES_256_GCM
        AEAD_AES_128_GCM
        aes128-cbc
        3des-cbc
    "selectedMacs" Array String 5
        hmac-sha2-256
        hmac-sha2-512
        hmac-sha1
        AEAD_AES_128_GCM
        AEAD_AES_256_GCM
)
SET
(
    mo "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,Tls=1"
    exception none
    nrOfAttributes 2
    "supportedCiphers" Array Struct 49
        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH"
        "authentication" String "aRSA"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "ECDHE-RSA-AES256-GCM-SHA384"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH"
        "authentication" String "aECDSA"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "ECDHE-ECDSA-AES256-GCM-SHA384"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA384"
        "export" String ""
        "name" String "ECDHE-RSA-AES256-SHA384"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH"
        "authentication" String "aECDSA"
        "encryption" String "AES"
        "mac" String "SHA384"
        "export" String ""
        "name" String "ECDHE-ECDSA-AES256-SHA384"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDHE-RSA-AES256-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH"
        "authentication" String "aECDSA"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDHE-ECDSA-AES256-SHA"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kDH"
        "authentication" String "aDSS"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "DHE-DSS-AES256-GCM-SHA384"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kDH"
        "authentication" String "aRSA"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "DHE-RSA-AES256-GCM-SHA384"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kDH"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "DHE-RSA-AES256-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kDH"
        "authentication" String "aDSS"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "DHE-DSS-AES256-SHA256"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kDH"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "DHE-RSA-AES256-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kDH"
        "authentication" String "aDSS"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "DHE-DSS-AES256-SHA"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH/RSA"
        "authentication" String "aECDH"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "ECDH-RSA-AES256-GCM-SHA384"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH/ECDSA"
        "authentication" String "aECDH"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "ECDH-ECDSA-AES256-GCM-SHA384"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH/RSA"
        "authentication" String "aECDH"
        "encryption" String "AES"
        "mac" String "SHA384"
        "export" String ""
        "name" String "ECDH-RSA-AES256-SHA384"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH/ECDSA"
        "authentication" String "aECDH"
        "encryption" String "AES"
        "mac" String "SHA384"
        "export" String ""
        "name" String "ECDH-ECDSA-AES256-SHA384"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH/RSA"
        "authentication" String "aECDH"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDH-RSA-AES256-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH/ECDSA"
        "authentication" String "aECDH"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDH-ECDSA-AES256-SHA"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kRSA"
        "authentication" String "aRSA"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "AES256-GCM-SHA384"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kRSA"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "AES256-SHA256"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kRSA"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "AES256-SHA"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH"
        "authentication" String "aRSA"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "ECDHE-RSA-AES128-GCM-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH"
        "authentication" String "aECDSA"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "ECDHE-ECDSA-AES128-GCM-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "ECDHE-RSA-AES128-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH"
        "authentication" String "aECDSA"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "ECDHE-ECDSA-AES128-SHA256"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDHE-RSA-AES128-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH"
        "authentication" String "aECDSA"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDHE-ECDSA-AES128-SHA"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kDH"
        "authentication" String "aDSS"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "DHE-DSS-AES128-GCM-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kDH"
        "authentication" String "aRSA"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "DHE-RSA-AES128-GCM-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kDH"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "DHE-RSA-AES128-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kDH"
        "authentication" String "aDSS"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "DHE-DSS-AES128-SHA256"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kDH"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "DHE-RSA-AES128-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kDH"
        "authentication" String "aDSS"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "DHE-DSS-AES128-SHA"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH/RSA"
        "authentication" String "aECDH"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "ECDH-RSA-AES128-GCM-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH/ECDSA"
        "authentication" String "aECDH"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "ECDH-ECDSA-AES128-GCM-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH/RSA"
        "authentication" String "aECDH"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "ECDH-RSA-AES128-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH/ECDSA"
        "authentication" String "aECDH"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "ECDH-ECDSA-AES128-SHA256"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH/RSA"
        "authentication" String "aECDH"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDH-RSA-AES128-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH/ECDSA"
        "authentication" String "aECDH"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDH-ECDSA-AES128-SHA"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kRSA"
        "authentication" String "aRSA"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "AES128-GCM-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kRSA"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "AES128-SHA256"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kRSA"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "AES128-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH"
        "authentication" String "aRSA"
        "encryption" String "3DES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDHE-RSA-DES-CBC3-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH"
        "authentication" String "aECDSA"
        "encryption" String "3DES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDHE-ECDSA-DES-CBC3-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kDH"
        "authentication" String "aRSA"
        "encryption" String "3DES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "EDH-RSA-DES-CBC3-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kDH"
        "authentication" String "aDSS"
        "encryption" String "3DES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "EDH-DSS-DES-CBC3-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH/RSA"
        "authentication" String "aECDH"
        "encryption" String "3DES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDH-RSA-DES-CBC3-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH/ECDSA"
        "authentication" String "aECDH"
        "encryption" String "3DES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDH-ECDSA-DES-CBC3-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kRSA"
        "authentication" String "aRSA"
        "encryption" String "3DES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "DES-CBC3-SHA"

    "enabledCiphers" Array Struct 49
        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH"
        "authentication" String "aRSA"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "ECDHE-RSA-AES256-GCM-SHA384"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH"
        "authentication" String "aECDSA"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "ECDHE-ECDSA-AES256-GCM-SHA384"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA384"
        "export" String ""
        "name" String "ECDHE-RSA-AES256-SHA384"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH"
        "authentication" String "aECDSA"
        "encryption" String "AES"
        "mac" String "SHA384"
        "export" String ""
        "name" String "ECDHE-ECDSA-AES256-SHA384"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDHE-RSA-AES256-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH"
        "authentication" String "aECDSA"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDHE-ECDSA-AES256-SHA"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kDH"
        "authentication" String "aDSS"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "DHE-DSS-AES256-GCM-SHA384"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kDH"
        "authentication" String "aRSA"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "DHE-RSA-AES256-GCM-SHA384"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kDH"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "DHE-RSA-AES256-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kDH"
        "authentication" String "aDSS"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "DHE-DSS-AES256-SHA256"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kDH"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "DHE-RSA-AES256-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kDH"
        "authentication" String "aDSS"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "DHE-DSS-AES256-SHA"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH/RSA"
        "authentication" String "aECDH"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "ECDH-RSA-AES256-GCM-SHA384"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH/ECDSA"
        "authentication" String "aECDH"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "ECDH-ECDSA-AES256-GCM-SHA384"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH/RSA"
        "authentication" String "aECDH"
        "encryption" String "AES"
        "mac" String "SHA384"
        "export" String ""
        "name" String "ECDH-RSA-AES256-SHA384"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH/ECDSA"
        "authentication" String "aECDH"
        "encryption" String "AES"
        "mac" String "SHA384"
        "export" String ""
        "name" String "ECDH-ECDSA-AES256-SHA384"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH/RSA"
        "authentication" String "aECDH"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDH-RSA-AES256-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH/ECDSA"
        "authentication" String "aECDH"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDH-ECDSA-AES256-SHA"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kRSA"
        "authentication" String "aRSA"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "AES256-GCM-SHA384"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kRSA"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "AES256-SHA256"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kRSA"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "AES256-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH"
        "authentication" String "aRSA"
        "encryption" String "3DES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDHE-RSA-DES-CBC3-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH"
        "authentication" String "aECDSA"
        "encryption" String "3DES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDHE-ECDSA-DES-CBC3-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kDH"
        "authentication" String "aRSA"
        "encryption" String "3DES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "EDH-RSA-DES-CBC3-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kDH"
        "authentication" String "aDSS"
        "encryption" String "3DES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "EDH-DSS-DES-CBC3-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH/RSA"
        "authentication" String "aECDH"
        "encryption" String "3DES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDH-RSA-DES-CBC3-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH/ECDSA"
        "authentication" String "aECDH"
        "encryption" String "3DES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDH-ECDSA-DES-CBC3-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kRSA"
        "authentication" String "aRSA"
        "encryption" String "3DES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "DES-CBC3-SHA"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH"
        "authentication" String "aRSA"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "ECDHE-RSA-AES128-GCM-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH"
        "authentication" String "aECDSA"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "ECDHE-ECDSA-AES128-GCM-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "ECDHE-RSA-AES128-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH"
        "authentication" String "aECDSA"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "ECDHE-ECDSA-AES128-SHA256"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDHE-RSA-AES128-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH"
        "authentication" String "aECDSA"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDHE-ECDSA-AES128-SHA"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kDH"
        "authentication" String "aDSS"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "DHE-DSS-AES128-GCM-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kDH"
        "authentication" String "aRSA"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "DHE-RSA-AES128-GCM-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kDH"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "DHE-RSA-AES128-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kDH"
        "authentication" String "aDSS"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "DHE-DSS-AES128-SHA256"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kDH"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "DHE-RSA-AES128-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kDH"
        "authentication" String "aDSS"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "DHE-DSS-AES128-SHA"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH/RSA"
        "authentication" String "aECDH"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "ECDH-RSA-AES128-GCM-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH/ECDSA"
        "authentication" String "aECDH"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "ECDH-ECDSA-AES128-GCM-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH/RSA"
        "authentication" String "aECDH"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "ECDH-RSA-AES128-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH/ECDSA"
        "authentication" String "aECDH"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "ECDH-ECDSA-AES128-SHA256"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH/RSA"
        "authentication" String "aECDH"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDH-RSA-AES128-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH/ECDSA"
        "authentication" String "aECDH"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDH-ECDSA-AES128-SHA"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kRSA"
        "authentication" String "aRSA"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "AES128-GCM-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kRSA"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "AES128-SHA256"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kRSA"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "AES128-SHA"

)
CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LdapAuthenticationMethod=1"
    identity "1"
    moType Ldap
    exception none
    nrOfAttributes 1
    "ldapId" String "1"
)
SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,RcsHwIM:HwInventory=1,RcsHwIM:HwItem=1"
    // moid = 299
    exception none
    nrOfAttributes 9
    "vendorName" String "Ericsson"
    "serialNumber" String "E23B594023"
    "productIdentity" Struct
        nrOfElements 3
        "productNumber" String "$productNumber"
        "productRevision" String "$productRevision"
        "productDesignation" String "C6610"

    "productData" Struct
        nrOfElements 6
        "productName" String "C6610"
        "productNumber" String "$productNumber"
        "productRevision" String "$productRevision"
        "productionDate" String "$time"
        "description" String ""
        "type" String "FieldReplaceableUnit"

    "hwType" String "FieldReplaceableUnit"
    "hwModel" String "C6610"
    "hwCapability" String "C6610"
    "equipmentMoRef" Array Ref 1
        ManagedElement=$nodeName,Equipment=1,FieldReplaceableUnit=1
    "dateOfManufacture" String "$time"
)
SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,RcsPm:Pm=1,RcsPm:PmMeasurementCapabilities=1"
    exception none
    nrOfAttributes 1
     "fileLocation" String "/c/pm_data/"
)
SET
(
    mo "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,RcsPMEventM:PmEventM=1,RcsPMEventM:EventProducer=1,RcsPMEventM:FilePullCapabilities=1"
    exception none
    nrOfAttributes 1
       "outputDirectory" String "/c/pm_data/"
)
CREATE
(
    parent "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,RcsHcm:HealthCheckM=1"
    identity "SystemFunction_CheckDiskSpace"
    moType RcsHcm:HcRule
    exception none
    nrOfAttributes 9
    "administrativeState" Integer 1
    "severity" Integer 1
    "recommendedAction" String "Check Backups on disk as well as the Log size. Export and remove backups. Export logs before they are truncated by the system. Follow the instructions for the 'Archive Disk Almost Full' alarm OPI."
    "name" String "Check disk space"
    "inputParameters" Array Struct 2
        nrOfElements 3
        "name" String "inclusion"
        "value" String "INCLUDED"
        "description" String "Indicates whether the rule shall be included or excluded when executing an HcJob. Value range: {INCLUDED, EXCLUDED}."

        nrOfElements 3
        "name" String "severity"
        "value" String "CRITICAL"
        "description" String "Configured severity for the rule. Value range: {CRITICAL, WARNING}."

    "hcRuleId" String "SystemFunction_CheckDiskSpace"
    "description" String "Check for the available space on the archive disk."
    "categoryList" Array Struct 2
        nrOfElements 2
        "category" String "ALL"
        "description" String "Includes all the rules provided by the node."

        nrOfElements 2
        "category" String "PREINSTALL"
        "description" String "Includes the rules to execute before SW installation."

    "categories" Array Integer 2
         5
         10
)
CREATE
(
    parent "ComTop:ManagedElement=$nodeName,ComTop:SystemFunctions=1,RcsHcm:HealthCheckM=1"
    identity "SystemFunction_CheckNumberUP"
    moType RcsHcm:HcRule
    exception none
    nrOfAttributes 9
    "administrativeState" Integer 1
    "severity" Integer 0
    "recommendedAction" String "Check the number of Upgrade Packages on disk. Remove unused packages. Follow the instructions for the 'Archive Disk Almost Full' alarm OPI."
    "name" String "Check number of UPs"
    "inputParameters" Array Struct 2
        nrOfElements 3
        "name" String "inclusion"
        "value" String "INCLUDED"
        "description" String "Indicates whether the rule shall be included or excluded when executing an HcJob. Value range: {INCLUDED, EXCLUDED}."

        nrOfElements 3
        "name" String "severity"
        "value" String "CRITICAL"
        "description" String "Configured severity for the rule. Value range: {CRITICAL, WARNING}."

    "hcRuleId" String "SystemFunction_CheckNumberUP"
    "description" String "Check for the number of Upgrade Packages on the disk."
    "categoryList" Array Struct 2
        nrOfElements 2
        "category" String "ALL"
        "description" String "Includes all the rules provided by the node."

        nrOfElements 2
        "category" String "PREINSTALL"
        "description" String "Includes the rules to execute before SW installation."

    "categories" Array Integer 2
         5
         10
)
DEF
########################################################################
#Making MML script#
########################################################################
cat >> controller.mml << ABC
.open $simName
.select $nodeName
.start
kertayle:file="$Path/$nodeName.mo";
ABC
########################################################################
moFiles+=($nodeName.mo)
done

/netsim/inst/netsim_pipe < controller.mml
for filenum in ${moFiles[@]}
do
rm $filenum
done
rm controller.mml
echo "$0 ended at" $( date +%T );
