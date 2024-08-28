#!/bin/bash
########################################################################
# Version     : 17.10
# Revision    : CXP 903 5174-1-1
# Purpose     : Loads features for FrontHaul nodes based on node type
# Description : Creates Mos and sets attributes
# Date        : Oct 2016
# Who         : xmedkar
########################################################################
########################################################################
#Script Usage#
########################################################################
usage (){

echo "Usage  : $0 <sim name>  "

echo "Example: $0 CORE-ST-FrontHaul-6080-17B-V2x5  "

}
neType(){

echo "ERROR: The script runs only for FrontHaul nodes"
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
#To check the if simname is FrontHaul#
########################################################################
if [[ $simName != *"FrontHaul"* ]]
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
    mo "ManagedElement=1"
    exception none
    nrOfAttributes 1
    "productIdentity" Array Struct 1
        nrOfElements 3
        "productNumber" String "$productNumber"
        "productRevision" String "$productRevision"
        "productDesignation" String "N/A"
)
SET
(
    mo "ManagedElement=1,SystemFunctions=1,SwInventory=1,SwItem=1"
    exception none
    nrOfAttributes 1
    "administrativeData" Struct
        nrOfElements 6
        "productName" String "$nodeName"
        "productNumber" String "$productNumber"
        "productRevision" String "$productRevision"
        "productionDate" String "2016-06-21T14:29:10"
        "description" String "$nodeName"
        "type" String "N/A"

)
CREATE
(
    parent "ComTop:ManagedElement=1,ComTop:SystemFunctions=1"
    identity "Un1.Pt10"
    moType Interface
    exception none
    nrOfAttributes 3
         "speed" Int32 10312500
         "name" String "Un1.Pt10"
          "description" String "Optical FH Client Interface Un1.Pt10"
)
CREATE
(
    parent "ComTop:ManagedElement=1,ComTop:SystemFunctions=1"
    identity "Un1.Pt4"
    moType Interface
    exception none
    nrOfAttributes 3
        "speed" Int32 25781250
        "name" String "Un1.Pt4"
        "description" String "Optical FH Client Interface Un1.Pt4"
)
SET
(
    mo "ManagedElement=1,SystemFunctions=1,SwInventory=1,SwVersion=1"
    exception none
    nrOfAttributes 1
    "administrativeData" Struct
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
    mo "ManagedElement=1,SystemFunctions=1,SwInventory=1"
     exception none
    nrOfAttributes 1
    "active" Array Ref 1
        ManagedElement=1,SystemFunctions=1,SwInventory=1,SwVersion=1
)
SET
(
    mo "ManagedElement=1,SystemFunctions=1,Pm=1,PmMeasurementCapabilities=1"
    exception none
    nrOfAttributes 2
    "supportedCompressionTypes" Array Integer 1
         0
    "fileLocation" String "/mnt/sd/ecim/enm_performance"
)
SET
(
     mo "ManagedElement=1,SystemFunctions=1,BrM=1,BrmBackupManager=1"
     exception none
     nrOfAttributes 2
     "backupDomain" String "System"
     "backupType" String "System Data"
 )
SET
(
    mo "ComTop:ManagedElement=1,ComTop:SystemFunctions=1,OPTOFH_HwIM:HwInventory=1,OPTOFH_HwIM:HwItem=1"
    // moid = 97
    exception none
    nrOfAttributes 6
    "serialNumber" String "DC90007271 "
    "productData" Struct
        nrOfElements 6
        "productName" String "PMU "
        "productNumber" String "KDU137944/1 "
        "productRevision" String "R2A "
        "productionDate" String ""
        "description" String "Photonic Management Unit (PMU) Type 01 "
        "type" String ""

    "hwUnitLocation" String "Main_PMU_0 "
    "hwType" String "Blade "
    "hwName" String "PMU "
    "hwModel" String "PMU_01_01 "
)
CREATE
(
    parent "ManagedElement=1,SystemFunctions=1,HwInventory=1"
    identity "2"
    moType HwItem
    exception none
    nrOfAttributes 10
    "hwItemId" String "2"
    "vendorName" String ""
    "serialNumber" String "DC90007880"
    "productIdentity" Struct
        nrOfElements 3
        "productNumber" String ""
        "productRevision" String ""
        "productDesignation" String ""

    "productData" Struct
        nrOfElements 6
        "productName" String "TPS03"
        "productNumber" String "BFZ901176/1"
        "productRevision" String "R2A"
        "productionDate" String ""
        "description" String "Remote Outdoor Transponder-SFP 3-channel"
        "type" String "type"

    "hwUnitLocation" String "Remote_TPS03_12"
    "hwType" String "Blade"
    "hwName" String "TPS03"
    "hwModel" String "TPS_03_01_O"
    "hwCapability" String ""
    "dateOfManufacture" String "2015-08-07T00:00:00+00:00"
)

