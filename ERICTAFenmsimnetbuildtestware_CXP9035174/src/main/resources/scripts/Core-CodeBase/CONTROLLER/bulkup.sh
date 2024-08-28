#!/bin/bash
########################################################################
# Version3    : 21.05
# Revision    : CXP 903 5174-1-23
# Purpose     : To bulkup MOs for NEE_Controller_3KNodes
# Date        : Feb 2021
# Who         : zsujmad
########################################################################
SIMNAME=$1

printf  ".open $1 \n .show simnes" | /netsim/inst/netsim_shell |grep -v ">>" | grep -w "CONTROLLER6610" | awk '{print $1}' > $1_file.txt

for nodeNAME in $(cat $1_file.txt)
do
cat >> $nodeNAME.mml << JKL
.open $SIMNAME
.select $nodeNAME
.start
useattributecharacteristics:switch="off";
createmo:parentid="ManagedElement=$nodeNAME,SystemFunctions=1,Lm=1",type="FeatureState",name="MO12", quantity=51;
createmo:parentid="ManagedElement=$nodeNAME,SystemFunctions=1,Lm=1",type="FeatureKey",name="MO12", quantity=50;
createmo:parentid="ManagedElement=$nodeNAME,SystemFunctions=1,Lm=1",type="CapacityState",name="MO12", quantity=50;
createmo:parentid="ManagedElement=$nodeNAME,SystemFunctions=1,Lm=1",type="CapacityKey",name="MO12", quantity=50;
createmo:parentid="ManagedElement=$nodeNAME,SystemFunctions=1,HwInventory=1",type="HwItem",name="MO12", quantity=50;
createmo:parentid="ManagedElement=$nodeNAME,Equipment=1,FieldReplaceableUnit=1",type="EFuse",name="MO12", quantity=40;
JKL

/netsim/inst/netsim_pipe < $nodeNAME.mml
rm $nodeNAME.mml
done
