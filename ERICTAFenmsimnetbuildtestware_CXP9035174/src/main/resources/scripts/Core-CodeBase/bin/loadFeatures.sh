#!/bin/bash
########################################################################
# Version8    : 21.08
# Revision    : CXP 903 5174-1-33
# Purpose     : Support for unit test for controller modified
# Date        : Apr 2021
# Who         : zsujmad
########################################################################
########################################################################
# Version8    : 21.06
# Revision    : CXP 903 5174-1-28
# Purpose     : Support for unit test for controller
# Date        : Mar 2021
# Who         : zsujmad
########################################################################
########################################################################
# Version8    : 21.06
# Revision    : CXP 903 5174-1-23
# Purpose     : Support for SCU node
# Date        : Mae 2021
# Who         : zhainic
########################################################################
########################################################################
# Version7    : 21.05
# Revision    : CXP 903 5174-1-22
# Purpose     : Support for Router6673 node
# Date        : Feb 2021
# Who         : zhainic
########################################################################
########################################################################
# Version6    : 21.04
# Revision    : CXP 903 5174-1-21
# Purpose     : Support for Controller6610 node
# Date        : Jan 2021
# Who         : zsujmad
########################################################################
########################################################################
# Version1    : 20.02
# Revision    : CXP 903 5174-1-6
# Purpose     : Support for vSAPC along ESAPC node
# Date        : Dec 2019
# Who         : zyamkan
########################################################################
########################################################################
# Version2    : 20.07
# Revision    : CXP 903 5174-1-13
# Purpose     : Support for ALD links in ML6691
# Date        : April 2020
# Who         : xharidu
########################################################################
########################################################################
# Version3    : 20.09
# Revision    : CXP 903 5174-1-14
# Purpose     : Support for vNSDS node and it is based on WCG node
# Date        : May 2020
# Who         : zyamkan
########################################################################
########################################################################
# Version4    : 20.12
# Revision    : CXP 903 5174-1-15
# Purpose     : Support for R6273 node based on R6675 node
# Date        : Jul 2020
# Who         : zsujmad
########################################################################
#Version5     : 1.1
#Revision     : CXP 903 5174-1-20
#Purpose      : Adding Ciphers support for CSCF,R6x71,Router6672,Router6675,SBG,vSAPC,MTAS,BSC,Router6274,DSC,wMG,EPG,HSS-FE,IP-WORKS
#               BGF,BSP,MRF,vEME
#Date         : Nov 2020
#who          : zhainic
########################################################################
simName=$1
baseName=$3
numOfNodes=$2
echo -e "\nINFO: Loading Features on the nodes\n"

if [[ $simName == *"TSP"* || $simName == *"APG43L"* || $simName == *"IS55"* ]]
then
exit 0

elif [[ $simName == *"TCU02"* ]]
then
$PWD/../TCU02/TCU02Features.sh $simName

elif [[ $simName == *"HLR"* ]]
then
$PWD/../HLR-FE/hlrFeatures.sh $simName
$PWD/../HLR-FE/hlrProductData.sh $simName

elif [[ $simName == *"SIU02"* ]]
then
$PWD/../SIU02/SIU02Features.sh $simName

elif [[ $simName == *"CUDB"* ]]
then
$PWD/../CUDB/cudbFeatures.sh $simName


elif [[ $simName == *"vBGF"* ]]
then
$PWD/../BGF/bgfFeatures.sh $simName
$PWD/../BGF/updateCiphers.sh $simName

elif [[ $simName == *"BSC"* ]]
then
$PWD/../BSC/bscFeatures.sh $simName
$PWD/../BSC/updateCiphers.sh $simName

elif [[ $simName == *"NELS"* ]]
then
$PWD/../NELS/nelsfeatures.sh $simName

elif [[ $simName == *"BSP"* ]]
then
$PWD/../BSP/bspFeatures.sh $simName
$PWD/../BSP/updateCiphers.sh $simName

elif [[ $simName == *"C608"* ]]
then
$PWD/../C608/c608Features.sh $simName

elif [[ $simName == *"CSCF"* ]]
then
$PWD/../CSCF/cscfFeatures.sh $simName
$PWD/../CSCF/updateCiphers.sh $simName
cd $PWD/../CSCF/
echo -e "INFO:Running attributes jar\n"
java -cp setMoAttributes.jar com.ericsson.simnet.core.Main $simName $numOfNodes $baseName
echo -e "INFO: loaded all attributes successfully\n"
cd $PWD

elif [[ $simName == *"DSC"* ]]
then
$PWD/../DSC/dscFeatures.sh $simName
$PWD/../DSC/updateCiphers.sh $simName

elif [[ $simName == *"CCN"* ]]
then 
$PWD/../CCN/dscFeatures.sh $simName
$PWD/../CCN/updateCiphers.sh $simName

elif [[ $simName == *"ECM"* ]]
then
$PWD/../ECM/ecmFeatures.sh $simName

elif [[ $simName == *"vEME"* ]]
then
$PWD/../EME/emeFeatures.sh $simName
$PWD/../EME/updateCiphers.sh $simName

elif [[ $simName == *"EPG"* || $simName == *"vEPG"* ]]
then
$PWD/../EPG/EpgFeatures.sh $simName
$PWD/../EPG/updateCiphers.sh $simName

elif [[ $simName == *"SAPC"* ]]
then
$PWD/../ESAPC/vSAPCFeatures.sh $simName
$PWD/../ESAPC/updateCiphers.sh $simName

