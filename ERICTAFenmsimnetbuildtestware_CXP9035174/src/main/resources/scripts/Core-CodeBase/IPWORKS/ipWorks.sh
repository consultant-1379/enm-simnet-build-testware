#!/bin/bash
########################################################################
# Version     : 16.16
# Revision    : CXP 903 5174-1-1
# Purpose     : Loads features for IPWORKS nodes based on node type
# Description : Creates Mos and sets attributes
# Date        : Oct 2016
# Who         : xgouhar
########################################################################
########################################################################
#Script Usage#
########################################################################
usage (){

echo "Usage  : $0 <sim name> "

echo "Example: $0 CORE-ST-vIPWORKS-16A-V3X5 "

}
neType(){

echo "ERROR: The script runs only for IPWORKS nodes"
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
#To check the if simname is IPWORKS#
########################################################################
if [[ $simName != *"IPWORKS"* ]]
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
    mo "ManagedElement=$nodeName,SystemFunctions=1,Pm=1,PmMeasurementCapabilities=1"
    exception none
    nrOfAttributes 1
    "fileLocation" String "/storage/no-backup/nbi_root/PerformanceManagementReportFiles"
)
SET
(
    mo "ManagedElement=$nodeName"
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
    mo "ManagedElement=$nodeName,SystemFunctions=1,SwInventory=1,SwItem=1"
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
    mo "ManagedElement=$nodeName,SystemFunctions=1,SwInventory=1,SwVersion=1"
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
    mo "ManagedElement=$nodeName,SystemFunctions=1,SwInventory=1"
     exception none
    nrOfAttributes 1
    "active" Array Ref 1
        ManagedElement=$nodeName,SystemFunctions=1,SwInventory=1,SwVersion=1
)
SET
(
    mo "ManagedElement=$nodeName,SystemFunctions=1,BrM=1,BrmBackupManager=1,BrmBackup=1"
    exception none
    nrOfAttributes 3
    "creationType" Integer 3
    "brmBackupId" String "1"
    "backupName" String "1"
)
SET
(
    mo "ManagedElement=$nodeName,SystemFunctions=1,Pm=1,PmMeasurementCapabilities=1"
    exception none
    nrOfAttributes 1
)
SET
(
    mo "ManagedElement=$nodeName,SystemFunctions=1,SwInventory=1,SwItem=1"
    exception none
    nrOfAttributes 1
    "consistsOf" Array Ref 1
        ManagedElement=$nodeName,SystemFunctions=1,SwInventory=1,SwVersion=1
)
SET
(
    mo "ManagedElement=$nodeName,SystemFunctions=1,SwInventory=1,SwVersion=1"
    exception none
    nrOfAttributes 1
    "consistsOf" Array Ref 1
        ManagedElement=$nodeName,SystemFunctions=1,SwInventory=1,SwItem=1
)
SET
(
  mo "ManagedElement=$nodeName,SystemFunctions=1,BrM=1,BrmBackupManager=1"
  exception none
  nrOfAttributes 2
  "backupDomain" String "BRM_USER_DATA"
  "backupType" String "BRM_USER_DATA"
)  
CREATE
(
    parent "ManagedElement=$nodeName,Transport=1,Host=1"
        identity 1
        moType Ikev2PolicyProfile
    exception none
    nrOfAttributes 0
)


CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1"
    identity "Bts_Application_Administrator"
    moType ComLocalAuthorization:Role
    exception none
    nrOfAttributes 3
    "roleId" String "Bts_Application_Administrator"
    "roleName" String "Bts_Application_Administrator"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Bts_Application_Administrator"
    identity "BtsApplAdmRWX_1"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,BtsFunction,*"
    "ruleId" String "BtsApplAdmRWX_1"
    "ruleName" String "BtsApplAdmRWX_1"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Bts_Application_Administrator"
    identity "BtsApplAdmRWX_10"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,SystemFunctions,PmEventM,*"
    "ruleId" String "BtsApplAdmRWX_10"
    "ruleName" String "BtsApplAdmRWX_10"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Bts_Application_Administrator"
    identity "BtsApplAdmRWX_11"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,SystemFunctions,Lm,*"
    "ruleId" String "BtsApplAdmRWX_11"
    "ruleName" String "BtsApplAdmRWX_11"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Bts_Application_Administrator"
    identity "BtsApplAdmRWX_12"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,SystemFunctions,LogM,*"
    "ruleId" String "BtsApplAdmRWX_12"
    "ruleName" String "BtsApplAdmRWX_12"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Bts_Application_Administrator"
    identity "BtsApplAdmRWX_2"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,NodeSupport,*"
    "ruleId" String "BtsApplAdmRWX_2"
    "ruleName" String "BtsApplAdmRWX_2"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Bts_Application_Administrator"
    identity "BtsApplAdmRWX_3"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,Transport,*"
    "ruleId" String "BtsApplAdmRWX_3"
    "ruleName" String "BtsApplAdmRWX_3"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Bts_Application_Administrator"
    identity "BtsApplAdmRWX_4"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,Equipment"
    "ruleId" String "BtsApplAdmRWX_4"
    "ruleName" String "BtsApplAdmRWX_4"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Bts_Application_Administrator"
    identity "BtsApplAdmRWX_5"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,Equipment,AntennaUnitGroup,*"
    "ruleId" String "BtsApplAdmRWX_5"
    "ruleName" String "BtsApplAdmRWX_5"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Bts_Application_Administrator"
    identity "BtsApplAdmRWX_6"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,Equipment,FieldReplaceableUnit,*"
    "ruleId" String "BtsApplAdmRWX_6"
    "ruleName" String "BtsApplAdmRWX_6"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Bts_Application_Administrator"
    identity "BtsApplAdmRWX_7"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,Equipment,RiLink,*"
    "ruleId" String "BtsApplAdmRWX_7"
    "ruleName" String "BtsApplAdmRWX_7"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Bts_Application_Administrator"
    identity "BtsApplAdmRWX_8"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,SystemFunctions,Fm,FmAlarm,*"
    "ruleId" String "BtsApplAdmRWX_8"
    "ruleName" String "BtsApplAdmRWX_8"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Bts_Application_Administrator"
    identity "BtsApplAdmRWX_9"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,SystemFunctions,Pm,*"
    "ruleId" String "BtsApplAdmRWX_9"
    "ruleName" String "BtsApplAdmRWX_9"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Bts_Application_Administrator"
    identity "BtsApplAdmRX_1"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 5
    "ruleData" String "ManagedElement,SystemFunctions,SysM,Schema"
    "ruleId" String "BtsApplAdmRX_1"
    "ruleName" String "BtsApplAdmRX_1"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Bts_Application_Administrator"
    identity "BtsApplAdmR_1"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement"
    "ruleId" String "BtsApplAdmR_1"
    "ruleName" String "BtsApplAdmR_1"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Bts_Application_Administrator"
    identity "BtsApplAdmR_2"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,Equipment,*"
    "ruleId" String "BtsApplAdmR_2"
    "ruleName" String "BtsApplAdmR_2"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Bts_Application_Administrator"
    identity "BtsApplAdmR_3"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions"
    "ruleId" String "BtsApplAdmR_3"
    "ruleName" String "BtsApplAdmR_3"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Bts_Application_Administrator"
    identity "BtsApplAdmR_4"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions,Fm,*"
    "ruleId" String "BtsApplAdmR_4"
    "ruleName" String "BtsApplAdmR_4"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1"
    identity "Bts_Application_User"
    moType ComLocalAuthorization:Role
    exception none
    nrOfAttributes 3
    "roleId" String "Bts_Application_User"
    "roleName" String "Bts_Application_User"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Bts_Application_User"
    identity "BtsApplRX_1"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 5
    "ruleData" String "ManagedElement,SystemFunctions,SysM,Schema"
    "ruleId" String "BtsApplRX_1"
    "ruleName" String "BtsApplRX_1"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Bts_Application_User"
    identity "BtsApplRX_2"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 5
    "ruleData" String "ManagedElement,SystemFunctions,LogM,*"
    "ruleId" String "BtsApplRX_2"
    "ruleName" String "BtsApplRX_2"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Bts_Application_User"
    identity "BtsApplR_1"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,BtsFunction,*"
    "ruleId" String "BtsApplR_1"
    "ruleName" String "BtsApplR_1"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Bts_Application_User"
    identity "BtsApplR_10"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions,Lm,*"
    "ruleId" String "BtsApplR_10"
    "ruleName" String "BtsApplR_10"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Bts_Application_User"
    identity "BtsApplR_2"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement"
    "ruleId" String "BtsApplR_2"
    "ruleName" String "BtsApplR_2"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Bts_Application_User"
    identity "BtsApplR_3"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions"
    "ruleId" String "BtsApplR_3"
    "ruleName" String "BtsApplR_3"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Bts_Application_User"
    identity "BtsApplR_4"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,NodeSupport,*"
    "ruleId" String "BtsApplR_4"
    "ruleName" String "BtsApplR_4"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Bts_Application_User"
    identity "BtsApplR_5"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,Transport,*"
    "ruleId" String "BtsApplR_5"
    "ruleName" String "BtsApplR_5"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Bts_Application_User"
    identity "BtsApplR_6"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,Equipment,*"
    "ruleId" String "BtsApplR_6"
    "ruleName" String "BtsApplR_6"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Bts_Application_User"
    identity "BtsApplR_7"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions,Fm,*"
    "ruleId" String "BtsApplR_7"
    "ruleName" String "BtsApplR_7"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Bts_Application_User"
    identity "BtsApplR_8"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions,Pm,*"
    "ruleId" String "BtsApplR_8"
    "ruleName" String "BtsApplR_8"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Bts_Application_User"
    identity "BtsApplR_9"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions,PmEventM,*"
    "ruleId" String "BtsApplR_9"
    "ruleName" String "BtsApplR_9"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1"
    identity "ENodeB_Application_Administrator"
    moType ComLocalAuthorization:Role
    exception none
    nrOfAttributes 3
    "roleId" String "ENodeB_Application_Administrator"
    "roleName" String "ENodeB_Application_Administrator"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_1"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction"
    "ruleId" String "ENodeBApplAdmRWX_1"
    "ruleName" String "ENodeBApplAdmRWX_1"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_10"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction,DrxProfile,*"
    "ruleId" String "ENodeBApplAdmRWX_10"
    "ruleName" String "ENodeBApplAdmRWX_10"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_11"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction,EUtranCellFDD,*"
    "ruleId" String "ENodeBApplAdmRWX_11"
    "ruleName" String "ENodeBApplAdmRWX_11"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_12"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction,EUtranCellTDD,*"
    "ruleId" String "ENodeBApplAdmRWX_12"
    "ruleName" String "ENodeBApplAdmRWX_12"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_13"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction,EUtraNetwork,*"
    "ruleId" String "ENodeBApplAdmRWX_13"
    "ruleName" String "ENodeBApplAdmRWX_13"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_14"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction,GeraNetwork,*"
    "ruleId" String "ENodeBApplAdmRWX_14"
    "ruleName" String "ENodeBApplAdmRWX_14"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_15"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction,LoadBalancingFunction,*"
    "ruleId" String "ENodeBApplAdmRWX_15"
    "ruleName" String "ENodeBApplAdmRWX_15"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_16"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction,Mbms,*"
    "ruleId" String "ENodeBApplAdmRWX_16"
    "ruleName" String "ENodeBApplAdmRWX_16"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_17"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction,NonPlannedPciDrxProfile,*"
    "ruleId" String "ENodeBApplAdmRWX_17"
    "ruleName" String "ENodeBApplAdmRWX_17"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_18"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction,Paging,*"
    "ruleId" String "ENodeBApplAdmRWX_18"
    "ruleName" String "ENodeBApplAdmRWX_18"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_19"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction,ParameterChangeRequests,*"
    "ruleId" String "ENodeBApplAdmRWX_19"
    "ruleName" String "ENodeBApplAdmRWX_19"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_2"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction,AdmissionControl,*"
    "ruleId" String "ENodeBApplAdmRWX_2"
    "ruleName" String "ENodeBApplAdmRWX_2"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_20"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction,PmEventService,*"
    "ruleId" String "ENodeBApplAdmRWX_20"
    "ruleName" String "ENodeBApplAdmRWX_20"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_21"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction,PreschedulingProfile,*"
    "ruleId" String "ENodeBApplAdmRWX_21"
    "ruleName" String "ENodeBApplAdmRWX_21"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_22"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction,PwsCmas,*"
    "ruleId" String "ENodeBApplAdmRWX_22"
    "ruleName" String "ENodeBApplAdmRWX_22"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_23"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction,PwsEtws,*"
    "ruleId" String "ENodeBApplAdmRWX_23"
    "ruleName" String "ENodeBApplAdmRWX_23"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_24"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction,QciTable,*"
    "ruleId" String "ENodeBApplAdmRWX_24"
    "ruleName" String "ENodeBApplAdmRWX_24"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_25"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction,RadioBearerTable,*"
    "ruleId" String "ENodeBApplAdmRWX_25"
    "ruleName" String "ENodeBApplAdmRWX_25"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_26"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction,Rcs,*"
    "ruleId" String "ENodeBApplAdmRWX_26"
    "ruleName" String "ENodeBApplAdmRWX_26"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_27"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction,RlfProfile,*"
    "ruleId" String "ENodeBApplAdmRWX_27"
    "ruleName" String "ENodeBApplAdmRWX_27"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_28"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction,Rrc,*"
    "ruleId" String "ENodeBApplAdmRWX_28"
    "ruleName" String "ENodeBApplAdmRWX_28"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_29"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction,SectorCarrier,*"
    "ruleId" String "ENodeBApplAdmRWX_29"
    "ruleName" String "ENodeBApplAdmRWX_29"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_3"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction,AdmissionControl,*"
    "ruleId" String "ENodeBApplAdmRWX_3"
    "ruleName" String "ENodeBApplAdmRWX_3"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_30"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction,SrbTable,*"
    "ruleId" String "ENodeBApplAdmRWX_30"
    "ruleName" String "ENodeBApplAdmRWX_30"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_31"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction,SubscriberProfileID,*"
    "ruleId" String "ENodeBApplAdmRWX_31"
    "ruleName" String "ENodeBApplAdmRWX_31"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_32"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction,TermPointToMme,*"
    "ruleId" String "ENodeBApplAdmRWX_32"
    "ruleName" String "ENodeBApplAdmRWX_32"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_33"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction,UcToolFunction,*"
    "ruleId" String "ENodeBApplAdmRWX_33"
    "ruleName" String "ENodeBApplAdmRWX_33"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_34"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction,UlCompGroup,*"
    "ruleId" String "ENodeBApplAdmRWX_34"
    "ruleName" String "ENodeBApplAdmRWX_34"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_35"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction,UtraNetwork,*"
    "ruleId" String "ENodeBApplAdmRWX_35"
    "ruleName" String "ENodeBApplAdmRWX_35"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_36"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,NodeSupport,*"
    "ruleId" String "ENodeBApplAdmRWX_36"
    "ruleName" String "ENodeBApplAdmRWX_36"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_37"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,Transport,*"
    "ruleId" String "ENodeBApplAdmRWX_37"
    "ruleName" String "ENodeBApplAdmRWX_37"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_38"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,Equipment"
    "ruleId" String "ENodeBApplAdmRWX_38"
    "ruleName" String "ENodeBApplAdmRWX_38"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_39"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,Equipment,AntennaUnitGroup,*"
    "ruleId" String "ENodeBApplAdmRWX_39"
    "ruleName" String "ENodeBApplAdmRWX_39"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_4"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction,AirIfLoadProfile,*"
    "ruleId" String "ENodeBApplAdmRWX_4"
    "ruleName" String "ENodeBApplAdmRWX_4"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_40"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,Equipment,FieldReplaceableUnit,*"
    "ruleId" String "ENodeBApplAdmRWX_40"
    "ruleName" String "ENodeBApplAdmRWX_40"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_41"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,Equipment,RiLink,*"
    "ruleId" String "ENodeBApplAdmRWX_41"
    "ruleName" String "ENodeBApplAdmRWX_41"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_42"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,SystemFunctions,Fm,FmAlarm,*"
    "ruleId" String "ENodeBApplAdmRWX_42"
    "ruleName" String "ENodeBApplAdmRWX_42"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_43"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,SystemFunctions,Pm,*"
    "ruleId" String "ENodeBApplAdmRWX_43"
    "ruleName" String "ENodeBApplAdmRWX_43"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_44"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,SystemFunctions,PmEventM,*"
    "ruleId" String "ENodeBApplAdmRWX_44"
    "ruleName" String "ENodeBApplAdmRWX_44"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_45"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,SystemFunctions,Lm,*"
    "ruleId" String "ENodeBApplAdmRWX_45"
    "ruleName" String "ENodeBApplAdmRWX_45"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_46"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,SystemFunctions,LogM,*"
    "ruleId" String "ENodeBApplAdmRWX_46"
    "ruleName" String "ENodeBApplAdmRWX_46"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_47"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,MceFunction,*"
    "ruleId" String "ENodeBApplAdmRWX_47"
    "ruleName" String "ENodeBApplAdmRWX_47"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_48"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction,TimerProfile,*"
    "ruleId" String "ENodeBApplAdmRWX_48"
    "ruleName" String "ENodeBApplAdmRWX_48"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_49"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction,NbIotCell,*"
    "ruleId" String "ENodeBApplAdmRWX_49"
    "ruleName" String "ENodeBApplAdmRWX_49"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_5"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction,AnrFunction,*"
    "ruleId" String "ENodeBApplAdmRWX_5"
    "ruleName" String "ENodeBApplAdmRWX_5"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_6"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction,AutoCellCapEstFunction,*"
    "ruleId" String "ENodeBApplAdmRWX_6"
    "ruleName" String "ENodeBApplAdmRWX_6"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_7"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction,CarrierAggregationFunction,*"
    "ruleId" String "ENodeBApplAdmRWX_7"
    "ruleName" String "ENodeBApplAdmRWX_7"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_8"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction,Cdma2000Network,*"
    "ruleId" String "ENodeBApplAdmRWX_8"
    "ruleName" String "ENodeBApplAdmRWX_8"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRWX_9"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction,DlComp,*"
    "ruleId" String "ENodeBApplAdmRWX_9"
    "ruleName" String "ENodeBApplAdmRWX_9"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmRX_1"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 5
    "ruleData" String "ManagedElement,SystemFunctions,SysM,Schema"
    "ruleId" String "ENodeBApplAdmRX_1"
    "ruleName" String "ENodeBApplAdmRX_1"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmR_1"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,ENodeBFunction,*"
    "ruleId" String "ENodeBApplAdmR_1"
    "ruleName" String "ENodeBApplAdmR_1"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmR_2"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement"
    "ruleId" String "ENodeBApplAdmR_2"
    "ruleName" String "ENodeBApplAdmR_2"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmR_3"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,Equipment,*"
    "ruleId" String "ENodeBApplAdmR_3"
    "ruleName" String "ENodeBApplAdmR_3"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmR_4"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions"
    "ruleId" String "ENodeBApplAdmR_4"
    "ruleName" String "ENodeBApplAdmR_4"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_Administrator"
    identity "ENodeBApplAdmR_5"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions,Fm,*"
    "ruleId" String "ENodeBApplAdmR_5"
    "ruleName" String "ENodeBApplAdmR_5"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1"
    identity "ENodeB_Application_SecurityAdministrator"
    moType ComLocalAuthorization:Role
    exception none
    nrOfAttributes 3
    "roleId" String "ENodeB_Application_SecurityAdministrator"
    "roleName" String "ENodeB_Application_SecurityAdministrator"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_SecurityAdministrator"
    identity "ENodeBApplSecAdmRWX_1"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,ENodeBFunction,SecurityHandling*"
    "ruleId" String "ENodeBApplSecAdmRWX_1"
    "ruleName" String "ENodeBApplSecAdmRWX_1"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_SecurityAdministrator"
    identity "ENodeBApplSecAdmRX_1"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 5
    "ruleData" String "ManagedElement,SystemFunctions,SysM,Schema"
    "ruleId" String "ENodeBApplSecAdmRX_1"
    "ruleName" String "ENodeBApplSecAdmRX_1"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_SecurityAdministrator"
    identity "ENodeBApplSecAdmR_1"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,ENodeBFunction,*"
    "ruleId" String "ENodeBApplSecAdmR_1"
    "ruleName" String "ENodeBApplSecAdmR_1"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_SecurityAdministrator"
    identity "ENodeBApplSecAdmR_2"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,MceFunction,*"
    "ruleId" String "ENodeBApplSecAdmR_2"
    "ruleName" String "ENodeBApplSecAdmR_2"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1"
    identity "ENodeB_Application_User"
    moType ComLocalAuthorization:Role
    exception none
    nrOfAttributes 3
    "roleId" String "ENodeB_Application_User"
    "roleName" String "ENodeB_Application_User"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_User"
    identity "ENodeBApplRX_1"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 5
    "ruleData" String "ManagedElement,SystemFunctions,SysM,Schema"
    "ruleId" String "ENodeBApplRX_1"
    "ruleName" String "ENodeBApplRX_1"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_User"
    identity "ENodeBApplRX_2"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 5
    "ruleData" String "ManagedElement,SystemFunctions,LogM,*"
    "ruleId" String "ENodeBApplRX_2"
    "ruleName" String "ENodeBApplRX_2"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_User"
    identity "ENodeBApplR_1"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,ENodeBFunction,*"
    "ruleId" String "ENodeBApplR_1"
    "ruleName" String "ENodeBApplR_1"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_User"
    identity "ENodeBApplR_10"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions,Lm,*"
    "ruleId" String "ENodeBApplR_10"
    "ruleName" String "ENodeBApplR_10"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_User"
    identity "ENodeBApplR_11"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,MceFunction,*"
    "ruleId" String "ENodeBApplR_11"
    "ruleName" String "ENodeBApplR_11"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_User"
    identity "ENodeBApplR_2"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement"
    "ruleId" String "ENodeBApplR_2"
    "ruleName" String "ENodeBApplR_2"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_User"
    identity "ENodeBApplR_3"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions"
    "ruleId" String "ENodeBApplR_3"
    "ruleName" String "ENodeBApplR_3"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_User"
    identity "ENodeBApplR_4"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,NodeSupport,*"
    "ruleId" String "ENodeBApplR_4"
    "ruleName" String "ENodeBApplR_4"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_User"
    identity "ENodeBApplR_5"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,Transport,*"
    "ruleId" String "ENodeBApplR_5"
    "ruleName" String "ENodeBApplR_5"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_User"
    identity "ENodeBApplR_6"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,Equipment,*"
    "ruleId" String "ENodeBApplR_6"
    "ruleName" String "ENodeBApplR_6"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_User"
    identity "ENodeBApplR_7"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions,Fm,*"
    "ruleId" String "ENodeBApplR_7"
    "ruleName" String "ENodeBApplR_7"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_User"
    identity "ENodeBApplR_8"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions,Pm,*"
    "ruleId" String "ENodeBApplR_8"
    "ruleName" String "ENodeBApplR_8"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=ENodeB_Application_User"
    identity "ENodeBApplR_9"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions,PmEventM,*"
    "ruleId" String "ENodeBApplR_9"
    "ruleName" String "ENodeBApplR_9"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1"
    identity "EricssonSupport"
    moType ComLocalAuthorization:Role
    exception none
    nrOfAttributes 3
    "roleId" String "EricssonSupport"
    "roleName" String "EricssonSupport"
    "userLabel" String "This role is dedicated for internal usage and cannot be asiggend to any user on LDAP."
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=EricssonSupport"
    identity "support"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,*"
    "ruleId" String "support"
    "ruleName" String "null"
    "userLabel" String "Access rule for MaintenanceUser only"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1"
    identity "NodeB_Application_Administrator"
    moType ComLocalAuthorization:Role
    exception none
    nrOfAttributes 3
    "roleId" String "NodeB_Application_Administrator"
    "roleName" String "NodeB_Application_Administrator"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=NodeB_Application_Administrator"
    identity "NodeBApplAdmRWX_1"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,NodeBFunction,*"
    "ruleId" String "NodeBApplAdmRWX_1"
    "ruleName" String "NodeBApplAdmRWX_1"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=NodeB_Application_Administrator"
    identity "NodeBApplAdmRWX_2"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,NodeSupport,*"
    "ruleId" String "NodeBApplAdmRWX_2"
    "ruleName" String "NodeBApplAdmRWX_2"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=NodeB_Application_Administrator"
    identity "NodeBApplAdmRWX_3"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,Equipment,*"
    "ruleId" String "NodeBApplAdmRWX_3"
    "ruleName" String "NodeBApplAdmRWX_3"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=NodeB_Application_Administrator"
    identity "NodeBApplAdmRWX_4"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,SystemFunctions,Pm,*"
    "ruleId" String "NodeBApplAdmRWX_4"
    "ruleName" String "NodeBApplAdmRWX_4"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=NodeB_Application_Administrator"
    identity "NodeBApplAdmRWX_5"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,SystemFunctions,PmEventM,*"
    "ruleId" String "NodeBApplAdmRWX_5"
    "ruleName" String "NodeBApplAdmRWX_5"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=NodeB_Application_Administrator"
    identity "NodeBApplAdmRWX_6"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,SystemFunctions,Lm,*"
    "ruleId" String "NodeBApplAdmRWX_6"
    "ruleName" String "NodeBApplAdmRWX_6"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=NodeB_Application_Administrator"
    identity "NodeBApplAdmRX_1"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 5
    "ruleData" String "ManagedElement,SystemFunctions,SysM,Schema"
    "ruleId" String "NodeBApplAdmRX_1"
    "ruleName" String "NodeBApplAdmRX_1"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=NodeB_Application_Administrator"
    identity "NodeBApplAdmR_1"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement"
    "ruleId" String "NodeBApplAdmR_1"
    "ruleName" String "NodeBApplAdmR_1"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=NodeB_Application_Administrator"
    identity "NodeBApplAdmR_2"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions"
    "ruleId" String "NodeBApplAdmR_2"
    "ruleName" String "NodeBApplAdmR_2"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1"
    identity "NodeB_Application_User"
    moType ComLocalAuthorization:Role
    exception none
    nrOfAttributes 3
    "roleId" String "NodeB_Application_User"
    "roleName" String "NodeB_Application_User"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=NodeB_Application_User"
    identity "NodeBApplRX_1"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 5
    "ruleData" String "ManagedElement,SystemFunctions,SysM,Schema"
    "ruleId" String "NodeBApplRX_1"
    "ruleName" String "NodeBApplRX_1"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=NodeB_Application_User"
    identity "NodeBApplR_1"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,NodeBFunction,*"
    "ruleId" String "NodeBApplR_1"
    "ruleName" String "NodeBApplR_1"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=NodeB_Application_User"
    identity "NodeBApplR_2"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement"
    "ruleId" String "NodeBApplR_2"
    "ruleName" String "NodeBApplR_2"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=NodeB_Application_User"
    identity "NodeBApplR_3"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions"
    "ruleId" String "NodeBApplR_3"
    "ruleName" String "NodeBApplR_3"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=NodeB_Application_User"
    identity "NodeBApplR_4"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,NodeSupport,*"
    "ruleId" String "NodeBApplR_4"
    "ruleName" String "NodeBApplR_4"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=NodeB_Application_User"
    identity "NodeBApplR_5"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,Equipment,*"
    "ruleId" String "NodeBApplR_5"
    "ruleName" String "NodeBApplR_5"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=NodeB_Application_User"
    identity "NodeBApplR_6"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions,Pm,*"
    "ruleId" String "NodeBApplR_6"
    "ruleName" String "NodeBApplR_6"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=NodeB_Application_User"
    identity "NodeBApplR_7"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions,PmEventM,*"
    "ruleId" String "NodeBApplR_7"
    "ruleName" String "NodeBApplR_7"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=NodeB_Application_User"
    identity "NodeBApplR_8"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions,Lm,*"
    "ruleId" String "NodeBApplR_8"
    "ruleName" String "NodeBApplR_8"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1"
    identity "Support_Application_Administrator"
    moType ComLocalAuthorization:Role
    exception none
    nrOfAttributes 3
    "roleId" String "Support_Application_Administrator"
    "roleName" String "Support_Application_Administrator"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Support_Application_Administrator"
    identity "SupportApplAdmRWX_1"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,EquipmentSupportSystem,*"
    "ruleId" String "SupportApplAdmRWX_1"
    "ruleName" String "SupportApplAdmRWX_1"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Support_Application_Administrator"
    identity "SupportApplAdmRWX_10"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,NodeSupport,OnSiteActivities,*"
    "ruleId" String "SupportApplAdmRWX_10"
    "ruleName" String "SupportApplAdmRWX_10"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Support_Application_Administrator"
    identity "SupportApplAdmRWX_11"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,SystemFunctions,Fm,FmAlarm,*"
    "ruleId" String "SupportApplAdmRWX_11"
    "ruleName" String "SupportApplAdmRWX_11"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Support_Application_Administrator"
    identity "SupportApplAdmRWX_12"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,SystemFunctions,Pm,*"
    "ruleId" String "SupportApplAdmRWX_12"
    "ruleName" String "SupportApplAdmRWX_12"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Support_Application_Administrator"
    identity "SupportApplAdmRWX_13"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,SystemFunctions,LogM,*"
    "ruleId" String "SupportApplAdmRWX_13"
    "ruleName" String "SupportApplAdmRWX_13"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Support_Application_Administrator"
    identity "SupportApplAdmRWX_2"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,Equipment"
    "ruleId" String "SupportApplAdmRWX_2"
    "ruleName" String "SupportApplAdmRWX_2"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Support_Application_Administrator"
    identity "SupportApplAdmRWX_3"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,Equipment,Cabinet,*"
    "ruleId" String "SupportApplAdmRWX_3"
    "ruleName" String "SupportApplAdmRWX_3"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Support_Application_Administrator"
    identity "SupportApplAdmRWX_4"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,Equipment,FieldReplaceableUnit,*"
    "ruleId" String "SupportApplAdmRWX_4"
    "ruleName" String "SupportApplAdmRWX_4"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Support_Application_Administrator"
    identity "SupportApplAdmRWX_5"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,Equipment,ExternalNode,*"
    "ruleId" String "SupportApplAdmRWX_5"
    "ruleName" String "SupportApplAdmRWX_5"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Support_Application_Administrator"
    identity "SupportApplAdmRWX_6"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,Equipment,EcBus,*"
    "ruleId" String "SupportApplAdmRWX_6"
    "ruleName" String "SupportApplAdmRWX_6"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Support_Application_Administrator"
    identity "SupportApplAdmRWX_7"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,Equipment,SupportUnit,*"
    "ruleId" String "SupportApplAdmRWX_7"
    "ruleName" String "SupportApplAdmRWX_7"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Support_Application_Administrator"
    identity "SupportApplAdmRWX_8"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,Equipment,HwGroup,*"
    "ruleId" String "SupportApplAdmRWX_8"
    "ruleName" String "SupportApplAdmRWX_8"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Support_Application_Administrator"
    identity "SupportApplAdmRWX_9"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,NodeSupport"
    "ruleId" String "SupportApplAdmRWX_9"
    "ruleName" String "SupportApplAdmRWX_9"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Support_Application_Administrator"
    identity "SupportApplAdmRX_1"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 5
    "ruleData" String "ManagedElement,SystemFunctions,SysM,Schema"
    "ruleId" String "SupportApplAdmRX_1"
    "ruleName" String "SupportApplAdmRX_1"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Support_Application_Administrator"
    identity "SupportApplAdmR_1"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement"
    "ruleId" String "SupportApplAdmR_1"
    "ruleName" String "SupportApplAdmR_1"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Support_Application_Administrator"
    identity "SupportApplAdmR_2"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions"
    "ruleId" String "SupportApplAdmR_2"
    "ruleName" String "SupportApplAdmR_2"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Support_Application_Administrator"
    identity "SupportApplAdmR_3"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions,Fm,*"
    "ruleId" String "SupportApplAdmR_3"
    "ruleName" String "SupportApplAdmR_3"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1"
    identity "Support_Application_User"
    moType ComLocalAuthorization:Role
    exception none
    nrOfAttributes 3
    "roleId" String "Support_Application_User"
    "roleName" String "Support_Application_User"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Support_Application_User"
    identity "ENodeBApplRX_1"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 5
    "ruleData" String "ManagedElement,SystemFunctions,SysM,Schema"
    "ruleId" String "ENodeBApplRX_1"
    "ruleName" String "ENodeBApplRX_1"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Support_Application_User"
    identity "ENodeBApplRX_2"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 5
    "ruleData" String "ManagedElement,SystemFunctions,LogM,*"
    "ruleId" String "ENodeBApplRX_2"
    "ruleName" String "ENodeBApplRX_2"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Support_Application_User"
    identity "SupportApplR_1"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement"
    "ruleId" String "SupportApplR_1"
    "ruleName" String "SupportApplR_1"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Support_Application_User"
    identity "SupportApplR_10"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,Equipment"
    "ruleId" String "SupportApplR_10"
    "ruleName" String "SupportApplR_10"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Support_Application_User"
    identity "SupportApplR_11"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,Equipment,Cabinet,*"
    "ruleId" String "SupportApplR_11"
    "ruleName" String "SupportApplR_11"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Support_Application_User"
    identity "SupportApplR_12"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,Equipment,FieldReplaceableUnit,*"
    "ruleId" String "SupportApplR_12"
    "ruleName" String "SupportApplR_12"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Support_Application_User"
    identity "SupportApplR_13"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,Equipment,ExternalNode,*"
    "ruleId" String "SupportApplR_13"
    "ruleName" String "SupportApplR_13"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Support_Application_User"
    identity "SupportApplR_14"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,Equipment,EcBus,*"
    "ruleId" String "SupportApplR_14"
    "ruleName" String "SupportApplR_14"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Support_Application_User"
    identity "SupportApplR_15"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,Equipment,SupportUnit,*"
    "ruleId" String "SupportApplR_15"
    "ruleName" String "SupportApplR_15"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Support_Application_User"
    identity "SupportApplR_16"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,Equipment,HwGroup,*"
    "ruleId" String "SupportApplR_16"
    "ruleName" String "SupportApplR_16"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Support_Application_User"
    identity "SupportApplR_2"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,EquipmentSupport,*"
    "ruleId" String "SupportApplR_2"
    "ruleName" String "SupportApplR_2"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Support_Application_User"
    identity "SupportApplR_3"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions"
    "ruleId" String "SupportApplR_3"
    "ruleName" String "SupportApplR_3"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Support_Application_User"
    identity "SupportApplR_4"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions,Fm,*"
    "ruleId" String "SupportApplR_4"
    "ruleName" String "SupportApplR_4"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Support_Application_User"
    identity "SupportApplR_5"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions,Pm,*"
    "ruleId" String "SupportApplR_5"
    "ruleName" String "SupportApplR_5"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Support_Application_User"
    identity "SupportApplR_8"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,NodeSupport"
    "ruleId" String "SupportApplR_8"
    "ruleName" String "SupportApplR_8"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=Support_Application_User"
    identity "SupportApplR_9"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,NodeSupport,OnSiteActivities,*"
    "ruleId" String "SupportApplR_9"
    "ruleName" String "SupportApplR_9"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1"
    identity "SystemAdministrator"
    moType ComLocalAuthorization:Role
    exception none
    nrOfAttributes 3
    "roleId" String "SystemAdministrator"
    "roleName" String "SystemAdministrator"
    "userLabel" String "Provides full control over Managed Element model fragments related to System Functions, Equipment and Transport, excluding the fragment related to Security Management"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemAdministrator"
    identity "SysAdmBrM"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,SystemFunctions,BrM,*"
    "ruleId" String "SysAdmBrM"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemAdministrator"
    identity "SysAdmCertM"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions,SecM,CertM,*"
    "ruleId" String "SysAdmCertM"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemAdministrator"
    identity "SysAdmEqm"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,Equipment,*"
    "ruleId" String "SysAdmEqm"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemAdministrator"
    identity "SysAdmEqs"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,EquipmentSupportFunction,*"
    "ruleId" String "SysAdmEqs"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemAdministrator"
    identity "SysAdmFm"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,SystemFunctions,Fm,*"
    "ruleId" String "SysAdmFm"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemAdministrator"
    identity "SysAdmHwIM"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 6
    "ruleData" String "ManagedElement,SystemFunctions,HwInventory,*"
    "ruleId" String "SysAdmHwIM"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemAdministrator"
    identity "SysAdmLm"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,SystemFunctions,Lm,*"
    "ruleId" String "SysAdmLm"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemAdministrator"
    identity "SysAdmLogM"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,SystemFunctions,LogM,*"
    "ruleId" String "SysAdmLogM"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemAdministrator"
    identity "SysAdmME"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement"
    "ruleId" String "SysAdmME"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemAdministrator"
    identity "SysAdmNodeS"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,NodeSupport,*"
    "ruleId" String "SysAdmNodeS"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemAdministrator"
    identity "SysAdmPm"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,SystemFunctions,Pm,*"
    "ruleId" String "SysAdmPm"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemAdministrator"
    identity "SysAdmSF"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,SystemFunctions"
    "ruleId" String "SysAdmSF"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemAdministrator"
    identity "SysAdmSecM"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions,SecM$"
    "ruleId" String "SysAdmSecM"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemAdministrator"
    identity "SysAdmSwIM"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 6
    "ruleData" String "ManagedElement,SystemFunctions,SwInventory,*"
    "ruleId" String "SysAdmSwIM"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemAdministrator"
    identity "SysAdmSwM"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,SystemFunctions,SwM,*"
    "ruleId" String "SysAdmSwM"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemAdministrator"
    identity "SysAdmSysM"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,SystemFunctions,SysM,*"
    "ruleId" String "SysAdmSysM"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemAdministrator"
    identity "SysAdmTN"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,Transport,*"
    "ruleId" String "SysAdmTN"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1"
    identity "SystemReadOnly"
    moType ComLocalAuthorization:Role
    exception none
    nrOfAttributes 3
    "roleId" String "SystemReadOnly"
    "roleName" String "SystemReadOnly"
    "userLabel" String "PRovides read-only access to Managed Element model fragments related to System Functions as well as Equipment and Transport, but excluding the gragments related to Security Management"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemReadOnly"
    identity "SysRoBrM"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions,BrM,*"
    "ruleId" String "SysRoBrM"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemReadOnly"
    identity "SysRoEqm"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,Equipment,*"
    "ruleId" String "SysRoEqm"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemReadOnly"
    identity "SysRoEqs"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,EquipmentSupportFunction,*"
    "ruleId" String "SysRoEqs"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemReadOnly"
    identity "SysRoFm"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions,Fm,*"
    "ruleId" String "SysRoFm"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemReadOnly"
    identity "SysRoHwIM"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions,HwInventory,*"
    "ruleId" String "SysRoHwIM"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemReadOnly"
    identity "SysRoLm"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions,Lm,*"
    "ruleId" String "SysRoLm"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemReadOnly"
    identity "SysRoLogM"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions,LogM,*"
    "ruleId" String "SysRoLogM"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemReadOnly"
    identity "SysRoME_1"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement"
    "ruleId" String "SysRoME_1"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemReadOnly"
    identity "SysRoME_2"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement$"
    "ruleId" String "SysRoME_2"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemReadOnly"
    identity "SysRoNodeS"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,NodeSupport,*"
    "ruleId" String "SysRoNodeS"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemReadOnly"
    identity "SysRoPm"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions,Pm,*"
    "ruleId" String "SysRoPm"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemReadOnly"
    identity "SysRoSF"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions$"
    "ruleId" String "SysRoSF"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemReadOnly"
    identity "SysRoSwIM"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions,SwInventory,*"
    "ruleId" String "SysRoSwIM"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemReadOnly"
    identity "SysRoSwM"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions,SwM,*"
    "ruleId" String "SysRoSwM"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemReadOnly"
    identity "SysRoSysM"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions,SysM,*"
    "ruleId" String "SysRoSysM"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemReadOnly"
    identity "SysRoTN"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,Transport,*"
    "ruleId" String "SysRoTN"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1"
    identity "SystemSecurityAdministrator"
    moType ComLocalAuthorization:Role
    exception none
    nrOfAttributes 3
    "roleId" String "SystemSecurityAdministrator"
    "roleName" String "SystemSecurityAdministrator"
    "userLabel" String "Provides full control over the fragment of a Managed Element model related to Security Management"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemSecurityAdministrator"
    identity "SysSecAdmEqm"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,Equipment,*"
    "ruleId" String "SysSecAdmEqm"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemSecurityAdministrator"
    identity "SysSecAdmFm"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions,Fm,*"
    "ruleId" String "SysSecAdmFm"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemSecurityAdministrator"
    identity "SysSecAdmLicM"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions,Lm,*"
    "ruleId" String "SysSecAdmLicM"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemSecurityAdministrator"
    identity "SysSecAdmLogM"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,SystemFunctions,LogM,*"
    "ruleId" String "SysSecAdmLogM"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemSecurityAdministrator"
    identity "SysSecAdmME"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement$"
    "ruleId" String "SysSecAdmME"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemSecurityAdministrator"
    identity "SysSecAdmSF"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions$"
    "ruleId" String "SysSecAdmSF"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemSecurityAdministrator"
    identity "SysSecAdmSecM"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 7
    "ruleData" String "ManagedElement,SystemFunctions,SecM,*"
    "ruleId" String "SysSecAdmSecM"
    "ruleName" String "null"
    "userLabel" String "null"
)

CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,UserManagement=1,LocalAuthorizationMethod=1,Role=SystemSecurityAdministrator"
    identity "SysSecAdmSwIM"
    moType ComLocalAuthorization:Rule
    exception none
    nrOfAttributes 5
    "permission" Integer 4
    "ruleData" String "ManagedElement,SystemFunctions,SwInventory,*"
    "ruleId" String "SysSecAdmSwIM"
    "ruleName" String "null"
    "userLabel" String "null"
)
SET
(
    mo "ManagedElement=$nodeName,SystemFunctions=1,Pm=1,PmMeasurementCapabilities=1"
    exception none
    nrOfAttributes 1
    "ropFilenameTimestamp" Integer 1
)

DEF
########################################################################
#Making MML script#
########################################################################
cat >> ipworks.mml << ABC
.open $simName
.select $nodeName
.start
setmoattribute:mo="1",attributes="managedElementId(string)=$nodeName";
kertayle:file="$Path/$nodeName.mo";
ABC
########################################################################
moFiles+=($nodeName.mo)
done

/netsim/inst/netsim_pipe < ipworks.mml
for filenum in ${moFiles[@]}
do
rm $filenum
done
rm ipworks.mml
echo "$0 ended at" $( date +%T );



