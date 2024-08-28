#!/bin/bash

### VERSION HISTORY
#####################################################################################
##     Version     : 1.0
##
##     Author      : zsujmad
##
##     JIRA        : NSS-30396
##
##     Description : Automating the build process by fetching basename from ESC.
##                   Installs patches if any.
##
##     Date        : 15th May 2020
##
######################################################################################
#####################################################################################

if [ "$#" -ne 6 ]
then
cat<<HELP

####################
# HELP
####################

Usage  : $0 <SimName> <NodeType> <NetworkSize> <DropNumber> <nodeTemplate> <PatchList(if any)>

Example: $0 CORE-ST-SGSN-1.36-V1x25 COM/ECIM enmTeamNetwork-1.8K 20.06 https://netsim.seli.wh.rnd.internal.ericsson.com/tssweb/simulations/com3.1/SGSN_1-60-WPP-V1_CXS101289_R121D19.zip http://netsim.lmera.ericsson.se/tssweb/patches/P08370.zip

Note   : If there are multiple patches, separate them with a comma(,)

HELP

exit 1
fi

chmod -R 777 /netsim/Core_Build/
####################################################################################
SIMNAME=$1
NODETYPE=$2
NETWORKSIZE=$3
DROP=$4
node_template=$5
PATCHLIST=$6
key='"type": '\"$NETWORKSIZE\"
echo "PATCHLIST is $PATCHLIST"
closing_tag="]}"
NumOfNodes=`echo $SIMNAME | cut -d 'x' -f 2 | cut -d '-' -f 1`
#####################################################################################

curl "https://nss.seli.wh.rnd.internal.ericsson.com/NetworkConfiguration/rest/config/${DROP}/" > esc_details.json

cat esc_details.json | awk -v FS="(${NETWORKSIZE}|${closing_tag})" '{print $2}' > ${NETWORKSIZE}.txt
sed 's/} , {/\n/g' ${NETWORKSIZE}.txt > final.txt

NodeNames=`cat final.txt | grep $SIMNAME | sed 's/,/\n/g' | grep "IPv4 Nodes" | cut -d ":" -f 2 | xargs`
count=`echo ${#NodeNames}`
mark=$((count/2))
NodeName=`echo $NodeNames | cut -c1-$mark`
BaseName=`echo $NodeName | rev | cut -c3- | rev`

######################################################################################
if [ $PATCHLIST != "NA" ]; then
IFS=',' read -r -a patches <<< "$PATCHLIST"

for patchLink in "${patches[@]}"
do
	wget -P /netsim/inst $patchLink
	patchName=`echo $patchLink | rev | cut -d '/' -f 1 | rev`
	su netsim -c "echo -e '.install patch $patchName' | /netsim/inst/netsim_shell"
done
fi
######################################################################################

if [[ $SIMNAME =~ ^"CORE" ]]
then
	echo "SIMNAME starts with keyword CORE"
	if [[ $SIMNAME =~ "ST" ]]
	then
		nodeType=`echo "$SIMNAME" | cut -d 'x' -f 1 | awk -F "ST-" '{print $2}'`
		echo $nodeType
                vals=(${nodeType//-/ })
		STR=""
                for i in "${vals[@]}"
                do
                  STR=$STR$i".*"
                done
                templateURL=`cat /netsim/simdepContents/nodeTemplate.content | grep "/$STR" | xargs`
		echo $templateURL
	elif [[ $SIMNAME =~ "FT" ]]
	then
		nodeType=`echo "$SIMNAME" | cut -d 'x' -f 1 | awk -F "FT-" '{print $2}'`
                echo $nodeType
                vals=(${nodeType//-/ })
                STR=""
                for i in "${vals[@]}"
                do
                  STR=$STR$i".*"
                done
                templateURL=`cat /netsim/simdepContents/nodeTemplate.content | grep "/$STR" | xargs`
                echo $templateURL
	fi
else
	echo "SIMNAME starts with node name"
	nodeType=`echo "$SIMNAME" | cut -d 'x' -f 1`
	echo $nodeType
	vals=(${nodeType//-/ })
        STR=""
                for i in "${vals[@]}"
                do
                  STR=$STR$i".*"
                done
                templateURL=`cat /netsim/simdepContents/nodeTemplate.content | grep "/$STR" | xargs`
                echo $templateURL
fi

if [[ $templateURL =~ "zip" ]]
then
	NE=$templateURL
else
	patchContent=`echo ${patches[0]} | awk -F ".zip" '{print $1}'`
	curl $patchContent > patch.txt
	NE=`cat patch.txt | grep instances | awk -v FS="(instances| instances)" '{print $2}' | awk -F "netype " '{print $2}'`
fi
if [[ -z $NE ]]
then
	nodeTemplate=$node_template
else
	nodeTemlate=$NE
fi

######################################################################################

echo "########################################"
echo "Simulation name : $SIMNAME"
echo "Node template Link or NE name : $nodeTemplate"
echo "Node Name : $NodeName"
echo "BaseName for simulation : $BaseName"
echo "Number of Nodes : $NumOfNodes"
echo "Node Type : $NODETYPE"
echo "########################################"

su netsim -c "sh startBuild.sh $SIMNAME \"$nodeTemplate\" $BaseName $NumOfNodes $NODETYPE"

rm -rf esc_details.json
rm -rf ${NETWORKSIZE}.txt
rm -rf final.txt
