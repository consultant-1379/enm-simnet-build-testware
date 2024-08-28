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
echo    '<interfaces xmlns="urn:ietf:params:xml:ns:yang:ietf-interfaces">'
for i in {1..250}
do
echo     '<interface>
            <enabled>true</enabled>
            <type>tgpppcup:tgppCore</type>
            <name>if-internet-core-'$i'</name>
            <l2-mtu>0</l2-mtu>
            <ipv4 xmlns="urn:ietf:params:xml:ns:yang:ietf-ip">
                <enabled>true</enabled>
                <address>
                    <prefix-length>32</prefix-length>
                    <ip>110.1.20.4</ip>
                </address>
            </ipv4>
            <address-type xmlns="urn:rdns:com:ericsson:oammodel:ericsson-ip-ext-pc5gc">
                <ip-range>1</ip-range>
            </address-type>
        </interface>'
done
echo '</interfaces>'
echo ' <network-instances xmlns="urn:ietf:params:xml:ns:yang:ietf-network-instance">'
for i in {1..1200}
do
echo  '<network-instance>
            <enabled>true</enabled>
            <name>media-'$i'</name>
            <routing xmlns="urn:rdns:com:ericsson:oammodel:ericsson-routing-pc5gc">
                <bfd xmlns="urn:rdns:com:ericsson:oammodel:ericsson-bfd-pc5gc">
                    <ip-sh xmlns="urn:rdns:com:ericsson:oammodel:ericsson-bfd-ip-sh-pc5gc">
                        <sessions>
                            <required-min-echo-tx-interval>10000</required-min-echo-tx-interval>
                            <echo-detection-multiplier>3</echo-detection-multiplier>
                        </sessions>
                    </ip-sh>
                </bfd>
            </routing>
        </network-instance>'
done
echo    '</network-instances>'
echo '<epg xmlns="urn:rdns:com:ericsson:oammodel:ericsson-epg">
        <pgw>
            <gngp-default-rat-type>keep-value</gngp-default-rat-type>'
for i in {1..3000}
do
echo          ' <apn>
                <routing-instance>sgi1</routing-instance>
                <network-instance>sgi1</network-instance>
                <name>apn'$i'.com</name>
                <value>used</value>
                <p-cscf>
                    <number-of-p-cscf>0</number-of-p-cscf>
                    <category>
                        <imsi>4</imsi>
                        <name>4</name>
                    </category>
                    <category>
                        <imsi>3</imsi>
                        <name>3</name>
                    </category>
                    <category>
                        <imsi>2</imsi>
                        <name>2</name>
                    </category>
                    <category>
                        <imsi>1</imsi>
                        <name>1</name>
                    </category>
                </p-cscf>
                <pdp-context>
                    <limit>150000</limit>
                    <address-allocation>static</address-allocation>
                    <pdp-type>ipv4</pdp-type>
                    <creation>unblocked</creation>
                    <host-route-limit>100000</host-route-limit>
                    <address>
                        <name>106.0.0.0/24</name>
                        <port>53</port>
                    </address>
                </pdp-context>
                <user-profile-selection>
                    <policy-charging-rule-scope>
                        <default>pc_ruleScope1</default>
                    </policy-charging-rule-scope>
                    <local-policy-control-profile>
                        <default>lpc_profile1</default>
                    </local-policy-control-profile>
                </user-profile-selection>
            </apn>'
done

for j in {1..600}
do
echo  '<shared-ip-pool>
                <address-reuse-time>0</address-reuse-time>
                <name>'$j'</name>'
for k in {1..99}
do
 echo               '<address>
                    <name>1.1.1.'$k'</name>
                    <priority>0</priority>
                    <port>53</port>
                </address>   '                         
done
echo '</shared-ip-pool>'
done
echo "
        </pgw>
    </epg>"



