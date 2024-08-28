#!/bin/bash
########################################################################
# Version     : 17.3
# Revision    :
# Purpose     : Loads features for HLR nodes based on node type
# Description : Creates Mos and sets attributes
# Date        : Jan 2017
# Who         : xmedkar
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
    parent "ManagedElement=$nodeName,SystemFunctions=1,SwInventory=1"
    identity "ERIC-HLRFE_GSNH-APR10159/4-R1A"
    moType CmwSwIM:SwVersion
    exception none
    nrOfAttributes 6
    "administrativeData" Struct
        nrOfElements 6
        "productName" String "ERIC-HLRFE_GSNH"
        "productNumber" String "APR10159/4"
        "productRevision" String "R1A"
        "productionDate" String "05-25-2017"
        "description" String ""
        "type" String ""

    "swVersionId" String "ERIC-HLRFE_GSNH-APR10159/4-R1A"
    "timeOfActivation" String "null"
    "timeOfDeactivation" String "null"
    "timeOfInstallation" String "null"
    "userLabel" String " "
)
CREATE
(
    parent "ManagedElement=$nodeName,SystemFunctions=1,SwInventory=1"
    identity "APG43L-3.4.3-R5E"
    moType CmwSwIM:SwVersion
    exception none
    nrOfAttributes 6
    "administrativeData" Struct
        nrOfElements 6
        "productName" String "APG43L"
        "productNumber" String "3.4.3"
        "productRevision" String "R5E"
        "productionDate" String "11-24-2017"
        "description" String "APG43L SW Version"
        "type" String ""

    "swVersionId" String "APG43L-3.4.3-R5E"
    "timeOfActivation" String "null"
    "timeOfDeactivation" String "null"
    "timeOfInstallation" String "null"
    "userLabel" String ""
)
SET
(
    mo "ManagedElement=$nodeName,SystemFunctions=1,SwInventory=1"
    exception none
    nrOfAttributes 1
     "active" Array Ref 2
    ManagedElement=$nodeName,SystemFunctions=1,SwInventory=1,SwVersion=APG43L-3.4.3-R5E
	ManagedElement=$nodeName,SystemFunctions=1,SwInventory=1,SwVersion=ERIC-HLRFE_GSNH-APR10159/4-R1A
)

DEF
########################################################################
#Making MML script#
########################################################################
cat >> hlr.mml << ABC
.open $simName
.select network
.start
.selectnetype HLR-FE*
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


