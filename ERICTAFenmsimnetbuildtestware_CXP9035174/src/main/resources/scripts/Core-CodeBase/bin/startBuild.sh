#!/bin/bash
########################################################################
# Version5    : 21.06
# Revision    : CXP 903 5174-1-23
# Purpose     : Support for SCU node
# Date        : Mae 2021
# Who         : zhainic
########################################################################
########################################################################
# Version4    : 21.05
# Revision    : CXP 903 5174-1-22
# Purpose     : Support for Router6673 node
# Date        : Feb 2021
# Who         : zhainic
########################################################################
########################################################################
# Version3    : 21.04
# Revision    : CXP 903 5174-1-21
# Description : Giving support for Controller6610 in jar file(1.0.10).
# Date        : Jan 2021
# Who         : zsujmad
########################################################################
########################################################################
# Version2    : 20.12
# Revision    : CXP 903 5174-1-12
# Description : Giving support for Router 6273 in jar file(1.0.9).
# Date        : July 2020
# Who         : zsujmad
########################################################################
########################################################################
# Version1    : 20.03
# Revision    : CXP 903 5174-1-11
# Description : Giving support for cloning the nodes.
# Date        : Jan 2020
# Who         : zchianu
########################################################################

usage (){

echo "Usage  : $0 <sim name> <netypeLink> <basename> <numofnodes> <nodeType>"

echo "Example: $0 CORE-ST-4.5K-SGSN-16A-CP03x4 ftp://ftp.lmera.ericsson.se/project/netsim-ftp/simulations/NEtypes/com3.1/SGSN_16A-CP02-WPP-V3_R29D.zip CORE09SGSN 4 COM/ECIM"

}
########################################################################
#To check commandline arguments#
########################################################################
if [ $# -ne 5 ]
then
usage
exit 1
fi
#######################################################################
#Parameters
#######################################################################
simName=$1
nodeSupportLink=$2
baseName=$3
numOfNodes=$4
nodeType=$5
Path=`pwd`
######################################################################
#Deleting existing logs
######################################################################
cd $PWD/log/
rm -rf *.log
cd $Path
#######################################################################
#Capture Logs
#######################################################################
DATE=`date +%F`
TIME=`date +%T`
LOGFILE=$PWD/log/BuildCoreLogs.log
#######################################################################
#Check NodeType
#######################################################################
cd /netsim/netsimdir

if [[ $nodeType == "COM/ECIM" || $nodeType == "CPP" ]]
then
nodeSupport=`echo $nodeSupportLink | rev | cut -d "/" -f1 | rev`
nodeSupportWithoutzip=`echo $nodeSupport | cut -d '.' -f1`
rm -rf /netsim/netsimdir/${nodeSupport}
wget $nodeSupportLink
echo "nodeSupportSim is $nodeSupportWithoutzip"

#########################################################################
#Check if node template exist
########################################################################

rm -rf /netsim/netsimdir/${nodeSupportWithoutzip} 

#########################################################################
#extract neType
#########################################################################

echo -e ".uncompressandopen ${nodeSupport} force" | /netsim/inst/netsim_pipe | tee -a $LOGFILE
neType=`echo -e ".open $nodeSupportWithoutzip \n.show simnes" | /netsim/inst/netsim_pipe |  awk '/OK/{f=0;};f{print $2 " " $3 " " $4;};/NE Name/{f=1;}'`

else
neType=$nodeSupportLink
echo -e "$neType\n"
fi
##########################################################################
#Check if simulation exist
if [ -s /netsim/netsimdir/$simName ]
then
echo -e "INFO: Deleting existing simulation"
echo -e ".open $simName\n.select network\n.stop\n.deletesimulation $simName force" | /netsim/inst/netsim_pipe | tee -a $LOGFILE
echo -e "INFO: deleted successfully"
else
echo ""
fi
############################################################################
cd $Path

Basic_Nodename=`echo -e ".open $nodeSupportWithoutzip \n.show simnes" | ~/inst/netsim_shell | awk -F " " '{print $1}' | sed -n 5p`

if [[ $neType == *"BB ML"* ]] || [[ $neType == *"BB Router"* ]] || [[ $neType == *"GSM ERS-SN"* ]] || [[ $neType == *"GSM STN ESC"* ]]  || [[ $neType == *"LTE FrontHaul"* ]] || [[ $neType == *"BB FrontHaul"* ]]  || [[ $neType == *"GSM STN"* ]] || [[ $neType == *"GSM TCU04"* ]] || [[ $neType == *"BB JUNIPER"* ]] || [[ $neType == *"BB vBNG"* ]] || [[ $neType == *"BB CISCO"* ]] || [[ $neType == *"GSM LANSWITCH"* ]]  || [[ $neType == *"CORE EPG-SSR"* ]] || [[ $neType == *"BB SSR"* ]] || [[ $neType == *"CORE R6"* ]] || [[ $neType == *"BB ESC"* ]] || [[ $neType == *"LTE CONTROLLER6610"* ]] || [[ $neType == *"CORE R6673"* ]] || [[ $neType == *"LTE SCU"* ]] || [[ $neType == *"CORE R6676"* ]] || [[ $neType == *"Core R6678"* ]]
then
    if [[ $simName == *"CORE"* ]] || [[ $baseName == *"CORE"* ]]
    then
        echo "ERROR: $neType is Transport node it should not contain CORE in simName or baseName"
        exit 1
    fi
fi

echo -e "\nStarting $simName build\n"
#java -jar coreAutomation-1.0.5.jar $simName "$neType" $baseName $numOfNodes | tee -a $LOGFILE
if [[ $simName == *"FrontHaul-6020"* || $simName == *"FrontHaul-6650"* || $simName == *"FrontHaul-6000"* || $simName == *"JUNIPER"* || $simName == *"LANSWITCH"* || $simName == *"CISCO"* || $simName == *"EXTREME"* || $simName == *"ML6200"* || $simName == *"MLTN"* || $simName == *"ML6351"* || $simName == *"CISCO"* || $simName == *"ML6366"* || $simName == *"ML6391"* || $simName == *"ML6651"* || $simName == *"ML6371"* || $simName == *"ML6654"* || $simName == *"ML6691"* || $simName == *"ML6692"* || $simName == *"ML6693"* || $simName == *"ECI"* || $simName == *"HDS"* || $simName == *"MLPT2020"* || $simName == *"CUDB"* || $simName == *"SCEF"* || $simName == *"ML6352"* || $simName == *"SGSN"* || $simName == *"MGw"* || $simName == *"MRS"* || $simName == *"ERS"*  || $simName == *"ECEE"* || $simName == *"SDI"* ]]
then
java -cp coreAutomation-create-1.0.8.jar com.ericsson.simnet.core_automation.AutomationGUI $simName "$neType" $baseName $numOfNodes | tee -a $LOGFILE
else
java -cp coreAutomation-1.0.15.jar com.ericsson.simnet.core_automation.AutomationGUI $simName "$neType" $baseName $numOfNodes "$nodeSupportWithoutzip" "$Basic_Nodename"| tee -a $LOGFILE
rm -rf *.mo *.mml

$Path/set_ManagedElementId.sh $simName $Basic_Nodename $baseName $neType | tee -a $LOGFILE

cd $Path
echo shroot | sudo -S -H -u root bash -c "rm Result.log"
echo shroot | sudo -S -H -u root bash -c "perl ./PmCheck.pl $simName" | tee -a $LOGFILE
cd -

CmdResult=`cat $Path/Result.log | grep -i failed | wc -l`
if [ "$CmdResult" == "0" ]
then
  echo "################################################" | tee -a $LOGFILE 
  echo "Pm Data is proper on the Nodes" | tee -a $LOGFILE
  echo "#################################################" | tee -a $LOGFILE
else
  echo "******************  OOPS!!   *******************" | tee -a $LOGFILE
  echo "Pm Data is not properly loaded on nodes" | tee -a $LOGFILE
  echo "Please check the PM data on nodes with the respective MIB file" | tee -a $LOGFILE
  echo "************************************************" | tee -a $LOGFILE
  echo "We are exiting from Sim Build " | tee -a $LOGFILE
  echo "************************************************" | tee -a $LOGFILE
  exit 123
fi
fi
################################################################################
#Loading corresponding features
#############################################################################

$Path/loadFeatures.sh $simName $numOfNodes $baseName | tee -a $LOGFILE

#############################################################################
##############################################################################
#Copying SimnetRevision details
##############################################################################

$Path/WriteSimData.sh $simName | tee -a $LOGFILE


##############################################################################
#Updating IPs
#####################################################################

echo "Running python script for Updating IP values on $simName : "

cd $Path/Updating_IPs/

chmod 777 *

echo "shroot" | sudo -S python new_updateip.py -deploymentType mediumDeployment -release 22.03 -simLTE NO_NW_AVAILABLE -simWRAN NO_NW_AVAILABLE -simCORE $simName  -switchToRv no -IPV6Per yes -docker no

echo "Completed...IP Details are updated in the Simulation folder"

##################################################################################
#final zip of simulation
##################################################################################

echo -e ".open $simName \n.saveandcompress $simName force " | /netsim/inst/netsim_pipe | tee -a $LOGFILE
echo -e "\nINFO: Simulation build is completed\n"
rm -rf *.mml *.mo *.txt;


