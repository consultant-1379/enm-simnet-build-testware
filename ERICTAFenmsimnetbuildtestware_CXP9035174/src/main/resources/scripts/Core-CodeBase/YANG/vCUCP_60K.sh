#!/bin/bash
### VERSION HISTORY
#####################################################################################
##     Version1     : 21.13
##
##     Revision     : CXP 903 5174-1-42 
##
##     Author       : zkusanu
##
##     JIRA         : NSS- 36130
##
##     Description  : Shell scripts for population bulk mos for yang nodes
##
##     Date         : 27th July 2021
##
######################################################################################
echo    '<ManagedElement xmlns="urn:3gpp:sa5:_3gpp-common-managed-element">
        <id>1</id>
        <attributes>
        </attributes>
        <GNBCUCPFunction xmlns="urn:3gpp:sa5:_3gpp-nr-nrm-gnbcucpfunction">
            <id>1</id>
            <attributes>
              <pLMNId>
              <mcc>311</mcc>
              <mnc>281</mnc>
              </pLMNId>                
            </attributes>'

echo            '<TermPointToGNBDU xmlns="urn:rdns:com:ericsson:oammodel:ericsson-termpointtognbdu-vcucp">
               <id>1</id>
                <attributes/>
            </TermPointToGNBDU>'
 echo           '<NRNetwork xmlns="urn:rdns:com:ericsson:oammodel:ericsson-nrnetwork-vcucp">
                 <id>1</id>'
for i in {1..64}
do
  echo              '<NRFrequency xmlns="urn:rdns:com:ericsson:oammodel:ericsson-nrfrequency-vcucp">
  		    <id>'$i'</id>
                    <attributes>
                        <smtcScs>0</smtcScs>
                        <arfcnValueNRDl>0</arfcnValueNRDl>
                    </attributes>
                </NRFrequency>'
done
echo  '</NRNetwork>'
echo           ' <EndpointResource xmlns="urn:rdns:com:ericsson:oammodel:ericsson-endpoint-resource-vcucp">
                  <id>1</id>
                <LocalSctpEndpoint xmlns="urn:rdns:com:ericsson:oammodel:ericsson-local-sctp-endpoint-vcucp">
                       <id>1</id>
                    <attributes/>
                </LocalSctpEndpoint>
                <LocalIpEndpoint xmlns="urn:rdns:com:ericsson:oammodel:ericsson-local-ip-endpoint-vcucp">
                         <id>1</id>
                    <attributes/>
                </LocalIpEndpoint>
                <attributes/>
            </EndpointResource>'
for i in {1..4}
do 
echo         '<NRCellCU xmlns="urn:3gpp:sa5:_3gpp-nr-nrm-nrcellcu">
                <id>'$i'</id>
                <attributes>'
for i in {1..1024}
do
echo '                    <sNSSAIList xmlns="urn:rdns:com:ericsson:oammodel:ericsson-nrcellcu-ext-vcucp">
                     <sd>'$i'</sd>
                     <sst>'$i'</sst>          
                    </sNSSAIList>'
done
echo                     '<primaryPLMNId xmlns="urn:rdns:com:ericsson:oammodel:ericsson-nrcellcu-ext-vcucp">
                          <mcc>311</mcc>
                    <mnc>281</mnc>
                     </primaryPLMNId>
                    <pLMNInfoList> 
                    <mcc>311</mcc>
                    <mnc>281</mnc>
                    </pLMNInfoList>                                        
                    <absFrameStartOffset xmlns="urn:rdns:com:ericsson:oammodel:ericsson-nrcellcu-ext-vcucp">
                     <absSubFrameOffset>1</absSubFrameOffset>
                     <absTimeOffset>1</absTimeOffset>
                     </absFrameStartOffset>
                </attributes>'
for j in {1..16}
do
echo                '<EUtranFreqRelation xmlns="urn:3gpp:sa5:_3gpp-nr-nrm-eutranfreqrelation">
                      <id>'$j'</id>
                    <attributes>
                      <id>'$j'</id>'
for i in {1..15}
do
           echo '    <allowedPlmnList xmlns="urn:rdns:com:ericsson:oammodel:ericsson-eutranfreqrelation-ext-vcucp">
                    <mcc>'$i'</mcc>
                    <mnc>'$i'</mnc>       
                    </allowedPlmnList>'
