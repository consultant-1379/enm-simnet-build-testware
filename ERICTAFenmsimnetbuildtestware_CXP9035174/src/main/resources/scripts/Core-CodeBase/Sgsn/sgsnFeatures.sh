#!/bin/bash
########################################################################
# Version     : 1.3
# Revision    : CXP 903 5174-1-26
# Purpose     : Modifying attributes in NfServiceOperation MO
# Jira        : NSS-34037
# Date        : Feb 2021
# Who         : zsujmad
########################################################################
########################################################################
# Version     : 1.2
# Revision    : CXP 903 5174-1-25
# Purpose     : Modifying attributes in GwSelectionProfilesInfo MO
# Jira        : NSS-34500
# Date        : Feb 2021
# Who         : zsujmad
########################################################################
########################################################################
# Version     : 1.1
# Revision    : CXP 903 5174-1-20
# Purpose     : Updates ciphers
# Jira        : NSS-33178
# Date        : Nov 2020
# Who         : zhainic
########################################################################
########################################################################
#Script Usage#
########################################################################
usage (){

echo "Usage  : $0 <sim name> "

echo "Example: $0 CORE-ST-4.5K-SGSN-15B-CP01-V3x25"

}
neType(){

echo "ERROR: The script runs only for SGSN nodes"
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
baseName=$2
numOfNodes=`echo $simName|awk -F'x' '{print $NF}'`
Path=`pwd`
########################################################################
#To check the if simname is SGSN
########################################################################
if [[ $simName != *"SGSN"* ]]
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
CREATE
(
    parent "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmePMEventM:PmEventM=1"
    identity "EBM"
    moType SgsnMmePMEventM:EventProducer
    exception none
    nrOfAttributes 1
    "eventProducerId" String "EBM"
)

CREATE
(
    parent "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmePMEventM:PmEventM=1,SgsnMmePMEventM:EventProducer=EBM"
    identity "1"
    moType SgsnMmePMEventM:EventCapabilities
    exception none
    nrOfAttributes 2
    "eventCapabilitiesId" String "1"
    "maxNoOfJobs" Uint16 "null"
)

CREATE
(
    parent "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmePMEventM:PmEventM=1,SgsnMmePMEventM:EventProducer=EBM"
    identity "1"
    moType SgsnMmePMEventM:EventFilterType
    exception none
    nrOfAttributes 5
    "defaultValue" String "null"
    "description" String "null"
    "eventFilterTypeId" String "1"
    "filterMethod" Integer 0
    "valueSpec" String "null"
)

CREATE
(
    parent "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmePMEventM:PmEventM=1,SgsnMmePMEventM:EventProducer=EBM"
    identity "ASN.1"
    moType SgsnMmePMEventM:EventFilterType
    exception none
    nrOfAttributes 5
    "defaultValue" String "true"
    "description" String "null"
    "eventFilterTypeId" String "ASN.1"
    "filterMethod" Integer 0
    "valueSpec" String "null"
)

CREATE
(
    parent "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmePMEventM:PmEventM=1,SgsnMmePMEventM:EventProducer=EBM"
    identity "UeFraction"
    moType SgsnMmePMEventM:EventFilterType
    exception none
    nrOfAttributes 5
    "defaultValue" String "500"
    "description" String "null"
    "eventFilterTypeId" String "UeFraction"
    "filterMethod" Integer 0
    "valueSpec" String "null"
)

CREATE
(
    parent "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmePMEventM:PmEventM=1,SgsnMmePMEventM:EventProducer=EBM"
    identity "1"
    moType SgsnMmePMEventM:EventGroup
    exception none
    nrOfAttributes 2
    "eventGroupId" String "1"
    "validFilters" Array Ref 0
)

CREATE
(
    parent "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmePMEventM:PmEventM=1,SgsnMmePMEventM:EventProducer=EBM,SgsnMmePMEventM:EventGroup=1"
    identity "1"
    moType SgsnMmePMEventM:EventType
    exception none
    nrOfAttributes 2
    "eventTypeId" String "1"
    "triggerDescription" String "N/A"
)

CREATE
(
    parent "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmePMEventM:PmEventM=1,SgsnMmePMEventM:EventProducer=EBM"
    identity "MmeEbmGroup"
    moType SgsnMmePMEventM:EventGroup
    exception none
    nrOfAttributes 2
    "eventGroupId" String "MmeEbmGroup"
    "validFilters" Array Ref 0
)

CREATE
(
    parent "SgsnMmeTop:ManagedElement= $nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmePMEventM:PmEventM=1,SgsnMmePMEventM:EventProducer=EBM,SgsnMmePMEventM:EventGroup=MmeEbmGroup"
    identity "1"
    moType SgsnMmePMEventM:EventType
    exception none
    nrOfAttributes 1
    "eventTypeId" String "1"
)

CREATE
(
    parent "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmePMEventM:PmEventM=1,SgsnMmePMEventM:EventProducer=EBM,SgsnMmePMEventM:EventGroup=MmeEbmGroup"
    identity "L_ATTACH"
    moType SgsnMmePMEventM:EventType
    exception none
    nrOfAttributes 1
    "eventTypeId" String "L_ATTACH"
)

CREATE
(
    parent "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmePMEventM:PmEventM=1,SgsnMmePMEventM:EventProducer=EBM,SgsnMmePMEventM:EventGroup=MmeEbmGroup"
    identity "L_BEARER_MODIFY"
    moType SgsnMmePMEventM:EventType
    exception none
    nrOfAttributes 1
    "eventTypeId" String "L_BEARER_MODIFY"
)

CREATE
(
    parent "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmePMEventM:PmEventM=1,SgsnMmePMEventM:EventProducer=EBM,SgsnMmePMEventM:EventGroup=MmeEbmGroup"
    identity "L_CDMA2000"
    moType SgsnMmePMEventM:EventType
    exception none
    nrOfAttributes 1
    "eventTypeId" String "L_CDMA2000"
)

CREATE
(
    parent "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmePMEventM:PmEventM=1,SgsnMmePMEventM:EventProducer=EBM,SgsnMmePMEventM:EventGroup=MmeEbmGroup"
    identity "L_DEDICATED_BEARER_ACTIVATE"
    moType SgsnMmePMEventM:EventType
    exception none
    nrOfAttributes 1
    "eventTypeId" String "L_DEDICATED_BEARER_ACTIVATE"
)
CREATE
(
    parent "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmePMEventM:PmEventM=1,SgsnMmePMEventM:EventProducer=EBM,SgsnMmePMEventM:EventGroup=MmeEbmGroup"
    identity "L_DEDICATED_BEARER_DEACTIVATE"
    moType SgsnMmePMEventM:EventType
    exception none
    nrOfAttributes 1
    "eventTypeId" String "L_DEDICATED_BEARER_DEACTIVATE"
)

CREATE
(
    parent "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmePMEventM:PmEventM=1,SgsnMmePMEventM:EventProducer=EBM,SgsnMmePMEventM:EventGroup=MmeEbmGroup"
    identity "L_DETACH"
    moType SgsnMmePMEventM:EventType
    exception none
    nrOfAttributes 1
    "eventTypeId" String "L_DETACH" 
)

CREATE
(
    parent "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmePMEventM:PmEventM=1,SgsnMmePMEventM:EventProducer=EBM,SgsnMmePMEventM:EventGroup=MmeEbmGroup"
    identity "L_HANDOVER"
    moType SgsnMmePMEventM:EventType
    exception none
    nrOfAttributes 1
    "eventTypeId" String "L_HANDOVER"
)

CREATE
(
    parent "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmePMEventM:PmEventM=1,SgsnMmePMEventM:EventProducer=EBM,SgsnMmePMEventM:EventGroup=MmeEbmGroup"
    identity "L_PDN_CONNECT"
    moType SgsnMmePMEventM:EventType
    exception none
    nrOfAttributes 1
    "eventTypeId" String "L_PDN_CONNECT"
)

CREATE
(
    parent "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmePMEventM:PmEventM=1,SgsnMmePMEventM:EventProducer=EBM,SgsnMmePMEventM:EventGroup=MmeEbmGroup"
    identity "L_PDN_DISCONNECT"
    moType SgsnMmePMEventM:EventType
    exception none
    nrOfAttributes 1
    "eventTypeId" String "L_PDN_DISCONNECT"
)

CREATE
(
    parent "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmePMEventM:PmEventM=1,SgsnMmePMEventM:EventProducer=EBM,SgsnMmePMEventM:EventGroup=MmeEbmGroup"
    identity "L_SERVICE_REQUEST"
    moType SgsnMmePMEventM:EventType
    exception none
    nrOfAttributes 1
    "eventTypeId" String "L_SERVICE_REQUEST"
)

CREATE
(
    parent "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmePMEventM:PmEventM=1,SgsnMmePMEventM:EventProducer=EBM,SgsnMmePMEventM:EventGroup=MmeEbmGroup"
    identity "L_TAU"
    moType SgsnMmePMEventM:EventType
    exception none
    nrOfAttributes 1
    "eventTypeId" String "L_TAU"
)

CREATE
(
    parent "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmePMEventM:PmEventM=1,SgsnMmePMEventM:EventProducer=EBM"
    identity "SgsnEbmGroup"
    moType SgsnMmePMEventM:EventGroup
    exception none
    nrOfAttributes 2
    "eventGroupId" String "SgsnEbmGroup"
    "validFilters" Array Ref 0
)

CREATE
(
    parent "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmePMEventM:PmEventM=1,SgsnMmePMEventM:EventProducer=EBM,SgsnMmePMEventM:EventGroup=SgsnEbmGroup"
    identity "1"
    moType SgsnMmePMEventM:EventType
    exception none
    nrOfAttributes 1
    "eventTypeId" String "1"
    "triggerDescription" String "N/A"
)

CREATE
(
    parent "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmePMEventM:PmEventM=1,SgsnMmePMEventM:EventProducer=EBM,SgsnMmePMEventM:EventGroup=SgsnEbmGroup"
    identity "ACTIVATE"
    moType SgsnMmePMEventM:EventType
    exception none
    nrOfAttributes 1
    "eventTypeId" String "ACTIVATE"
)

CREATE
(
    parent "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmePMEventM:PmEventM=1,SgsnMmePMEventM:EventProducer=EBM,SgsnMmePMEventM:EventGroup=SgsnEbmGroup"
    identity "ATTACH"
    moType SgsnMmePMEventM:EventType
    exception none
    nrOfAttributes 1
    "eventTypeId" String "ATTACH"
)

CREATE
(
    parent "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmePMEventM:PmEventM=1,SgsnMmePMEventM:EventProducer=EBM,SgsnMmePMEventM:EventGroup=SgsnEbmGroup"
    identity "DEACTIVATE"
    moType SgsnMmePMEventM:EventType
    exception none
    nrOfAttributes 1
    "eventTypeId" String "DEACTIVATE"
)
CREATE
(
    parent "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmePMEventM:PmEventM=1,SgsnMmePMEventM:EventProducer=EBM,SgsnMmePMEventM:EventGroup=SgsnEbmGroup"
    identity "DETACH"
    moType SgsnMmePMEventM:EventType
    exception none
    nrOfAttributes 1
    "eventTypeId" String "DETACH"
)
CREATE
(
    parent "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmePMEventM:PmEventM=1,SgsnMmePMEventM:EventProducer=EBM,SgsnMmePMEventM:EventGroup=SgsnEbmGroup"
    identity "ISRAU"
    moType SgsnMmePMEventM:EventType
    exception none
    nrOfAttributes 1
    "eventTypeId" String "ISRAU"
)

CREATE
(
    parent "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmePMEventM:PmEventM=1,SgsnMmePMEventM:EventProducer=EBM,SgsnMmePMEventM:EventGroup=SgsnEbmGroup"
    identity "RAU"
    moType SgsnMmePMEventM:EventType
    exception none
    nrOfAttributes 1
    "eventTypeId" String "RAU"
)
CREATE
(
    parent "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmePMEventM:PmEventM=1,SgsnMmePMEventM:EventProducer=EBM,SgsnMmePMEventM:EventGroup=SgsnEbmGroup"
    identity "SERVICE_REQUEST"
    moType SgsnMmePMEventM:EventType
    exception none
    nrOfAttributes 1
    "eventTypeId" String "SERVICE_REQUEST"
)
CREATE
(
    parent "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmePMEventM:PmEventM=1,SgsnMmePMEventM:EventProducer=EBM"
    identity "EbmLog"
    moType SgsnMmePMEventM:EventJob
    exception none
    nrOfAttributes 14
    "currentJobState" Integer 2
    "description" String "null"
    "eventGroupRef" Array Ref 0
    "eventJobId" String "EbmLog"
    "eventTypeRef" Array Ref 0
    "fileCompressionType" Integer 0
    "fileOutputEnabled" Boolean true
    "jobControl" Integer 0
    "reportingPeriod" Integer 5
    "requestedJobState" Integer 2
    "streamCompressionType" Integer 0
    "streamDestinationIpAddress" String "null"
    "streamDestinationPort" Uint16 "null"
    "streamOutputEnabled" Boolean false
)

CREATE
(
    parent "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmePMEventM:PmEventM=1,SgsnMmePMEventM:EventProducer=EBM"
    identity "EbmStream"
    moType SgsnMmePMEventM:EventJob
    exception none
    nrOfAttributes 14
    "currentJobState" Integer 2
    "description" String "null"
    "eventGroupRef" Array Ref 0
    "eventJobId" String "EbmStream"
    "eventTypeRef" Array Ref 0
    "fileCompressionType" Integer 0
    "fileOutputEnabled" Boolean false
    "jobControl" Integer 0
    "reportingPeriod" Integer 3
    "requestedJobState" Integer 2
    "streamCompressionType" Integer 0
    "streamDestinationIpAddress" String "null"
    "streamDestinationPort" Uint16 "null"
    "streamOutputEnabled" Boolean true
)

CREATE
(
    parent "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmePMEventM:PmEventM=1,SgsnMmePMEventM:EventProducer=EBM"
    identity "1"
    moType SgsnMmePMEventM:FilePullCapabilities
    exception none
    nrOfAttributes 6
    "alignedReportingPeriod" Boolean true
    "filePullCapabilitiesId" String "1"
    "finalROP" Boolean false
    "outputDirectory" String "/tmp/OMS_LOGS/ebs/ready"
    "supportedCompressionTypes" Array Integer 1
         0
    "supportedReportingPeriods" Array Integer 5
         3
         4
         5
         6
         7
)

CREATE
(
    parent "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmePMEventM:PmEventM=1,SgsnMmePMEventM:EventProducer=EBM"
    identity "1"
    moType SgsnMmePMEventM:StreamingCapabilities
    exception none
    nrOfAttributes 2
    "streamCapabilitiesId" String "1"
    "supportedCompressionTypes" Array Integer 1
         0
)
SET
(
    mo "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmeBRM:BrM=1,SgsnMmeBRM:BrmBackupManager=1"
    exception none
    nrOfAttributes 2
    "backupDomain" String "System Local"
    "backupType" String "System Local Data"
)
SET
(
    mo "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmeBRM:BrM=1,SgsnMmeBRM:BrmBackupManager=1,SgsnMmeBRM:BrmBackupLabelStore=1"
    exception none
    nrOfAttributes 6
    "restoreEscalationList" Array String 1
        "1"
    "lastRestoredBackup" String "${nodeName}_Restored"
    "lastImportedBackup" String "${nodeName}_Imported"
    "lastExportedBackup" String "${nodeName}_Exported"
    "lastCreatedBackup" String "${nodeName}_Created"
    "brmBackupLabelStoreId" String "1"
)
SET
(
    mo "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmeBRM:BrM=1,SgsnMmeBRM:BrmBackupManager=1,SgsnMmeBRM:BrmBackup=1"
    exception none
    nrOfAttributes 3
    "swVersion" Array Struct 1
        nrOfElements 6
        "productName" String "$nodeName"
        "productNumber" String "$productNumber"
        "productRevision" String "$productRevision"
        "productionDate" String "2015-09-18"
        "description" String "SGSNMME"
        "type" String "SGSNMME"
    "backupName" String "$nodeName"
    "creationTime" String "2015-09-18T11:03:20"
)
SET
(
     mo "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmeBRM:BrM=1,SgsnMmeBRM:BrmBackupManager=1,SgsnMmeBRM:BrmBackupHousekeeping=1"
     exception none
     nrOfAttributes 2
     brmBackupHousekeepingId String "1"
    "maxStoredManualBackups" Uint16 100
)
SET
(
    mo "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmeSwIM:SwInventory=1"
    exception none
    nrOfAttributes 1
    "userLabel" String "$nodeName"
)
SET
(
    mo "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmeSwIM:SwInventory=1,SgsnMmeSwIM:SwVersion=1"
    exception none
    nrOfAttributes 1
    "userLabel" String "$nodeName"
    "timeOfInstallation" String "2015-09-18T11:03:20"
    "timeOfDeactivation" String "2015-09-18T11:03:20"
    "timeOfActivation" String "2015-09-18T11:03:20"
    "administrativeData" Struct
        nrOfElements 6
        "productName" String "$nodeName"
        "productNumber" String "$productNumber"
        "productRevision" String "$productRevision"
        "productionDate" String "2016-03-02"
        "description" String "SGSNMME"
        "type" String "SGSNMME"
)
SET
(
    mo "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmeSwIM:SwInventory=1,SgsnMmeSwIM:SwItem=1"
    exception none
    nrOfAttributes 1
    "userLabel" String "$nodeName"
    "administrativeData" Struct
        nrOfElements 7
        "productName" String "$nodeName"
        "productNumber" String "$productNumber"
        "productRevision" String "$productRevision"
        "productionDate" String "2016-03-02"
        "description" String "SGSNMME"
        "type" String "SGSNMME"
	"additionalInfo" String "$nodeName"
)

SET
(
    mo "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmeSysM:SysM=1"
    exception none
    nrOfAttributes 1
    "userLabel" String "$nodeName"
)
SET
(
    mo "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmePM:Pm=1,SgsnMmePM:PmMeasurementCapabilities=1"
    exception none
    nrOfAttributes 2
    "producesUtcRopFiles" Boolean false
    "fileLocation" String "/c/pm_data"
    "supportedCompressionTypes" Array Integer 1
         0
)
CREATE
(
     parent "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmeHwIM:HwInventory=1"
     identity "1"
     moType SgsnMmeHwIM:HwItem
     exception none
     nrOfAttributes 12
     "hwItemId" String "1"
     "vendorName" String "Ericsson"
     "hwModel" String "${nodeName}-2"
     "hwType" String "Blade"
     "hwName" String "GEP3-24GB"
     "equipmentMoRef" Array Ref 0
     "manualDataEntry" Integer 1
     "serialNumber" String "A064688920"
     "dateOfManufacture" String "2011-19-10T04-04-04.666+09:00"
     "swInvMoRef" Array Ref 0
     "licMgmtMoRef" Array Ref 0
     "productIdentity" Struct
	 nrOfElements 3
	 "productNumber" String "$productNumber"
	 "productRevision" String "$productRevision"
	 "productDesignation" String "${nodeName}-1"
)
CREATE
(
     parent "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmeHwIM:HwInventory=1"
     identity "2"
     moType SgsnMmeHwIM:HwItem
     exception none
     nrOfAttributes 12
     "hwItemId" String "2"
     "vendorName" String "Ericsson"
     "hwModel" String "${nodeName}-2"
     "hwType" String "Blade"
     "hwName" String "GEP3-HD300"
     "equipmentMoRef" Array Ref 0
     "manualDataEntry" Integer 1
     "serialNumber" String "A064681011"
     "dateOfManufacture" String "2011-19-10T04-04-04.666+09:00"
     "swInvMoRef" Array Ref 0
     "licMgmtMoRef" Array Ref 0
     "productIdentity" Struct
	nrOfElements 3
	"productNumber" String "$productNumber"
	"productRevision" String "$productRevision"
	"productDesignation" String "${nodeName}-2"
)
CREATE
(
     parent "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmeHwIM:HwInventory=1"
     identity "3"
     moType SgsnMmeHwIM:HwItem
     exception none
     nrOfAttributes 12
     "hwItemId" String "3"
     "vendorName" String "Ericsson"
     "hwModel" String "${nodeName}-2"
     "hwType" String "Blade"
     "hwName" String "SCXB2"
     "equipmentMoRef" Array Ref 0
     "manualDataEntry" Integer 1
     "serialNumber" String "A064688935"
     "dateOfManufacture" String "2011-19-10T04-04-04.666+09:00"
     "swInvMoRef" Array Ref 0
     "licMgmtMoRef" Array Ref 0
     "productIdentity" Struct
	nrOfElements 3
	"productNumber" String "$productNumber"
	"productRevision" String "$productRevision"
	"productDesignation" String "${nodeName}-3"
)
CREATE
(
    parent "SgsnMmeTop:ManagedElement=$nodeName,Sgsn_Mme:SgsnMme=1"
    identity "cell_trace_ueid_mapping"
    moType Sgsn_Mme:NodeFunction
    exception none
    nrOfAttributes 3
    "functionName" String "cell_trace_ueid_mapping"
    "functionState" String "off"
    "white" Ref "null"
)
CREATE
(
    parent "SgsnMmeTop:ManagedElement=$nodeName,SgsnMmeTop:SystemFunctions=1,SgsnMmeLM:Lm=1,SgsnMmeLM:KeyFileManagement=1"
    moType SgsnMmeLM:KeyFileInformation
        identity 1
    exception none
    nrOfAttributes 6
    "keyFileInformationId" String "1"
    "sequenceNumber" Int32 0
    "installationTime" String "2017-10-10T12:29:40"
    "locatable" Boolean true
    "productType" String "SGSN-MME ELIM 2"
    "softwareLicenseTargetIdentity" String "null"
) 
SET
(
    mo "SgsnMmeTop:ManagedElement=$nodeName,Sgsn_Mme:SgsnMme=1,Sgsn_Mme:SctpSys=1,Sgsn_Mme:SctpEndPoint=1"
    exception none
    nrOfAttributes 1
    "sctpEndPointNo" Uint8 1
)
SET
(
    mo "ManagedElement=$nodeName"
    exception none
    nrOfAttributes 1
    "dateTimeOffset" String "+01:00"
)
SET
(
    mo "ManagedElement=$nodeName,SystemFunctions=1,SwM=1,UpgradePackage=1"
    exception none
    nrOfAttributes 1
    "administrativeData" Array Struct 1
        nrOfElements 6
        "productName" String "$nodeName"
        "productNumber" String "$productNumber"
        "productRevision" String "$productRevision"
        "productionDate" String "2016-06-21T14:29:10"
        "description" String "$nodeName"
        "type" String "N/A"

)
SET
(
    mo "SgsnMmeTop:ManagedElement=$nodeName,Sgsn_Mme:SgsnMme=1,Sgsn_Mme:GwLoad=1,Sgsn_Mme:GwLoadInfo=1"
    // moid = 2389
    exception none
    nrOfAttributes 1
    "gwIdentifier" String "abc123"
)
SET
(
    mo "SgsnMmeTop:ManagedElement=$nodeName,Sgsn_Mme:SgsnMme=1,Sgsn_Mme:SbiHttpClientConnection=1"
    exception none
    nrOfAttributes 1
    "nfType" String "AMF"
)
SET
(
    mo "SgsnMmeTop:ManagedElement=$nodeName,Sgsn_Mme:SgsnMme=1,Sgsn_Mme:SbiHttpClientConnection=1"
    exception none
    nrOfAttributes 1
    "serviceName" String "namf_communication"
)
SET
(
    mo "SgsnMmeTop:ManagedElement=$nodeName,Sgsn_Mme:SgsnMme=1,Sgsn_Mme:EnGnodeb=1,Sgsn_Mme:ConnectedGlobalEnodeb=1"
    exception none
    nrOfAttributes 1
    "globalEngNBId" String "1"
)

SET
(
    mo "SgsnMmeTop:ManagedElement=$nodeName,Sgsn_Mme:SgsnMme=1,Sgsn_Mme:GwOverload=1,Sgsn_Mme:GwOverloadInfo=1"
    exception none
    nrOfAttributes 1
    "gwIdentifierForOverloadCtrl" String "1"
)
SET
(
    mo "SgsnMmeTop:ManagedElement=$nodeName,Sgsn_Mme:SgsnMme=1,Sgsn_Mme:GwSelectionProfiles=1,Sgsn_Mme:GwSelectionProfilesInfo=1"
    // moid = 2942
    exception none
    nrOfAttributes 1
    "uutListForGwSelection" String "123"
)

SET
(
    mo "SgsnMmeTop:ManagedElement=$nodeName,Sgsn_Mme:SgsnMme=1,Sgsn_Mme:GwSelectionProfiles=1,Sgsn_Mme:GwSelectionProfilesInfo=1"
    // moid = 2942
    exception none
    nrOfAttributes 1
    "ueN1Mode5GsSubs" String "n1_ue_with_5gs_subs"
)

SET
(
    mo "SgsnMmeTop:ManagedElement=$nodeName,Sgsn_Mme:SgsnMme=1,Sgsn_Mme:GwSelectionProfiles=1,Sgsn_Mme:GwSelectionProfilesInfo=1"
    // moid = 2942
    exception none
    nrOfAttributes 1
    "endcAllowedForUe" String "endc_allowed"
)

SET
(
    mo "SgsnMmeTop:ManagedElement=$nodeName,Sgsn_Mme:SgsnMme=1,Sgsn_Mme:NE=1"
    // moid = 2038
    exception none
    nrOfAttributes 2
    "nbrActAttachedSubL" Uint32 1894227
    "nbrActAttachedSubG" Uint32 80041
)
SET
(
    mo "SgsnMmeTop:ManagedElement=$nodeName,Sgsn_Mme:SgsnMme=1,Sgsn_Mme:NfServiceOperation=1"
    exception none
    nrOfAttributes 3
    "serviceOperation" String "1"
    "serviceName" String "1"
    "nfType" String "1"
)
SET
(
    mo "SgsnMmeTop:ManagedElement=$nodeName,Sgsn_Mme:SgsnMme=1,Sgsn_Mme:SbiClientProfiles=1,Sgsn_Mme:SbiClientProfilesInfo=1"
    exception none
    nrOfAttributes 1
    "sbiClientProfileListName" String "xyz"
)
SET
(
    mo "SgsnMmeTop:ManagedElement=$nodeName,Sgsn_Mme:SgsnMme=1,Sgsn_Mme:AMF=1,Sgsn_Mme:NfCache=1"
    // moid = 3265
    exception none
    nrOfAttributes 2
    "serviceInstanceId" String "ServiceId"
    "nfInstanceIdFull" String "nfInstanceIdFullshouldhaveatleast36c"
)
DELETE
(
  mo "SgsnMmeTop:ManagedElement=$nodeName,Sgsn_Mme:SgsnMme=1,Sgsn_Mme:TraceCollectionIpv6server=1"
)
DELETE
(
  mo "SgsnMmeTop:ManagedElement=$nodeName,Sgsn_Mme:SgsnMme=1,Sgsn_Mme:TraceCollectionServer=1"
)


DEF
###################### add all set kertayles before delete kertayles #######################
########################################################################
#Making MML script#
########################################################################
cat >> sgsn.mml << ABC
.open $simName
.select $nodeName
.start
kertayle:file="$Path/$nodeName.mo";
set_ecim_pm_reffileset_path:path="/dev/null";
setNode:type="ericsson";
setNode:status;

#--creation of netlog files
createlogfile:path="/tmp/OMS_LOGS/fm_alarm/ready/",logname ="fm_alarm.1";
createlogfile:path="/tmp/OMS_LOGS/fm_event/ready/",logname ="fm_event.1";
createlogfile:path="/tmp/DPE_COMMONLOG/NodeDump/",logname ="NodeDump";
createlogfile:path="/tmp/DPE_COMMONLOG/PDC/archive/",logname ="PDC";
createlogfile:path="/tmp/OMS_LOGS/mmi_log/ready/",logname ="mmi_log.1";
pmdata:disable;

#License support
.loadfile /netsim/inst/tsp/ecim/lm_ecim_A/ebin/installKeyFile#KeyFileManagement#tsp_ecim_A.beam
load:mod="installKeyFile#KeyFileManagement#tsp_ecim_A";

ABC
########################################################################
moFiles+=($nodeName.mo)
done

/netsim/inst/netsim_pipe < sgsn.mml
for filenum in ${moFiles[@]}
do
rm $filenum
done
rm sgsn.mml
echo "$0 ended at" $( date +%T );

