#!/bin/sh

########################################################################
# Version1    : 20.03
# Revision    : CXP 903 5174-1-11
# Description : Changing managed element id to nodename after cloning the base node.
# Date        : Jan 2020
# Who         : zchianu
########################################################################
########################################################################

SIMNAME=$1
Basic_Nodename=$2
baseName=$3
neType=$4
path=`pwd`

NodesList=`echo -e ".open $SIMNAME \n .show simnes" | /netsim/inst/netsim_shell | grep "$neType" | cut -d" " -f1`
for Node in ${NodesList[@]}
do
            echo -e ".open ${SIMNAME} \n .select ${Node} \n .start \n setmoattribute:mo=\"ManagedElement=$Basic_Nodename\", attributes = \"managedElementId(string )=${Node}\"; \n .restart \n .stop" | /netsim/inst/netsim_shell | tee -a  $path/log/BuildCoreLogs.log
        done

