#!/bin/bash
########################################################################
# Version     : 16.16
# Revision    : CXP 903 5174-1-1
# Purpose     : Loads features for MGw nodes
# Description : Creates MOs and sets attributes
# Date        : Oct 2016
# Who         : xgouhar
########################################################################
########################################################################
#Script Usage#
########################################################################
usage (){

echo "Usage  : $0 <sim name> "

echo "Example: $0 CORE-3K-ST-MGw-C1203-16Ax20 "

}
neType(){

echo "ERROR: The script runs only for epg and vepg nodes"
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
mimData=`echo $simName|awk -F'-' '{print $5}' | awk -F 'C' '{print $2}'`
mimVersion="$(echo $mimData | head -c 1)"
mimRelease="$(echo $mimData | cut -c 2-)"
########################################################################
#To check the if simname MGw
########################################################################
if [[ $simName != *"MGw"* ]]
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
    parent "ManagedElement=1,SwManagement=1"
    identity "1453304053819153"
    moType LoadModule
    exception none
    nrOfAttributes 14
    "LoadModuleId" String "1453304053819153"
    "productData" Struct
        nrOfElements 5
        "productNumber" String "$productNumber"
        "productRevision" String "$productRevision"
        "productName" String "${nodeName}_1"
        "productInfo" String "${nodeName}_1"
        "productionDate" String "2016-03-11"

    "loadModuleFilePath" String "/c/$nodeName"
    "loaderType" Integer 0
    "preLoad" Integer 0
    "oseProgramLoadClass" Integer 500
    "isDirectory" Boolean false
    "oseProgramPoolSize" Integer 0
    "oseProgramHeapSize" Integer 0
    "programMustBeSingleton" Boolean false
    "moppletEntries" Array String 0
    "reservedByUpgradePackage" Boolean false
    "fileState" Integer 0
    "isSignedSw" Boolean false
)
CREATE
(
    parent "ManagedElement=1,SwManagement=1"
    identity "1453304053900794"
    moType LoadModule
    exception none
    nrOfAttributes 14
    "LoadModuleId" String "1453304053900794"
    "productData" Struct
        nrOfElements 5
        "productNumber" String "$productNumber"
        "productRevision" String "$productRevision"
        "productName" String "${nodeName}_2"
        "productInfo" String "${nodeName}_2"
        "productionDate" String "2016-03-11"

    "loadModuleFilePath" String "/c/$nodeName"
    "loaderType" Integer 0
    "preLoad" Integer 0
    "oseProgramLoadClass" Integer 500
    "isDirectory" Boolean false
    "oseProgramPoolSize" Integer 0
    "oseProgramHeapSize" Integer 0
    "programMustBeSingleton" Boolean false
    "moppletEntries" Array String 0
    "reservedByUpgradePackage" Boolean false
    "fileState" Integer 0
    "isSignedSw" Boolean false
)
CREATE
(
    parent "ManagedElement=1,SwManagement=1"
    identity "1453304053965888"
    moType LoadModule
    exception none
    nrOfAttributes 14
    "LoadModuleId" String "1453304053965888"
    "productData" Struct
        nrOfElements 5
        "productNumber" String "$productNumber"
        "productRevision" String "$productRevision"
        "productName" String "${nodeName}_3"
        "productInfo" String "${nodeName}_3"
        "productionDate" String "2016-03-11"

    "loadModuleFilePath" String "/c/$nodeName"
    "loaderType" Integer 0
    "preLoad" Integer 0
    "oseProgramLoadClass" Integer 500
    "isDirectory" Boolean false
    "oseProgramPoolSize" Integer 0
    "oseProgramHeapSize" Integer 0
    "programMustBeSingleton" Boolean false
    "moppletEntries" Array String 0
    "reservedByUpgradePackage" Boolean false
    "fileState" Integer 0
    "isSignedSw" Boolean false
)
SET
(
    mo "ManagedElement=1,SwManagement=1,ConfigurationVersion=1"
    exception none
    nrOfAttributes 7
    "storedConfigurationVersions" Array Struct 1
        nrOfElements 8
        "name" String "BACKUP$nodeName"
        "identity" String "TESTID$nodeName"
        "type" String "STANDARD"
        "upgradePackageId" String "${nodeName}_Upgrade"
        "operatorName" String "administrator"
        "operatorComment" String "TestBackup"
        "date" String "2016-11-03"
        "status" String "OK"
    "startableConfigurationVersion" String "BACKUP$nodeName"
	"userLabel" String "BackupInventoryInENM"
	"lastCreatedCv" String "BACKUP$nodeName"
	"executingCv" String "BACKUP$nodeName"
	"rollbackList" Array String 1
        "BACKUP$nodeName"
	"currentUpgradePackage" Ref "ManagedElement=1,SwManagement=1,UpgradePackage=1"
)
SET
(
    mo "ManagedElement=1,SwManagement=1,UpgradePackage=1"
    exception none
    nrOfAttributes 3
    "state" Integer 7
    "administrativeData" Struct
        nrOfElements 5
        "productNumber" String "$productNumber"
        "productRevision" String "$productRevision"
        "productName" String "CXP${nodeName}1"
        "productInfo" String "CXP${nodeName}1"
        "productionDate" String "2016-03-11"
	"loadModuleList" Array Ref 3
        "ManagedElement=1,SwManagement=1,LoadModule=1453304053819153"
        "ManagedElement=1,SwManagement=1,LoadModule=1453304053900794"
        "ManagedElement=1,SwManagement=1,LoadModule=1453304053965888"
)
SET
(
    mo "ManagedElement=1"
    exception none
    nrOfAttributes 3
    "productRevision" String "$productRevision"
    "productNumber" String "$productNumber"
	"mimInfo" Struct
         nrOfElements 3
        "mimName" String "MGW_NODE_MODEL_C"
        "mimVersion" String "$mimVersion"
        "mimRelease" String "$mimRelease"
)