done
    echo '                </attributes>
                </EUtranFreqRelation>'
done    
for k in {1..128}
do

echo          '<EUtranCellRelation xmlns="urn:3gpp:sa5:_3gpp-nr-nrm-eutrancellrelation">
                     <id>'$k'</id>
                    <attributes>'
for j in {1..14}
do
 echo       '              <essCellScPairs xmlns="urn:rdns:com:ericsson:oammodel:ericsson-eutrancellrelation-ext-vcucp">
                         <eNBessLocalScId>'$j'</eNBessLocalScId>
                          <essScPairId>'$j'</essScPairId>
                          <gNBessLocalScId>'$j'</gNBessLocalScId>
                          </essCellScPairs>  '                       
done
echo               ' </attributes>
                </EUtranCellRelation>'
done                
    echo    '</NRCellCU>'
done
echo '                                    
            <EUtraNetwork xmlns="urn:rdns:com:ericsson:oammodel:ericsson-eutranetwork-vcucp">
                <id>1</id>
		<attributes/>'
for i in {1..32}
do
echo              '<EUtranFrequency xmlns="urn:rdns:com:ericsson:oammodel:ericsson-eutranfrequency-vcucp">
                   <id>'$i'</id>
                          <attributes>
                        <arfcnValueEUtranDl>0</arfcnValueEUtranDl>
                    </attributes>
                </EUtranFrequency>'
done
 for i in {1..135}
do              
  echo       '<ExternalENBFunction xmlns="urn:rdns:com:ericsson:oammodel:ericsson-externalenbfunction-vcucp">
                    <id>'$i'</id>
                    <attributes>
                        <eNBId>0</eNBId>
                        <pLMNId>
                        <mcc>311</mcc>
                        <mnc>281</mnc>
                        </pLMNId>
                    </attributes>'
for j in {1..24}
do   
echo '
                    <ExternalEUtranCellTDD xmlns="urn:rdns:com:ericsson:oammodel:ericsson-externaleutrancell-vcucp">
                <id>'$j'</id>
                        <attributes>
                         <pLMNIdList>
                         <mcc>311</mcc>
                         <mnc>1</mnc>
                         </pLMNIdList>
                          <pLMNIdList>
                         <mcc>311</mcc>
                         <mnc>2</mnc>
                         </pLMNIdList>
                           <pLMNIdList>
                         <mcc>311</mcc>
                         <mnc>3</mnc>
                         </pLMNIdList>
                          <pLMNIdList>
                         <mcc>311</mcc>
                         <mnc>4</mnc>
                         </pLMNIdList>
                          <pLMNIdList>
                         <mcc>311</mcc>
                         <mnc>5</mnc>
                         </pLMNIdList>
                        </attributes>
                    </ExternalEUtranCellTDD>                   
                    <ExternalEUtranCellFDD xmlns="urn:rdns:com:ericsson:oammodel:ericsson-externaleutrancell-vcucp">
		      <id>'$j'</id>
                        <attributes>
 <pLMNIdList>
                         <mcc>311</mcc>
                         <mnc>1</mnc>
                         </pLMNIdList>
                          <pLMNIdList>
                         <mcc>311</mcc>
                         <mnc>2</mnc>
                         </pLMNIdList>
                           <pLMNIdList>
                         <mcc>311</mcc>
                         <mnc>3</mnc>
                         </pLMNIdList>
                          <pLMNIdList>
                         <mcc>311</mcc>
                         <mnc>4</mnc>
                         </pLMNIdList>
                          <pLMNIdList>
                         <mcc>311</mcc>
                         <mnc>5</mnc>
                         </pLMNIdList>                       
                        </attributes>
                    </ExternalEUtranCellFDD>   '                 
                
done
echo  '<TermPointToENB xmlns="urn:rdns:com:ericsson:oammodel:ericsson-termpointtoenb-vcucp">
                        <attributes/>
                 <id>1</id>
                    </TermPointToENB>
</ExternalENBFunction>'
done      
echo            '</EUtraNetwork>
  </GNBCUCPFunction>
    </ManagedElement>'