CREATE
(
    parent "ManagedElement=1,SystemFunctions=1,HwInventory=1"
    identity "3"
    moType HwItem
    exception none
    nrOfAttributes 10
    "hwItemId" String "3"
    "vendorName" String ""
    "serialNumber" String "DC90006873"
    "productIdentity" Struct
        nrOfElements 3
        "productNumber" String ""
        "productRevision" String ""
        "productDesignation" String ""

    "productData" Struct
        nrOfElements 6
        "productName" String "TPS06"
        "productNumber" String "KDU137945/1"
        "productRevision" String "R1B"
        "productionDate" String ""
        "description" String "Transponder Unit SFP (TPS) 6-channel"
        "type" String "type"

    "hwUnitLocation" String "Main_TPS06_2"
    "hwType" String "Blade"
    "hwName" String "TPS06"
    "hwModel" String "TPS_06_01"
    "hwCapability" String ""
    "dateOfManufacture" String "2015-08-07T00:00:00+00:00"
)

CREATE
(
    parent "ManagedElement=1,SystemFunctions=1,HwInventory=1"
    identity "4"
    moType HwItem
    exception none
    nrOfAttributes 10
    "hwItemId" String "4"
    "vendorName" String ""
    "serialNumber" String "BR85235758"
    "productIdentity" Struct
        nrOfElements 3
        "productNumber" String ""
        "productRevision" String ""
        "productDesignation" String ""

    "productData" Struct
        nrOfElements 6
        "productName" String "SUP"
        "productNumber" String "1/BFL 901 009/4R2E"
        "productRevision" String ""
        "productionDate" String ""
        "description" String "Chassis SUP 6601"
        "type" String "type"

    "hwUnitLocation" String "SUP_Shelf_id:BR85235758"
    "hwType" String "Shelf"
    "hwName" String "SUP"
    "hwModel" String "SUP6601"
    "hwCapability" String ""
    "dateOfManufacture" String "2015-08-07T00:00:00+00:00"
)

CREATE
(
    parent "ManagedElement=1,SystemFunctions=1,HwInventory=1"
    identity "5"
    moType HwItem
    exception none
    nrOfAttributes 10
    "hwItemId" String "5"
    "vendorName" String "DELTA"
    "serialNumber" String "1715061B0800040"
    "productIdentity" Struct
        nrOfElements 3
        "productNumber" String ""
        "productRevision" String ""
        "productDesignation" String ""

    "productData" Struct
        nrOfElements 6
        "productName" String "Transceiver"
        "productNumber" String "RDH10276/1"
        "productRevision" String "R1A"
        "productionDate" String ""
        "description" String "delta"
        "type" String "type"

    "hwUnitLocation" String "pmu 0 eth 1"
    "hwType" String ""
    "hwName" String ""
    "hwModel" String ""
    "hwCapability" String ""
    "dateOfManufacture" String "2015-08-07T00:00:00+00:00"
)

