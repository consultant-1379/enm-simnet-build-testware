#!/bin/sh
########################################################################
# Version     : 21.14
# Revision    : CXP 903 5174-1-1
# Purpose     : CSCF 2k Mos per node bulkup
# Description : Bulking up Mos for CSCF
# Date        : August 2021
# Who         : zchianu
########################################################################

#simulationsList=`echo -e ".show simulations" | /netsim/inst/netsim_shell | grep -v ".zip" | grep -v "default" | grep -v ">>" | grep "CSCF-1.13"`
simname=$1
#simulations=(${simulationsList// / })
#for simname in ${simulations[@]:1}
#do
echo $simname


nodeList=`echo -e '.open '$simname' \n .show simnes' | /netsim/inst/netsim_shell | grep "CSCF"| grep -v ">>" | cut -d" " -f1`

MMLSCRIPT=$simname"_CSCF.mml"

nodes=(${nodeList// / })
for node in ${nodes[@]}
do
for i in $(seq 1 50);
do
cat >> $node.mo << ABC
CREATE
(
    parent "ComTop:ManagedElement=$node,CscfFunction:CscfFunction=1,NumberNormalisation:NumberNormalisation=1"
    // moid = 1721
    identity "$i"
    moType NumberNormalisation:NumNormProfile
    exception none
    nrOfAttributes 10
    "numNormProfile" String "$i"
    "numNormProfileName" String "null"
    "numNormProfileContext" Array String 0
    "numNormProfileUserEqPhoneEr" Integer 0
    "numNormProfileDomNameEr" Array String 0
    "numNormProfileWarningText" String "null"
    "ownerId" Uint32 0
    "groupId" Uint32 0
    "shareTree" String "nodeName=jambala"
    "permissions" Int64 9
)
ABC
done

cat >> cscf.mml << ABC
.open $simname
.select $node
.start
kertayle:file="$PWD/$node.mo";
createmo:parentid="ManagedElement=$node,CscfFunction=1,NumberNormalisation=1,NumNormProfile=1",type="NumNormContext",name="MO12", quantity=250;
createmo:parentid="ManagedElement=$node,CscfFunction=1,NumberNormalisation=1,NumNormProfile=2",type="NumNormDenormalizationSubstitutionRule",name="MO12", quantity=250;
createmo:parentid="ManagedElement=$node,CscfFunction=1,NumberNormalisation=1,NumNormProfile=3",type="NumNormNsnData",name="MO12", quantity=250;
createmo:parentid="ManagedElement=$node,CscfFunction=1,NumberNormalisation=1,NumNormProfile=4",type="NumNormOsnData",name="MO12", quantity=250;
createmo:parentid="ManagedElement=$node,CscfFunction=1,NumberNormalisation=1,NumNormProfile=5",type="NumNormSubstitutionRule",name="MO12", quantity=250;

ABC
done
#done
/netsim/inst/netsim_shell < cscf.mml
rm -rf *.mml
rm -rf *.mo
