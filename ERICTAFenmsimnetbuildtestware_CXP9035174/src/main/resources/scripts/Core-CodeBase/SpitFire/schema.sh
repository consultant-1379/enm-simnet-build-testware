#!/bin/bash
simName=$1
Path=`pwd`
$Path/../bin/extractNeNames.pl $simName
neNames=( $( cat $Path/dumpNeName.txt ) )

Schema=$(echo -e ".open $simName \n .select $neNames \n .start \n e [PMNS, _ ,_] =string:tokens(lists:last(ecim_netconflib:string_to_ldn(\"ManagedElement=1,SystemFunctions=1,SysM=1\")),\"=:\"). \n e length(csmo:get_mo_ids_by_type(null, PMNS++\":Schema\")).  " | /netsim/inst/netsim_shell)
numOfSchema=$(echo ${Schema##* } | tr -d ' ')

echo "schemas are $numOfSchema"

for ((i=1;i<=numOfSchema;i++));
do
schema=$(echo -e ".open $simName \n .select $neNames \n e csmo:get_attribute_value(null, csmo:ldn_to_mo_id(null,string:tokens(cs_ker_parse:get_ldn_with_namespace(\"ManagedElement=\"++csmo:get_attribute_value(null,1,managedElementId)++\",SystemFunctions=1,SysM=1,Schema=$i\"),\",\")) ,identifier). " | /netsim/inst/netsim_shell)
schemaValue=$(echo ${schema[@]##* } | tr -d ' ' | cut -d'"' -f2)


cat >> applySchema.mo << DEF

SET
 (
     mo "ManagedElement=1,SystemFunctions=1,SysM=1,Schema=$i"
     exception none
     nrOfAttributes 1
     "schemaId" String "$schemaValue"
 
 )
DEF
done
cat >> abc.mml << ABC
.open $simName
.select network
.start
setmoattribute:mo="1",attributes="managedElementId(string)=1";
kertayle:file="$PWD/applySchema.mo";
ABC

/netsim/inst/netsim_pipe < abc.mml

rm -rf abc.mml applySchema.mo *.txt