CREATE
(
    parent "ManagedElement=1,SystemFunctions=1,HwInventory=1"
    identity "6"
    moType HwItem
    exception none
    nrOfAttributes 10
    "hwItemId" String "6"
    "vendorName" String "DELTA"
    "serialNumber" String "1624091A0403251"
    "productIdentity" Struct
        nrOfElements 3
        "productNumber" String ""
        "productRevision" String ""
        "productDesignation" String ""

    "productData" Struct
        nrOfElements 6
        "productName" String "Transceiver"
        "productNumber" String "RDH10265/2"
        "productRevision" String "R1A"
        "productionDate" String ""
        "description" String ""
        "type" String "type"

    "hwUnitLocation" String "tps 2 ce 3"
    "hwType" String ""
    "hwName" String ""
    "hwModel" String ""
    "hwCapability" String ""
    "dateOfManufacture" String "2015-08-07T00:00:00+00:00"
)

CREATE
(
    parent "ManagedElement=1,SystemFunctions=1,HwInventory=1"
    identity "7"
    moType HwItem
    exception none
    nrOfAttributes 10
    "hwItemId" String "7"
    "vendorName" String "DELTA"
    "serialNumber" String "1715061B0700025"
    "productIdentity" Struct
        nrOfElements 3
        "productNumber" String ""
        "productRevision" String ""
        "productDesignation" String ""

    "productData" Struct
        nrOfElements 6
        "productName" String "Transceiver"
        "productNumber" String "RDH10276/2"
        "productRevision" String "R1A"
        "productionDate" String ""
        "description" String ""
        "type" String "type"

    "hwUnitLocation" String "tps-o 12 osc 1"
    "hwType" String ""
    "hwName" String ""
    "hwModel" String ""
    "hwCapability" String ""
    "dateOfManufacture" String "2015-08-07T00:00:00+00:00"
)
DEF
########################################################################
#Making MML script#
########################################################################
cat >> FrontHaul.mml << ABC
.open $simName
.select $nodeName
.start
alarmType:type="enm";
alarmType:status;
kertayle:file="$Path/$nodeName.mo";
createlogfile:path="/mnt/flash/ecim/alarm/",logname="alarm-history";
createlogfile:path="/mnt/sd/bmulog/",logname="unit-log";
createlogfile:path="/mnt/sd/bmucheck/",logname="unit-diagonstic";
createlogfile:path="/mnt/flash/ecim/log/lct/",logname="lct-logs";
createlogfile:path="/mnt/sd/pmulog/",logname="pmu-log";
createlogfile:path="/mnt/sd/bmulog/",logname="bmu-log";
createlogfile:path="/mnt/flash/ecim/log/",logname="agent-logs";
createlogfile:path="/log/",logname="debug-logs";
ABC
########################################################################

moFiles+=($nodeName.mo)
done

nodeVersion=`echo $simName | awk -F '6020' '{print $2}' | cut -d 'x' -f1 | tr -d '-' | tr -d '[A-z]'`
nodeVersion1=`echo $simName | awk -F '6650' '{print $2}' | cut -d 'x' -f1 | tr -d '-' | tr -d '[A-z]'`

if [[ $nodeVersion > 2021 || $nodeVersion1 > 2021 ]]
then
echo "Applying certs for $simName"
for nodeName in ${neNames[@]}
do

cat >> ${nodeName}_certs.mo << AN
SET
(
    mo "ComTop:ManagedElement=1,ComTop:SystemFunctions=1,OPTOFH_SecM:SecM=1,OPTOFH_CertM:CertM=1,OPTOFH_CertM:CertMCapabilities=1"
    // moid = 13
    exception none
    nrOfAttributes 2
    "fingerprintSupport" Integer 2
    "enrollmentSupport" Array Integer 1
         3
)
SET
(
  mo "ManagedElement=1,SystemFunctions=1,SecM=1,Tls=1"
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

AN

cat >> FrontHaul.mml << XYZ
.open $simName
.select $nodeName
.start
kertayle:file="$Path/${nodeName}_certs.mo";
XYZ
done
fi

/netsim/inst/netsim_pipe < FrontHaul.mml
for filenum in ${moFiles[@]}
do
rm $filenum
done
rm FrontHaul.mml
echo "$0 ended at" $( date +%T );



