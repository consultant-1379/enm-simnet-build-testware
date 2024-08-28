#!/bin/bash
########################################################################
# Version     : 20.12
# Revision    : CXP 903 5174-1-2
# Purpose     : Loads features for Spitfire nodes
# Description : Added support for Router 6273 node
# Date        : Jul 2020
# Who         : zsujmad
########################################################################
########################################################################
# Version     : 16.16
# Revision    : CXP 903 5174-1-1
# Purpose     : Loads features for Spitfire nodes
# Description : Creates MOs and sets attribute values
# Date        : Oct 2016
# Who         : xgouhar
########################################################################
########################################################################
#Script Usage#
########################################################################
usage (){

echo "Usage  : $0 <sim name>  "

echo "Example: $0 GSM-TCU04-T16B-V6x5"

}
neType(){

echo "ERROR: The script runs only for norm nodes"
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
#To check the if simname is SpitFire
########################################################################
if [[ $simName != *"6675"* && $simName != *"6273"* && $simName != *"6676"* && $simName != *"6678"* ]]
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
    parent "ComTop:ManagedElement=1,Router6000Equipment:Equipment=1"
    identity "1"
    moType Router6000Equipment:AttachedUnit
    exception none
    nrOfAttributes 13
    "connectedAUType" Integer "null"
    "configuredAUType" Integer "null"
    "temp" Int32 "null"
    "attachedPort" String "null"
    "timeOfConnection" Uint64 "null"
    "timeOfRunning" Int64 "null"
    "replaceableUniteId" String "1"
    "position" Struct
        nrOfElements 2
        "name" String ""
        "physicalPosition" String ""

    "operationalState" Integer 0
    "availStatus" Integer 0
    "administrativeState" Integer 0
    "userLabel" String "null"
    "typeOfHw" String "null"
)
SET
(
    mo "ComTop:ManagedElement=1,Router6000Equipment:Equipment=1,Router6000Equipment:AttachedUnit=1,Router6000_AbisAndCES:Tdm1001=1"
    exception none
    nrOfAttributes 1
    "tdm1001Key" String "1"
)

CREATE
(
    parent "ComTop:ManagedElement=1,Router6000Equipment:Equipment=1,Router6000Equipment:AttachedUnit=1,Router6000_AbisAndCES:Tdm1001=1"
    identity "1"
    moType Router6000_AbisAndCES:Tdm1001PdhPort
    exception none
    nrOfAttributes 9
    "tdm1001PdhPortId" String "1"
    "adminStatus" Integer 0
    "description" String "E1_T1 Electrical"
    "operStatus" Integer "null"
    "linkStatus" Integer "null"
    "clockSource" Integer "null"
    "lineCoding" Integer 1
    "ds1CableLength" Integer 133
    "loopback" Integer 1
)




DEF

cat >> norm.mml << ABC
.open $simName
.select $nodeName
.start
kertayle:file="$Path/$nodeName.mo";
ABC

moFiles+=($nodeName.mo)
done


/netsim/inst/netsim_pipe < norm.mml
for filenum in ${moFiles[@]}
do
rm $filenum
done
rm norm.mml *.txt
echo "$0 ended at" $( date +%T );


