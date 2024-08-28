#!/bin/bash
########################################################################
# Version     : 16.16
# Revision    : CXP 903 5174-1-1
# Purpose     : Loads exception for hlr sims
# Description : Creates Mos and sets attributes
# Date        : Oct 2016
# Who         : xgouhar
########################################################################
########################################################################
#Script Usage#
########################################################################
usage (){

echo "Usage  : $0 <sim name> "


}
neType(){

echo "ERROR: The script runs only for hlr nodes"
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
#To check the if simname is hlr#
########################################################################
if [[ $simName != *"HLR"* ]]
then
neType
exit 1
fi

echo "$0 started running at" $(date +%T)
########################################################################
#Making MML script#
########################################################################
cat >> hlr.mml << ABC
.open $simName 

.new exception show3
.set infotxt show3
.set language ap
.set priority 1
.set netype
.set commands show
.set condition always []
.set action direct_answer [{message_or_file,"ManagedElement=1"}]
.set save

.stop 

.selectnetype HLR-FE*
.selectnetype vHLR-BS*
.exceptionhandling
.select show3
.exception on
.popselected
.restart
ABC
#######################################################################


/netsim/inst/netsim_pipe < hlr.mml
rm hlr.mml *.txt
echo "$0 ended at" $( date +%T );




