#!/bin/bash
########################################################################
# Version     : 1.1
# Revision    : CXP 903 5174-1-20
# Purpose     : Updates ciphers
# Jira        : NSS-33178
# Date        : Nov 2020
# Who         : zhainic
########################################################################
########################################################################
#Script Usage#
########################################################################
usage (){

echo "Usage  : $0 <sim name> "

echo "Example: $0 CORE-ST-DSC-1.14-V1x5  "

}
neType(){

echo "ERROR: The script runs only for DSC nodes"
}
########################################################################
#To check commandline arguments#
########################################################################
if [ $# -ne 1 ]
then
usage
exit 1
fi
########################################################################
#Variables
########################################################################
simName=$1
Path=`pwd`
########################################################################
#To check the if simname is CSCF#
########################################################################
if [[ $simName != *"CCN"* ]]
then
neType
exit 1
fi

echo "$0 started running at" $(date +%T)
#######################################################################
#Extracting nodenames#
#######################################################################

$Path/../bin/extractNeNames.pl $simName
neNames=( $( cat $Path/dumpNeName.txt ) )

########################################################################
#Making MO script#
########################################################################

for nodeName in ${neNames[@]}
do
cat >> ${nodeName}_Tls.mo << ANC
SET
(
    mo "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,Tls=1"
    // moid = 307
    exception none
    nrOfAttributes 2
    "supportedCiphers" Array Struct 49
        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH"
        "authentication" String "aRSA"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "ECDHE-RSA-AES256-GCM-SHA384"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH"
        "authentication" String "aECDSA"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "ECDHE-ECDSA-AES256-GCM-SHA384"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA384"
        "export" String ""
        "name" String "ECDHE-RSA-AES256-SHA384"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH"
        "authentication" String "aECDSA"
        "encryption" String "AES"
        "mac" String "SHA384"
        "export" String ""
        "name" String "ECDHE-ECDSA-AES256-SHA384"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDHE-RSA-AES256-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH"
        "authentication" String "aECDSA"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDHE-ECDSA-AES256-SHA"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kDH"
        "authentication" String "aDSS"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "DHE-DSS-AES256-GCM-SHA384"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kDH"
        "authentication" String "aRSA"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "DHE-RSA-AES256-GCM-SHA384"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kDH"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "DHE-RSA-AES256-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kDH"
        "authentication" String "aDSS"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "DHE-DSS-AES256-SHA256"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kDH"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "DHE-RSA-AES256-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kDH"
        "authentication" String "aDSS"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "DHE-DSS-AES256-SHA"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH/RSA"
        "authentication" String "aECDH"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "ECDH-RSA-AES256-GCM-SHA384"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH/ECDSA"
        "authentication" String "aECDH"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "ECDH-ECDSA-AES256-GCM-SHA384"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH/RSA"
        "authentication" String "aECDH"
        "encryption" String "AES"
        "mac" String "SHA384"
        "export" String ""
        "name" String "ECDH-RSA-AES256-SHA384"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH/ECDSA"
        "authentication" String "aECDH"
        "encryption" String "AES"
        "mac" String "SHA384"
        "export" String ""
        "name" String "ECDH-ECDSA-AES256-SHA384"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH/RSA"
        "authentication" String "aECDH"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDH-RSA-AES256-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH/ECDSA"
        "authentication" String "aECDH"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDH-ECDSA-AES256-SHA"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kRSA"
        "authentication" String "aRSA"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "AES256-GCM-SHA384"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kRSA"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "AES256-SHA256"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kRSA"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "AES256-SHA"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH"
        "authentication" String "aRSA"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "ECDHE-RSA-AES128-GCM-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH"
        "authentication" String "aECDSA"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "ECDHE-ECDSA-AES128-GCM-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "ECDHE-RSA-AES128-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH"
        "authentication" String "aECDSA"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "ECDHE-ECDSA-AES128-SHA256"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDHE-RSA-AES128-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH"
        "authentication" String "aECDSA"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDHE-ECDSA-AES128-SHA"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kDH"
        "authentication" String "aDSS"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "DHE-DSS-AES128-GCM-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kDH"
        "authentication" String "aRSA"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "DHE-RSA-AES128-GCM-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kDH"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "DHE-RSA-AES128-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kDH"
        "authentication" String "aDSS"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "DHE-DSS-AES128-SHA256"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kDH"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "DHE-RSA-AES128-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kDH"
        "authentication" String "aDSS"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "DHE-DSS-AES128-SHA"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH/RSA"
        "authentication" String "aECDH"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "ECDH-RSA-AES128-GCM-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH/ECDSA"
        "authentication" String "aECDH"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "ECDH-ECDSA-AES128-GCM-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH/RSA"
        "authentication" String "aECDH"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "ECDH-RSA-AES128-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH/ECDSA"
        "authentication" String "aECDH"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "ECDH-ECDSA-AES128-SHA256"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH/RSA"
        "authentication" String "aECDH"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDH-RSA-AES128-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH/ECDSA"
        "authentication" String "aECDH"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDH-ECDSA-AES128-SHA"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kRSA"
        "authentication" String "aRSA"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "AES128-GCM-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kRSA"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "AES128-SHA256"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kRSA"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "AES128-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH"
        "authentication" String "aRSA"
        "encryption" String "3DES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDHE-RSA-DES-CBC3-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH"
        "authentication" String "aECDSA"
        "encryption" String "3DES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDHE-ECDSA-DES-CBC3-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kDH"
        "authentication" String "aRSA"
        "encryption" String "3DES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "EDH-RSA-DES-CBC3-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kDH"
        "authentication" String "aDSS"
        "encryption" String "3DES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "EDH-DSS-DES-CBC3-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH/RSA"
        "authentication" String "aECDH"
        "encryption" String "3DES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDH-RSA-DES-CBC3-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH/ECDSA"
        "authentication" String "aECDH"
        "encryption" String "3DES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDH-ECDSA-DES-CBC3-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kRSA"
        "authentication" String "aRSA"
        "encryption" String "3DES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "DES-CBC3-SHA"

    "enabledCiphers" Array Struct 49
        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH"
        "authentication" String "aRSA"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "ECDHE-RSA-AES256-GCM-SHA384"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH"
        "authentication" String "aECDSA"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "ECDHE-ECDSA-AES256-GCM-SHA384"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA384"
        "export" String ""
        "name" String "ECDHE-RSA-AES256-SHA384"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH"
        "authentication" String "aECDSA"
        "encryption" String "AES"
        "mac" String "SHA384"
        "export" String ""
        "name" String "ECDHE-ECDSA-AES256-SHA384"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDHE-RSA-AES256-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH"
        "authentication" String "aECDSA"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDHE-ECDSA-AES256-SHA"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kDH"
        "authentication" String "aDSS"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "DHE-DSS-AES256-GCM-SHA384"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kDH"
        "authentication" String "aRSA"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "DHE-RSA-AES256-GCM-SHA384"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kDH"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "DHE-RSA-AES256-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kDH"
        "authentication" String "aDSS"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "DHE-DSS-AES256-SHA256"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kDH"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "DHE-RSA-AES256-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kDH"
        "authentication" String "aDSS"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "DHE-DSS-AES256-SHA"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH/RSA"
        "authentication" String "aECDH"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "ECDH-RSA-AES256-GCM-SHA384"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH/ECDSA"
        "authentication" String "aECDH"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "ECDH-ECDSA-AES256-GCM-SHA384"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH/RSA"
        "authentication" String "aECDH"
        "encryption" String "AES"
        "mac" String "SHA384"
        "export" String ""
        "name" String "ECDH-RSA-AES256-SHA384"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH/ECDSA"
        "authentication" String "aECDH"
        "encryption" String "AES"
        "mac" String "SHA384"
        "export" String ""
        "name" String "ECDH-ECDSA-AES256-SHA384"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH/RSA"
        "authentication" String "aECDH"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDH-RSA-AES256-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH/ECDSA"
        "authentication" String "aECDH"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDH-ECDSA-AES256-SHA"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kRSA"
        "authentication" String "aRSA"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "AES256-GCM-SHA384"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kRSA"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "AES256-SHA256"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kRSA"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "AES256-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH"
        "authentication" String "aRSA"
        "encryption" String "3DES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDHE-RSA-DES-CBC3-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH"
        "authentication" String "aECDSA"
        "encryption" String "3DES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDHE-ECDSA-DES-CBC3-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kDH"
        "authentication" String "aRSA"
        "encryption" String "3DES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "EDH-RSA-DES-CBC3-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kDH"
        "authentication" String "aDSS"
        "encryption" String "3DES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "EDH-DSS-DES-CBC3-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH/RSA"
        "authentication" String "aECDH"
        "encryption" String "3DES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDH-RSA-DES-CBC3-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH/ECDSA"
        "authentication" String "aECDH"
        "encryption" String "3DES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDH-ECDSA-DES-CBC3-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kRSA"
        "authentication" String "aRSA"
        "encryption" String "3DES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "DES-CBC3-SHA"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH"
        "authentication" String "aRSA"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "ECDHE-RSA-AES128-GCM-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH"
        "authentication" String "aECDSA"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "ECDHE-ECDSA-AES128-GCM-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "ECDHE-RSA-AES128-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH"
        "authentication" String "aECDSA"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "ECDHE-ECDSA-AES128-SHA256"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDHE-RSA-AES128-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH"
        "authentication" String "aECDSA"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDHE-ECDSA-AES128-SHA"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kDH"
        "authentication" String "aDSS"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "DHE-DSS-AES128-GCM-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kDH"
        "authentication" String "aRSA"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "DHE-RSA-AES128-GCM-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kDH"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "DHE-RSA-AES128-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kDH"
        "authentication" String "aDSS"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "DHE-DSS-AES128-SHA256"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kDH"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "DHE-RSA-AES128-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kDH"
        "authentication" String "aDSS"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "DHE-DSS-AES128-SHA"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH/RSA"
        "authentication" String "aECDH"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "ECDH-RSA-AES128-GCM-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH/ECDSA"
        "authentication" String "aECDH"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "ECDH-ECDSA-AES128-GCM-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH/RSA"
        "authentication" String "aECDH"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "ECDH-RSA-AES128-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kECDH/ECDSA"
        "authentication" String "aECDH"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "ECDH-ECDSA-AES128-SHA256"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH/RSA"
        "authentication" String "aECDH"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDH-RSA-AES128-SHA"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kECDH/ECDSA"
        "authentication" String "aECDH"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "ECDH-ECDSA-AES128-SHA"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kRSA"
        "authentication" String "aRSA"
        "encryption" String "AESGCM"
        "mac" String "AEAD"
        "export" String ""
        "name" String "AES128-GCM-SHA256"

        nrOfElements 7
        "protocolVersion" String "TLSv1.2"
        "keyExchange" String "kRSA"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA256"
        "export" String ""
        "name" String "AES128-SHA256"

        nrOfElements 7
        "protocolVersion" String "SSLv3"
        "keyExchange" String "kRSA"
        "authentication" String "aRSA"
        "encryption" String "AES"
        "mac" String "SHA1"
        "export" String ""
        "name" String "AES128-SHA"

)
ANC

cat >> ${nodeName}_Ssh.mo << ABC
SET
(
    mo "ManagedElement=$nodeName,SystemFunctions=1,SecM=1,Ssh=1"
    // moid = 308
    exception none
    nrOfAttributes 6
    "supportedKeyExchanges" Array String 10
        ecdh-sha2-nistp384
        ecdh-sha2-nistp521
        ecdh-sha2-nistp256
        diffie-hellman-group-exchange-sha256
        diffie-hellman-group16-sha512
        diffie-hellman-group18-sha512
        diffie-hellman-group14-sha256
        diffie-hellman-group14-sha1
        diffie-hellman-group-exchange-sha1
        diffie-hellman-group1-sha1
    "supportedCiphers" Array String 9
        aes256-gcm@openssh.com
        aes256-ctr
        aes192-ctr
        aes128-gcm@openssh.com
        aes128-ctr
        AEAD_AES_256_GCM
        AEAD_AES_128_GCM
        aes128-cbc
        3des-cbc
    "supportedMacs" Array String 5
        hmac-sha2-256
        hmac-sha2-512
        hmac-sha1
        AEAD_AES_128_GCM
        AEAD_AES_256_GCM
    "selectedKeyExchanges" Array String 10
        ecdh-sha2-nistp384
        ecdh-sha2-nistp521
        ecdh-sha2-nistp256
        diffie-hellman-group-exchange-sha256
        diffie-hellman-group16-sha512
        diffie-hellman-group18-sha512
        diffie-hellman-group14-sha256
        diffie-hellman-group14-sha1
        diffie-hellman-group-exchange-sha1
        diffie-hellman-group1-sha1
    "selectedCiphers" Array String 9
        aes256-gcm@openssh.com
        aes256-ctr
        aes192-ctr
        aes128-gcm@openssh.com
        aes128-ctr
        AEAD_AES_256_GCM
        AEAD_AES_128_GCM
        aes128-cbc
        3des-cbc
    "selectedMacs" Array String 5
        hmac-sha2-256
        hmac-sha2-512
        hmac-sha1
        AEAD_AES_128_GCM
        AEAD_AES_256_GCM
)
ABC

cat >> $simName_ciphers.mml << XYZ
.open $simName
.select $nodeName
.start
useattributecharacteristics:switch="off";
kertayle:file="$Path/${nodeName}_Tls.mo";
kertayle:file="$Path/${nodeName}_Ssh.mo";
XYZ
done
 
/netsim/inst/netsim_shell < $simName_ciphers.mml
rm -rf $simName_ciphers.mml
rm -rf $Path/*_Tls.mo $Path/*_Ssh.mo