elif [[ $simName == *"FrontHaul"* ]]
then
    if [[ $simName == *"6020"* || $simName == *"6650"* || $simName == *"6000"* ]]
    then
        $PWD/../FronthAul6020/FronthAul6020Features.sh $simName
    else
        $PWD/../FronthAul/FronthAulFeatures.sh $simName
    fi

elif [[ $simName == *"HSS-FE"* ]]
then
$PWD/../HSS/hssFeatures.sh $simName
$PWD/../HSS/updateCiphers.sh $simName

elif [[ $simName == *"IPWORKS"* ]]
then
$PWD/../IPWORKS/ipWorks.sh $simName
$PWD/../IPWORKS/updateCiphers.sh $simName

elif [[ $simName == *"MGw"* ]]
then
$PWD/../MGw/MGwFeatures.sh $simName
$PWD/../MGw/updateCiphers.sh $simName

elif [[ $simName == *"MRS"* ]]
then
$PWD/../MRS/MRSFeatures.sh $simName
$PWD/../MRS/updateCiphers.sh $simName

elif [[ $simName == *"ML"* ]]
then
$PWD/../MiniLink/miniLinkFeatures.sh $simName
if [[ $simName == *"ML6691-1-5-1"* ]]
then
$PWD/../MiniLink/set_ALDlinks.sh $simName
fi
if [[ $simName == *"ML6352"* && $simName == *"Transport42"* ]]
then
$PWD/../MiniLink/applyRLTandLLDP.sh $simName
fi
if [[ $simName == *"ML6693"* && $simName == *"CORE81"* ]]
then
$PWD/../MiniLink/Updatelinks.sh $simName
fi
elif [[ $simName == *"MRFv"* ]]
then
$PWD/../MRF/mrfFeatures.sh $simName
$PWD/../MRF/updateCiphers.sh $simName

elif [[ $simName == *"MTAS"* ]]
then
$PWD/../MTAS/mtasFeatures.sh $simName
$PWD/../MTAS/updateCiphers.sh $simName

elif [[ $simName == *"SBG"* ]]
then
$PWD/../SBG/sbgFeatures.sh $simName
$PWD/../SBG/updateCiphers.sh $simName

elif [[ $simName == *"SGSN"* ]]
then
$PWD/../Sgsn/sgsnFeatures.sh $simName
cd $PWD/../Sgsn/
echo -e "\nINFO:Running attributes jar\n"
java -cp setMoAttributes.jar com.ericsson.simnet.core.Main $simName $numOfNodes $baseName
echo -e "\nINFO: loaded all attributes successfully\n"
cd $PWD

elif [[ $simName == *"Spit"* ]]
then
$PWD/../SpitFire/SpitFireFeatures.sh $simName
$PWD/../SpitFire/normalisation.sh $simName
$PWD/../SpitFire/schema.sh $simName

elif [[ $simName == *"Router6274"* ]]
then
$PWD/../SpitFire/SpitFireFeatures.sh $simName
$PWD/../SpitFire/schema.sh $simName
$PWD/../SpitFire/updateCiphers.sh $simName

elif [[ $simName == *"Router6371"* || $simName == *"Router6471-1"* || $simName == *"Router6471-2"* ]]
then
$PWD/../SpitFire/SpitFireFeatures.sh $simName
$PWD/../SpitFire/normalisation.sh $simName
$PWD/../SpitFire/schema.sh $simName
$PWD/../SpitFire/updateCiphers.sh $simName

elif [[ $simName == *"Router6672"* ]]
then
$PWD/../Router6672/Router6672Features.sh $simName
$PWD/../Router6672/updateCiphers.sh $simName

elif [[ $simName == *"Router6675"* || $simName == *"Router6273"* || $simName == *"Router6673"* || $simName == *"Router6676"* || $simName == *"Router6678"* ]]
then
$PWD/../Router6675/Router6675Features.sh $simName
$PWD/../Router6675/normalisation.sh $simName
$PWD/../Router6675/schema.sh $simName
    if [[ $simName == *"Router6675"* || $simName == *"Router6673"* || $simName == *"Router6676"* || $simName == *"Router6678"* ]]
    then
        $PWD/../Router6675/updateCiphers.sh $simName
    fi
elif [[ $simName == *"TCU04"* ]]
then
$PWD/../TCU/TCUFeatures.sh $simName
$PWD/../TCU/updateCiphers.sh $simName

elif [[ $simName == *"vWCG"* ]]
then
$PWD/../WCG/wcgFeatures.sh $simName


elif [[ $simName == *"vNSDS"* ]]
then
    $PWD/../NSDS/NSDSFeatures.sh $simName


elif [[ $simName == *"WMG"* || $simName == *"vWMG"* ]]
then
$PWD/../WMG/wmgFeatures.sh $simName
$PWD/../WMG/updateCiphers.sh $simName

elif [[ $simName == *"UPG"* ]]
then
$PWD/../UPG/upgFeatures.sh $simName

elif [[ $simName == *"CONTROLLER"* ]]
then
$PWD/../CONTROLLER/controllerFeatures.sh $simName
$PWD/../CONTROLLER/checkMOs_unitTest.sh $simName

elif [[ $simName == *"SCU"* && $simName != *"SN-SCU"* ]]
then
$PWD/../SCU/scuFeatures.sh $simName

elif [[ $simName == *"ESC"* ]]
then
$PWD/../ESC/escFeatures.sh $simName

fi
