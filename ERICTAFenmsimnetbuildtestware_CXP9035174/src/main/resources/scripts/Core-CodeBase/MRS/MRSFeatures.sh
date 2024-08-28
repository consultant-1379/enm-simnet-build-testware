#!/bin/bash
########################################################################
# Version     : 16.16
# Revision    : CXP 903 5174-1-1
# Purpose     : Loads features for MRS nodes
# Description : Creates MOs and sets attributes
# Date        : Oct 2016
# Who         : xgouhar
########################################################################
########################################################################
#Script Usage#
########################################################################
usage (){

echo "Usage  : $0 <sim name> "

echo "Example: $0 CORE-ST-MRS-C996327-6.9.4.0x2 "

}
neType(){

echo "ERROR: The script runs only for MRS nodes"
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
mimData=`echo $simName|awk -F'-' '{print $4}' | awk -F 'C' '{print $2}'`
mimVersion="$(echo $mimData | head -c 1)"
mimRelease="$(echo $mimData | cut -c 2-)"
########################################################################
#To check the if simname MGw
########################################################################
if [[ $simName != *"MRS"* ]]
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
CREATE
(
    parent "ManagedElement=1"
    // moid = 137
    identity "1"
    moType MgwApplication
    exception none
    nrOfAttributes 146
    "availabilityStatus" Integer 0
    "bearerReleaseTimer" Integer 5
    "dscpMarking" Integer 46
    "explicitCongestionNotification" Integer 0
    "ipbcpT1Timer" Integer 5
    "licenseStateGcpOverSctp" Integer 1
    "licenseStateVoIpGw" Integer 1
    "marketReference" Integer 0
    "maxBandwidthForIpTransport" Integer 0
    "maxNrOfLicMediaStreamChannels" Integer 0
    "mbacLicensingStatus" Integer 0
    "mbacMeasurementInterval" Integer 2
    "mbacMode" Integer 0
    "mbacThreshold" Integer 1
    "mbacWeightingFactor" Integer 75
    "mccLicensingStatus" Integer 0
    "MgwApplicationId" String ""
    "nrLicensingStatus" Integer 0
    "nrOfIpNetworkRemoteSites" Integer 0
    "operationalState" Integer 0
    "pmNrOfEmergencyCalls" Integer 0
    "pmNrOfMediaStreamChannelsBusy" Integer 0
    "pmNrOfMediaStreamChannelsRejectedDueToCapacity" Integer 0
    "pmNrOfMediaStreamChannelsReq" Integer 0
    "pmNrOfRejEmcCalls" Integer 0
    "pmNrOfRejsByStaticAdmCtrl" Integer 0
    "pmUsedBandwidthForIpTransport" Integer 0
    "sacMode" Integer 0
    "speechActivityFactor" Integer 60
    "tfoIpeMode" Integer 0
    "userLabel" String ""
    "pmNrOfAmrWbUnitsRejDueToCapacity" Integer 0
    "pmAverageBwInmarsatIuPtime20" Integer 0
    "licenseStateIuOverIp" Integer 1
    "mbacCongestionDscpValue" Integer 47
    "pmAverageBwAmrNbPtime20" Integer 0
    "pmAverageBwAmrWbNbPtime20" Integer 0
    "pmAverageBwEfrNbPtime20" Integer 0
    "pmAverageBwAmrVoipPtime20" Integer 0
    "pmAverageBwAmrVoipPtime40" Integer 0
    "pmAverageBwAmrWbVoipPtime20" Integer 0
    "pmAverageBwAmrWbVoipPtime40" Integer 0
    "pmAverageBwEfrVoipPtime20" Integer 0
    "pmAverageBwEfrVoipPtime40" Integer 0
    "pmUsedBandwidthForSiteIntIpTrans" Integer 0
    "pmNrOfG729UnitsRejDueToCapacity" Integer 0
    "pmAverageBwG729Ptime10" Integer 0
    "pmAverageBwG729Ptime20" Integer 0
    "pmAverageBwG729Ptime30" Integer 0
    "pmAverageBwG729Ptime40" Integer 0
    "pmNrOfRejsByIslOverload" Integer 0
    "mbacCongestionDscpMode" Integer 0
    "mbacLostPacketsCalculationMode" Integer 0
    "sacHigherThresholdAlarm" Boolean true
    "sacLowerThresholdAlarm" Boolean true
    "g729HigherThresholdAlarm" Boolean true
    "g729LowerThresholdAlarm" Boolean true
    "amrWbHigherThresholdAlarm" Boolean true
    "amrWbLowerThresholdAlarm" Boolean true
    "pmNrOfMediaStreamChsUsedAmrWb" Integer 0
    "pmNrOfMediaStreamChsUsedG729" Integer 0
    "pmPeakMedStreamChanSetUpRate" Integer 0
    "pmAvMedStreamChanSetUpRate" Integer 0
    "pmNoOfRejsByIntAdmCtrlForCmxb" Integer 0
    "pmNoOfIpConnOverCmxb" Integer 0
    "licenseStateTfo" Integer 1
    "licenseStateNetworkProbe" Integer 1
    "licenseStateFixedLevelControl" Integer 1
    "licenseStateCompressSpeechOnNb" Integer 1
    "maxNrOfLicMediaStreamChannelsVoip" Integer 0
    "voipHigherThresholdAlarm" Boolean true
    "voipLowerThresholdAlarm" Boolean true
    "pmNrOfMeStChReqVoip" Integer 0
    "pmNrOfMeStChRejDueToCapVoip" Integer 0
    "pmNrOfMeStChUsedVoip" Integer 0
    "gmpVersion" String ""
    "rtcpOnNbActive" Boolean false
    "rtcpBearerSupervisionTimerNb" Integer 0
    "rtcpBearerSupervisionTimerVoip" Integer 15
    "licenseStateAoIp" Integer 1
    "licenseStateClearChannelData" Integer 1
    "rtcpBearerSupervisionTimerAoIp" Integer 0
    "pmAverageBwGsmFrAoipPtime20" Integer 0
    "pmAverageBwGsmHrAoipPtime20" Integer 0
    "pmAverageBwAmrAoipPtime20" Integer 0
    "pmAverageBwEfrAoipPtime20" Integer 0
    "pmAverageBwAmrWbAoipPtime20" Integer 0
    "pmAverageBwGsmFrNbPtime20" Integer 0
    "pmAverageBwGsmHrNbPtime20" Integer 0
    "licenseStateDtmfSuppression" Integer 1
    "featureStateDtmfSuppression" Integer 0
    "featureStateCallBasedMsr" Integer 0
    "licenseStateCallBasedMsr" Integer 1
    "pmAverageBwAmrVoipPtime20Ipv6" Integer 0
    "pmAverageBwAmrVoipPtime40Ipv6" Integer 0
    "licenseStateIpv6" Integer 1
    "pmRtpMaxRoundTripDelayOnMb" Integer 0
    "pmRtpAvgRoundTripDelayOnNb" Integer 0
    "pmRtpMaxSentJitterOnNb" Integer 0
    "pmRtpMaxRcvdJitterOnNb" Integer 0
    "pmRtpAvgSentJitterOnNb" Integer 0
    "pmRtpAvgRcvdJitterOnNb" Integer 0
    "pmRtpAvgSentPacketLostOnNb" Integer 0
    "pmRtpMaxRoundTripDelayOnNb" Integer 0
    "pmRtpAvgRoundTripDelayOnMb" Integer 0
    "pmRtpMaxSentJitterOnMb" Integer 0
    "pmRtpMaxRcvdJitterOnMb" Integer 0
    "pmRtpAvgSentJitterOnMb" Integer 0
    "pmRtpAvgRcvdJitterOnMb" Integer 0
    "pmRtpAvgSentPacketLostOnMb" Integer 0
    "pmRtpMaxRoundTripDelayOnA" Integer 0
    "pmRtpAvgRoundTripDelayOnA" Integer 0
    "pmRtpMaxSentJitterOnA" Integer 0
    "pmRtpMaxRcvdJitterOnA" Integer 0
    "pmRtpAvgSentJitterOnA" Integer 0
    "pmRtpAvgRcvdJitterOnA" Integer 0
    "pmRtpAvgSentPacketLostOnA" Integer 0
    "pmRtpMaxRoundTripDelayOnExt" Integer 0
    "pmRtpAvgRoundTripDelayOnExt" Integer 0
    "pmRtpMaxSentJitterOnExt" Integer 0
    "pmRtpMaxRcvdJitterOnExt" Integer 0
    "pmRtpAvgSentJitterOnExt" Integer 0
    "pmRtpAvgRcvdJitterOnExt" Integer 0
    "pmRtpAvgSentPacketLostOnExt" Integer 0
    "g711PacketizationTimeNb" Integer 5
    "pmAverageBwAmrWbVoipPtime20Ipv6" Integer 0
    "pmAverageBwAmrWbVoipPtime40Ipv6" Integer 0
    "pmAverageBwEfrVoipPtime20Ipv6" Integer 0
    "pmAverageBwEfrVoipPtime40Ipv6" Integer 0
    "pmAverageBwG729Ptime10Ipv6" Integer 0
    "pmAverageBwG729Ptime20Ipv6" Integer 0
    "pmAverageBwG729Ptime30Ipv6" Integer 0
    "pmAverageBwG729Ptime40Ipv6" Integer 0
    "featureStateG722" Integer 0
    "licenseStateG722" Integer 1
    "pmAverageBwG722VoipPtime10" Integer 0
    "pmAverageBwG722VoipPtime20" Integer 0
    "pmAverageBwG722VoipPtime30" Integer 0
    "pmAverageBwG722VoipPtime40" Integer 0
    "pmAverageBwG722VoipPtime10Ipv6" Integer 0
    "pmNrOfMediaStreamChsUsedG722" Integer 0
    "pmAverageBwG722VoipPtime20Ipv6" Integer 0
    "pmAverageBwG722VoipPtime30Ipv6" Integer 0
    "pmAverageBwG722VoipPtime40Ipv6" Integer 0
)
CREATE
(
    parent "ManagedElement=1,SwManagement=1"
    identity "1"
    moType UpgradePackage
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
    mo "ManagedElement=1,MgwApplication=1,MediaQualityMonitoring=1"
    // moid = 138
    exception none
    nrOfAttributes 2
    "MediaQualityMonitoringId" String "1"
    "userLabel" String ""
)
SET
(
    mo "ManagedElement=1,MgwApplication=1,UnknownRemoteSite=1"
    // moid = 139
    exception none
    nrOfAttributes 68
    "pmCallsWithRtpPacketLoss0" Integer 0
    "pmCallsWithRtpPacketLoss1" Integer 0
    "pmCallsWithRtpPacketLoss2" Integer 0
    "pmCallsWithRtpPacketLoss3" Integer 0
    "pmCallsWithRtpPacketLoss4" Integer 0
    "pmCallsWithRtpPacketLoss5" Integer 0
    "pmCallsWithRtpPacketLoss6" Integer 0
    "pmConnLatePktsRatio0" Integer 0
    "pmConnLatePktsRatio1" Integer 0
    "pmConnLatePktsRatio2" Integer 0
    "pmConnLatePktsRatio3" Integer 0
    "pmConnLatePktsRatio4" Integer 0
    "pmConnLatePktsRatio5" Integer 0
    "pmConnLatePktsRatio6" Integer 0
    "pmConnMeasuredJitter0" Integer 0
    "pmConnMeasuredJitter1" Integer 0
    "pmConnMeasuredJitter2" Integer 0
    "pmConnMeasuredJitter3" Integer 0
    "pmConnMeasuredJitter4" Integer 0
    "pmConnMeasuredJitter5" Integer 0
    "pmConnMeasuredJitter6" Integer 0
    "pmConnMeasuredJitter7" Integer 0
    "pmConnMeasuredJitter8" Integer 0
    "pmConnsOnUnknownRemoteSite" Integer 0
    "pmIpReceivedEcnPkts" Integer 0
    "pmLatePktsDueToDeJitter" Integer 0
    "pmRtpDiscardedPkts" Integer 0
    "pmRtpLostPkts" Integer 0
    "pmRtpReceivedOctetsHi" Integer 0
    "pmRtpReceivedOctetsLo" Integer 0
    "pmRtpReceivedPktsHi" Integer 0
    "pmRtpReceivedPktsLo" Integer 0
    "pmRtpSentOctetsHi" Integer 0
    "pmRtpSentOctetsLo" Integer 0
    "UnknownRemoteSiteId" String "1"
    "pmRtpReceivedDscpCongPackets" Integer 0
    "pmRtpSentPktsLo" Integer 0
    "pmRtpSentPktsHi" Integer 0
    "pmSuccTransmittedPktsLo" Integer 0
    "pmSuccTransmittedPktsHi" Integer 0
    "pmConnMeasuredJitter5a" Integer 0
    "pmConnMeasuredJitter5b" Integer 0
    "pmConnMeasuredJitter5c" Integer 0
    "pmConnMeasuredJitter3a" Integer 0
    "pmConnMeasuredJitter3b" Integer 0
    "pmConnMeasuredJitter3c" Integer 0
    "pmConnMeasuredJitter4a" Integer 0
    "pmConnMeasuredJitter4b" Integer 0
    "pmConnMeasuredJitter4c" Integer 0
    "ipMultiplexingState" Integer 0
    "ipMuxCollectionTime" Integer 0
    "ipMuxAverageBwSaving" Integer 0
    "pmIpSentOctetsHi" Integer 0
    "pmIpSentOctetsLo" Integer 0
    "pmIpReceivedOctetsHi" Integer 0
    "pmIpReceivedOctetsLo" Integer 0
    "pmIpSentPktsHi" Integer 0
    "pmIpSentPktsLo" Integer 0
    "pmIpReceivedPktsHi" Integer 0
    "pmIpReceivedPktsLo" Integer 0
    "pmRtpMaxRoundTripDelay" Integer 0
    "pmRtpAvgRoundTripDelay" Integer 0
    "pmRtpMaxSentJitter" Integer 0
    "pmRtpMaxRcvdJitter" Integer 0
    "pmRtpAvgSentJitter" Integer 0
    "pmRtpAvgRcvdJitter" Integer 0
    "pmRtpAvgSentPacketLost" Integer 0
    "pmRtpOutOfSequencePkts" Integer 0
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
CREATE
(
    parent "ManagedElement=1,Equipment=1"
    identity "1"
    moType Subrack
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
useattributecharacteristics:switch="off";
kertayle:file="$Path/$nodeName.mo";
ABC

cat >> Mrs.mml << ABC
.open $simName
.select $nodeName
.start
createlogfile:path="/c/logfiles/systemlog/",logname = "00000sys.log";
ABC

cat >> Mgw.mml << ABC
.open $simName
.select $nodeName
.start
setswinstallvariables:bandwidth="3072";
ABC
########################################################################
moFiles+=($nodeName.mo)
done


/netsim/inst/netsim_pipe < mgw.mml
/netsim/inst/netsim_shell < Mrs.mml
/netsim/inst/netsim_shell < Mgw.mml
for filenum in ${moFiles[@]}
do
rm $filenum
done
rm Mrs.mml
rm mgw.mml
rm Mgw.mml
echo "$0 ended at" $( date +%T );

