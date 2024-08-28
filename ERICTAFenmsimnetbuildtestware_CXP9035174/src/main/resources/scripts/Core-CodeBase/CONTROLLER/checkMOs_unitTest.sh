#!/bin/sh
########################################################################
# Version2    : 21.08
# Revision    : CXP 903 5174-1-33
# Purpose     : To check HcRule MOs
# Date        : Apr 2021
# Who         : zsujmad
########################################################################
########################################################################
# Version1    : 21.06
# Revision    : CXP 903 5174-1-28
# Purpose     : Unit test for controller to check UnitTemperatureLevelLog
# Date        : Mar 2021
# Who         : zsujmad
########################################################################
SIMNAME=$1

echo "#################################################################"
echo -e  '.open '$SIMNAME' \n .show simnes' | /netsim/inst/netsim_shell | grep -v ">" | grep -v "OK" | grep -v "NE" | awk '{print $1}' > ${SIMNAME}_file.txt 

echo "INFO: Checking if UnitTemperatureLevelLog and HcRule MOs are present on $SIMNAME"

for NODENAME in $(cat ${SIMNAME}_file.txt)
do

cat >> $NODENAME.mml << ABC
.open $1
.select $NODENAME
.start
dumpmotree:moid=1,ker_out,outputfile="${PWD}/${NODENAME}";
.stop
ABC

/netsim/inst/netsim_pipe -q < $NODENAME.mml | grep -v "OK"

if [[ `grep -ic UnitTemperatureLevelLog $NODENAME` > 0 ]]; then
  echo -e "PASSED: UnitTemperatureLevelLog is present on $NODENAME\n" | tee -a status.log
else
  echo -e "FAILED: UnitTemperatureLevelLog IS NOT PRESENT on $NODENAME\n" | tee -a status.log
fi

if [[ `grep -ic SystemFunction_CheckDiskSpace $NODENAME` > 0 ]]; then
  echo -e "PASSED: SystemFunction_CheckDiskSpace HcRule is present on $NODENAME\n" | tee -a status.log
else
  echo -e "FAILED: SystemFunction_CheckDiskSpace HcRule IS NOT PRESENT on $NODENAME\n" | tee -a status.log
fi

if [[ `grep -ic SystemFunction_CheckNumberUP $NODENAME` > 0 ]]; then
  echo -e "PASSED: SystemFunction_CheckNumberUP HcRule is present on $NODENAME\n" | tee -a status.log
else
  echo -e "FAILED: SystemFunction_CheckNumberUP HcRule IS NOT PRESENT on $NODENAME\n" | tee -a status.log
fi
rm -rf $NODENAME
rm -rf $NODENAME.mml
done

if [[ `grep -ic FAILED status.log` == 0 ]]; then
  echo -e "SUCCESS: All nodes in $SIMNAME have UnitTemperatureLevelLog, SystemFunction_CheckDiskSpace and SystemFunction_CheckNumberUP MOs\n"
else
  echo -e "ERROR: Unit Test for $SIMNAME FAILED\n"
  exit 1
fi
echo "#################################################################"
rm -rf $SIMNAME.txt