SET
(
    mo "ManagedElement=1,SystemFunctions=1,Licensing=1"
    exception none
    nrOfAttributes 1
    "fingerprint" String "${nodeName}_fp"
)
SET
(
    mo "ManagedElement=1,Equipment=1,Subrack=1"
    exception none
    nrOfAttributes 4
    "subrackPosition" String "$nodeName"
    "subrackNumber" Integer 1
    "operationalProductData" Struct
        nrOfElements 5
        "productName" String "$nodeName"
        "productNumber" String "$productNumber"
        "productRevision" String "$productRevision"
        "serialNumber" String "$nodeName"
        "productionDate" String "2016-03-11"

    "administrativeProductData" Struct
        nrOfElements 5
        "productNumber" String "$productNumber"
        "productRevision" String "$productRevision"
        "productName" String "$nodeName"
        "productInfo" String "$nodeName"
        "productionDate" String "$nodeName"

)
SET
(
    mo "ManagedElement=1,SwManagement=1"
    exception none
    nrOfAttributes 1
    "lastUpPiChange" String "160311-091541"
)
SET
(
    mo "ManagedElement=1,SystemFunctions=1,LogService=1"
    exception none
    nrOfAttributes 1
    "logs" Array String 5
        "SHELL_AUDITTRAIL_LOG"
        "CELLO_SECURITYEVENT_LOG"
        "CORBA_AUDITTRAIL_LOG"
        "CELLO_IPTRAN_LOG"
        "CELLO_IPTRAN_DEBUG_LOG"
)
DEF
for((k=1;k<=28;k++));
do
    cat >> $nodeName.mo << DEF
    SET
    (
        mo "ManagedElement=1,Equipment=1,Subrack=1,Slot=$k"
        exception none
        nrOfAttributes 1
        "productData" Struct
            nrOfElements 5
            "productName" String "$nodeName"
            "productNumber" String "$productNumber"
            "productRevision" String "$productRevision"
            "serialNumber" String "$nodeName"
            "productionDate" String "2016-03-11"
)
DEF
done

########################################################################
#Making MML script#
########################################################################
cat >> mgw.mml << ABC
.open $simName
.select $nodeName
.start
kertayle:file="$Path/$nodeName.mo";
createlogfile:path="/c/logfiles/systemlog/",logname = "00000sys.log";
setswinstallvariables:bandwidth="3072";
ABC
########################################################################
moFiles+=($nodeName.mo)
done

/netsim/inst/netsim_pipe < mgw.mml
for filenum in ${moFiles[@]}
do
rm $filenum
done
rm mgw.mml
echo "$0 ended at" $( date +%T );

