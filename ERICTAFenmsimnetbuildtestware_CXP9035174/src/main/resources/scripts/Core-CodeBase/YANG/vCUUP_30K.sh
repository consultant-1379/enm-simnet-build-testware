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
        <CUUPTemplate xmlns="urn:rdns:com:ericsson:oammodel:ericsson-cuuptemplate-vcuup-add">
        <id>1</id>
            <UserPlaneProfiles>
                <id>1</id>
                <UserPlaneProfile>
                      <id>1</id>
                    <attributes>
                        <endcDataUsageReportEnabled>true</endcDataUsageReportEnabled>
                    </attributes>
                </UserPlaneProfile>
                <attributes>
                    <endcDataUsageReportEnabled>true</endcDataUsageReportEnabled>
                </attributes>
            </UserPlaneProfiles>
            <ServiceSelectionPolicy>
                       <id>1</id>
                <attributes>
                    <endcDataUsageReportEnabled>true</endcDataUsageReportEnabled>'
for i in {1..200}
do
  echo    '   <selectionPrioTa>
                     <firstTrackingAreaCode>'$i'</firstTrackingAreaCode>
                </selectionPrioTa>
                     <selectionPrioRn>
                     <radioNodeId>'$i'</radioNodeId>
                    </selectionPrioRn>'
done
    echo           ' </attributes>
            </ServiceSelectionPolicy>
            <EndpointResource>
             <id>1</id>
                <LocalIpEndpoint>
                            <id>1</id>
                    <attributes>
                        <endcDataUsageReportEnabled>true</endcDataUsageReportEnabled>
                    </attributes>
                </LocalIpEndpoint>
            </EndpointResource>
            <attributes>
                <endcDataUsageReportEnabled>true</endcDataUsageReportEnabled>
                <pLMNIdList>              
                    <mcc>311</mcc>
                    <mnc>281</mnc>                                  
                    </pLMNIdList>
            </attributes>
        </CUUPTemplate>
        <ServiceInstance xmlns="urn:rdns:com:ericsson:oammodel:ericsson-service-instance-vcuup-add">
              <id>1</id>'
for i in {1..256}
do
  echo   '<Interface>
                 <id>'$i'</id>
                <IpAddressV6>
                     <id>'$i'</id>
                    <attributes/>
                </IpAddressV6>
                <IpAddressV4>
                     <id>'$i'</id>
                    <attributes/>
                </IpAddressV4>
                <attributes/>
            </Interface>'
done
 echo           '<EndpointResource>
                       <id>1</id>
                <LocalIpEndpoint>
                       <id>1</id>
                    <attributes/>
                </LocalIpEndpoint>
            </EndpointResource>
            <attributes/>
    </ServiceInstance>'
for i in {1..150}
do
  echo   '<GNBCUUPFunction xmlns="urn:3gpp:sa5:_3gpp-nr-nrm-gnbcuupfunction">
             <id>'$i'</id>'
for i in {1..11}
do
  echo   '<X2ULink xmlns="urn:rdns:com:ericsson:oammodel:ericsson-gnbcuupfunction-vcuup-add">
               <id>'$i'</id>
                <attributes/>
            </X2ULink>'
done
for i in {1..64}
do
  echo          '<S1ULink xmlns="urn:rdns:com:ericsson:oammodel:ericsson-gnbcuupfunction-vcuup-add">
               <id>'$i'</id>
                <attributes/>
            </S1ULink>'
done
echo             '<F1ULink xmlns="urn:rdns:com:ericsson:oammodel:ericsson-gnbcuupfunction-vcuup-add">
               <id>1</id>
                <attributes/>
            </F1ULink>'
for i in {1..11}
do
  echo          '<E1Link xmlns="urn:rdns:com:ericsson:oammodel:ericsson-gnbcuupfunction-vcuup-add">
               <id>'$i'</id>
                <attributes/>
            </E1Link>'
done
 echo          ' <attributes>
                <gNBIdLength>0</gNBIdLength>
                <gNBId>0</gNBId>
                <gNBCUUPId>0</gNBCUUPId>'

echo                '<pLMNIdList>
                    <mcc>311</mcc>
                    <mnc>001</mnc>                                  
                    </pLMNIdList>
                    <pLMNIdList>
                    <mcc>311</mcc>
                    <mnc>002</mnc>                                  
                    </pLMNIdList>
                    <pLMNIdList>
                    <mcc>311</mcc>
                    <mnc>003</mnc>                                  
                    </pLMNIdList>
                    <pLMNIdList>
                    <mcc>311</mcc>
                    <mnc>004</mnc>                                  
                    </pLMNIdList>
                    <pLMNIdList>
                    <mcc>311</mcc>
                    <mnc>005</mnc>                                  
                    </pLMNIdList>
                    <pLMNIdList>
                    <mcc>311</mcc>
                    <mnc>006</mnc>                                  
                    </pLMNIdList>
                    <pLMNIdList>
                    <mcc>311</mcc>
                    <mnc>007</mnc>                                  
                    </pLMNIdList>
                    <pLMNIdList>
                    <mcc>311</mcc>
                    <mnc>008</mnc>                                  
                    </pLMNIdList>
                    <pLMNIdList>
                    <mcc>311</mcc>
                    <mnc>009</mnc>                                  
                    </pLMNIdList>
                    <pLMNIdList>
                    <mcc>311</mcc>
                    <mnc>010</mnc>                                  
                    </pLMNIdList>
                    <pLMNIdList>
                    <mcc>311</mcc>
                    <mnc>011</mnc>                                  
                    </pLMNIdList>
                    <pLMNIdList>
                    <mcc>311</mcc>
                    <mnc>012</mnc>                                  
                    </pLMNIdList>'
echo            '</attributes>
        </GNBCUUPFunction>'
done
echo '<attributes>
            <priorityLabel>0</priorityLabel>           
            <vendorName>Ericsson</vendorName>
        </attributes>   
      </ManagedElement>'
