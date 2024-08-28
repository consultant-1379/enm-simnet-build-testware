#!/bin/sh

########################################################################
# Version3    : 20.03
# Revision    : CXP 903 5174-1-11
# Description : Copying Automation logs to SimnetRevision
# Date        : Jan 2020
# Who         : zchianu
########################################################################
########################################################################
# Version2    : 20.02
# Revision    : CXP 903 5174-1-6
# Description : Copying logfiles and README to SimnetRevision
# Date        : Dec 2019
# Who         : zyamkan
########################################################################
########################################################################
# Version1    : 19.17
# Revision    : CXP 903 5174-1-1
# Who         : zchianu
########################################################################

SIMNAME=$1
path=`pwd`

cd /netsim/netsimdir/$SIMNAME/
if [ -d SimnetRevision ]
then
rm -rf SimnetRevision
mkdir SimnetRevision
else
mkdir SimnetRevision
fi


cp $path/README /netsim/netsimdir/$SIMNAME/SimnetRevision/

cp $path/log/BuildCoreLogs.log /netsim/netsimdir/$SIMNAME/SimnetRevision/

cp -r $path/Automation_Logs/ /netsim/netsimdir/$SIMNAME/SimnetRevision/
