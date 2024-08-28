#!/bin/bash
########################################################################
# Version     : 16.16
# Revision    : CXP 903 5174-1-1
# Purpose     : Loads features for MGw nodes
# Description : Creates MOs and sets attributes
# Date        : Oct 2016
# Who         : xgouhar
########################################################################
########################################################################
#Script Usage#
########################################################################
usage (){

echo "Usage  : $0 <sim name> "

echo "Example: $0 CORE-3K-ST-MGw-C1203-16Ax20 "

}
neType(){

echo "ERROR: The script runs only for epg and vepg nodes"
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
mimData=`echo $simName|awk -F'-' '{print $5}' | awk -F 'C' '{print $2}'`
mimVersion="$(echo $mimData | head -c 1)"
mimRelease="$(echo $mimData | cut -c 2-)"
########################################################################
#To check the if simname MGw
########################################################################
if [[ $simName != *"MGw"* ]]
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
#Reading product data from file AssignProductData
########################################################################
productData=$($Path/../bin/AssignProductData.sh $simName)
productNumber=`echo $productData | cut -d ":" -f1`
productRevision=`echo $productData | cut -d ":" -f2`
########################################################################
#Making MO script#
########################################################################
for nodeName in ${neNames[@]}
do
cat >> ${nodeName}_ssh.mo << DEF
SET
(
    mo "ManagedElement=1,SystemFunctions=1,Security=1,Ssh=1"
    exception none
    nrOfAttributes 6
    "supportedKeyExchange" Array String 10
        "ecdh-sha2-nistp384"
        "ecdh-sha2-nistp521"
        "ecdh-sha2-nistp256"
        "diffie-hellman-group-exchange-sha256"
        "diffie-hellman-group16-sha512"
        "diffie-hellman-group18-sha512"
        "diffie-hellman-group14-sha256"
        "diffie-hellman-group14-sha1"
        "diffie-hellman-group-exchange-sha1"
        "diffie-hellman-group1-sha1"
    "supportedCipher" Array String 9
        "aes256-gcm@openssh.com"
        "aes256-ctr"
        "aes192-ctr"
        "aes128-gcm@openssh.com"
        "aes128-ctr"
        "AEAD_AES_256_GCM"
        "AEAD_AES_128_GCM"
        "aes128-cbc"
        "3des-cbc"
    "supportedMac" Array String 5
        "hmac-sha2-256"
        "hmac-sha2-512"
        "hmac-sha1"
        "AEAD_AES_128_GCM"
        "AEAD_AES_256_GCM"
    "selectedKeyExchange" Array String 10
        "ecdh-sha2-nistp384"
        "ecdh-sha2-nistp521"
        "ecdh-sha2-nistp256"
        "diffie-hellman-group-exchange-sha256"
        "diffie-hellman-group16-sha512"
        "diffie-hellman-group18-sha512"
        "diffie-hellman-group14-sha256"
        "diffie-hellman-group14-sha1"
        "diffie-hellman-group-exchange-sha1"
        "diffie-hellman-group1-sha1"
    "selectedCipher" Array String 9
         "aes256-gcm@openssh.com"
         "aes256-ctr"
         "aes192-ctr"
         "aes128-gcm@openssh.com"
         "aes128-ctr"
         "AEAD_AES_256_GCM"
         "AEAD_AES_128_GCM"
         "aes128-cbc"
         "3des-cbc"
    "selectedMac" Array String 5
         "hmac-sha2-256"
         "hmac-sha2-512"
         "hmac-sha1"
         "AEAD_AES_128_GCM"
         "AEAD_AES_256_GCM"
)
DEF
cat >> ${nodeName}_tls.mo << DEF
SET
(
    mo "ManagedElement=1,SystemFunctions=1,Security=1,Tls=1"
    exception none
    nrOfAttributes 3
    "supportedCipher" Array Struct 49
        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "AESGCM"
        "export" String ""
        "keyExchange" String "kECDH"
        "mac" String "AEAD"
        "name" String "ECDHE-RSA-AES256-GCM-SHA384"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aECDSA"
        "encryption" String "AESGCM"
        "export" String ""
        "keyExchange" String "kECDH"
        "mac" String "AEAD"
        "name" String "ECDHE-ECDSA-AES256-GCM-SHA384"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kECDH"
        "mac" String "SHA384"
        "name" String "ECDHE-RSA-AES256-SHA384"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aECDSA"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kECDH"
        "mac" String "SHA384"
        "name" String "ECDHE-ECDSA-AES256-SHA384"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kECDH"
        "mac" String "SHA1"
        "name" String "ECDHE-RSA-AES256-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aECDSA"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kECDH"
        "mac" String "SHA1"
        "name" String "ECDHE-ECDSA-AES256-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aDSS"
        "encryption" String "AESGCM"
        "export" String ""
        "keyExchange" String "kDH"
        "mac" String "AEAD"
        "name" String "DHE-DSS-AES256-GCM-SHA384"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "AESGCM"
        "export" String ""
        "keyExchange" String "kDH"
        "mac" String "AEAD"
        "name" String "DHE-RSA-AES256-GCM-SHA384"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kDH"
        "mac" String "SHA256"
        "name" String "DHE-RSA-AES256-SHA256"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aDSS"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kDH"
        "mac" String "SHA256"
        "name" String "DHE-DSS-AES256-SHA256"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kDH"
        "mac" String "SHA1"
        "name" String "DHE-RSA-AES256-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aDSS"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kDH"
        "mac" String "SHA1"
        "name" String "DHE-DSS-AES256-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aECDH"
        "encryption" String "AESGCM"
        "export" String ""
        "keyExchange" String "kECDH/RSA"
        "mac" String "AEAD"
        "name" String "ECDH-RSA-AES256-GCM-SHA384"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aECDH"
        "encryption" String "AESGCM"
        "export" String ""
        "keyExchange" String "kECDH/ECDSA"
        "mac" String "AEAD"
        "name" String "ECDH-ECDSA-AES256-GCM-SHA384"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aECDH"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kECDH/RSA"
        "mac" String "SHA384"
        "name" String "ECDH-RSA-AES256-SHA384"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aECDH"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kECDH/ECDSA"
        "mac" String "SHA384"
        "name" String "ECDH-ECDSA-AES256-SHA384"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aECDH"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kECDH/RSA"
        "mac" String "SHA1"
        "name" String "ECDH-RSA-AES256-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aECDH"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kECDH/ECDSA"
        "mac" String "SHA1"
        "name" String "ECDH-ECDSA-AES256-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "AESGCM"
        "export" String ""
        "keyExchange" String "kRSA"
        "mac" String "AEAD"
        "name" String "AES256-GCM-SHA384"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kRSA"
        "mac" String "SHA256"
        "name" String "AES256-SHA256"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kRSA"
        "mac" String "SHA1"
        "name" String "AES256-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "AESGCM"
        "export" String ""
        "keyExchange" String "kECDH"
        "mac" String "AEAD"
        "name" String "ECDHE-RSA-AES128-GCM-SHA256"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aECDSA"
        "encryption" String "AESGCM"
        "export" String ""
        "keyExchange" String "kECDH"
        "mac" String "AEAD"
        "name" String "ECDHE-ECDSA-AES128-GCM-SHA256"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kECDH"
        "mac" String "SHA256"
        "name" String "ECDHE-RSA-AES128-SHA256"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aECDSA"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kECDH"
        "mac" String "SHA256"
        "name" String "ECDHE-ECDSA-AES128-SHA256"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kECDH"
        "mac" String "SHA1"
        "name" String "ECDHE-RSA-AES128-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aECDSA"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kECDH"
        "mac" String "SHA1"
        "name" String "ECDHE-ECDSA-AES128-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aDSS"
        "encryption" String "AESGCM"
        "export" String ""
        "keyExchange" String "kDH"
        "mac" String "AEAD"
        "name" String "DHE-DSS-AES128-GCM-SHA256"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "AESGCM"
        "export" String ""
        "keyExchange" String "kDH"
        "mac" String "AEAD"
        "name" String "DHE-RSA-AES128-GCM-SHA256"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kDH"
        "mac" String "SHA256"
        "name" String "DHE-RSA-AES128-SHA256"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aDSS"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kDH"
        "mac" String "SHA256"
        "name" String "DHE-DSS-AES128-SHA256"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kDH"
        "mac" String "SHA1"
        "name" String "DHE-RSA-AES128-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aDSS"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kDH"
        "mac" String "SHA1"
        "name" String "DHE-DSS-AES128-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aECDH"
        "encryption" String "AESGCM"
        "export" String ""
        "keyExchange" String "kECDH/RSA"
        "mac" String "AEAD"
        "name" String "ECDH-RSA-AES128-GCM-SHA256"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aECDH"
        "encryption" String "AESGCM"
        "export" String ""
        "keyExchange" String "kECDH/ECDSA"
        "mac" String "AEAD"
        "name" String "ECDH-ECDSA-AES128-GCM-SHA256"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aECDH"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kECDH/RSA"
        "mac" String "SHA256"
        "name" String "ECDH-RSA-AES128-SHA256"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aECDH"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kECDH/ECDSA"
        "mac" String "SHA256"
        "name" String "ECDH-ECDSA-AES128-SHA256"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aECDH"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kECDH/RSA"
        "mac" String "SHA1"
        "name" String "ECDH-RSA-AES128-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aECDH"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kECDH/ECDSA"
        "mac" String "SHA1"
        "name" String "ECDH-ECDSA-AES128-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "AESGCM"
        "export" String ""
        "keyExchange" String "kRSA"
        "mac" String "AEAD"
        "name" String "AES128-GCM-SHA256"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kRSA"
        "mac" String "SHA256"
        "name" String "AES128-SHA256"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kRSA"
        "mac" String "SHA1"
        "name" String "AES128-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "3DES"
        "export" String ""
        "keyExchange" String "kECDH"
        "mac" String "SHA1"
        "name" String "ECDHE-RSA-DES-CBC3-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aECDSA"
        "encryption" String "3DES"
        "export" String ""
        "keyExchange" String "kECDH"
        "mac" String "SHA1"
        "name" String "ECDHE-ECDSA-DES-CBC3-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "3DES"
        "export" String ""
        "keyExchange" String "kDH"
        "mac" String "SHA1"
        "name" String "EDH-RSA-DES-CBC3-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aDSS"
        "encryption" String "3DES"
        "export" String ""
        "keyExchange" String "kDH"
        "mac" String "SHA1"
        "name" String "EDH-DSS-DES-CBC3-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aECDH"
        "encryption" String "3DES"
        "export" String ""
        "keyExchange" String "kECDH/RSA"
        "mac" String "SHA1"
        "name" String "ECDH-RSA-DES-CBC3-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aECDH"
        "encryption" String "3DES"
        "export" String ""
        "keyExchange" String "kECDH/ECDSA"
        "mac" String "SHA1"
        "name" String "ECDH-ECDSA-DES-CBC3-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "3DES"
        "export" String ""
        "keyExchange" String "kRSA"
        "mac" String "SHA1"
        "name" String "DES-CBC3-SHA"
        "protocolVersion" String "SSLv3"

    "cipherFilter" String "DEFAULT"
    "enabledCipher" Array Struct 49
        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "AESGCM"
        "export" String ""
        "keyExchange" String "kECDH"
        "mac" String "AEAD"
        "name" String "ECDHE-RSA-AES256-GCM-SHA384"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aECDSA"
        "encryption" String "AESGCM"
        "export" String ""
        "keyExchange" String "kECDH"
        "mac" String "AEAD"
        "name" String "ECDHE-ECDSA-AES256-GCM-SHA384"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kECDH"
        "mac" String "SHA384"
        "name" String "ECDHE-RSA-AES256-SHA384"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aECDSA"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kECDH"
        "mac" String "SHA384"
        "name" String "ECDHE-ECDSA-AES256-SHA384"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kECDH"
        "mac" String "SHA1"
        "name" String "ECDHE-RSA-AES256-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aECDSA"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kECDH"
        "mac" String "SHA1"
        "name" String "ECDHE-ECDSA-AES256-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aDSS"
        "encryption" String "AESGCM"
        "export" String ""
        "keyExchange" String "kDH"
        "mac" String "AEAD"
        "name" String "DHE-DSS-AES256-GCM-SHA384"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "AESGCM"
        "export" String ""
        "keyExchange" String "kDH"
        "mac" String "AEAD"
        "name" String "DHE-RSA-AES256-GCM-SHA384"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kDH"
        "mac" String "SHA256"
        "name" String "DHE-RSA-AES256-SHA256"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aDSS"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kDH"
        "mac" String "SHA256"
        "name" String "DHE-DSS-AES256-SHA256"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kDH"
        "mac" String "SHA1"
        "name" String "DHE-RSA-AES256-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aDSS"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kDH"
        "mac" String "SHA1"
        "name" String "DHE-DSS-AES256-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aECDH"
        "encryption" String "AESGCM"
        "export" String ""
        "keyExchange" String "kECDH/RSA"
        "mac" String "AEAD"
        "name" String "ECDH-RSA-AES256-GCM-SHA384"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aECDH"
        "encryption" String "AESGCM"
        "export" String ""
        "keyExchange" String "kECDH/ECDSA"
        "mac" String "AEAD"
        "name" String "ECDH-ECDSA-AES256-GCM-SHA384"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aECDH"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kECDH/RSA"
        "mac" String "SHA384"
        "name" String "ECDH-RSA-AES256-SHA384"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aECDH"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kECDH/ECDSA"
        "mac" String "SHA384"
        "name" String "ECDH-ECDSA-AES256-SHA384"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aECDH"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kECDH/RSA"
        "mac" String "SHA1"
        "name" String "ECDH-RSA-AES256-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aECDH"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kECDH/ECDSA"
        "mac" String "SHA1"
        "name" String "ECDH-ECDSA-AES256-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "AESGCM"
        "export" String ""
        "keyExchange" String "kRSA"
        "mac" String "AEAD"
        "name" String "AES256-GCM-SHA384"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kRSA"
        "mac" String "SHA256"
        "name" String "AES256-SHA256"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kRSA"
        "mac" String "SHA1"
        "name" String "AES256-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "AESGCM"
        "export" String ""
        "keyExchange" String "kECDH"
        "mac" String "AEAD"
        "name" String "ECDHE-RSA-AES128-GCM-SHA256"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aECDSA"
        "encryption" String "AESGCM"
        "export" String ""
        "keyExchange" String "kECDH"
        "mac" String "AEAD"
        "name" String "ECDHE-ECDSA-AES128-GCM-SHA256"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kECDH"
        "mac" String "SHA256"
        "name" String "ECDHE-RSA-AES128-SHA256"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aECDSA"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kECDH"
        "mac" String "SHA256"
        "name" String "ECDHE-ECDSA-AES128-SHA256"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kECDH"
        "mac" String "SHA1"
        "name" String "ECDHE-RSA-AES128-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aECDSA"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kECDH"
        "mac" String "SHA1"
        "name" String "ECDHE-ECDSA-AES128-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aDSS"
        "encryption" String "AESGCM"
        "export" String ""
        "keyExchange" String "kDH"
        "mac" String "AEAD"
        "name" String "DHE-DSS-AES128-GCM-SHA256"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "AESGCM"
        "export" String ""
        "keyExchange" String "kDH"
        "mac" String "AEAD"
        "name" String "DHE-RSA-AES128-GCM-SHA256"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kDH"
        "mac" String "SHA256"
        "name" String "DHE-RSA-AES128-SHA256"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aDSS"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kDH"
        "mac" String "SHA256"
        "name" String "DHE-DSS-AES128-SHA256"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kDH"
        "mac" String "SHA1"
        "name" String "DHE-RSA-AES128-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aDSS"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kDH"
        "mac" String "SHA1"
        "name" String "DHE-DSS-AES128-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aECDH"
        "encryption" String "AESGCM"
        "export" String ""
        "keyExchange" String "kECDH/RSA"
        "mac" String "AEAD"
        "name" String "ECDH-RSA-AES128-GCM-SHA256"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aECDH"
        "encryption" String "AESGCM"
        "export" String ""
        "keyExchange" String "kECDH/ECDSA"
        "mac" String "AEAD"
        "name" String "ECDH-ECDSA-AES128-GCM-SHA256"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aECDH"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kECDH/RSA"
        "mac" String "SHA256"
        "name" String "ECDH-RSA-AES128-SHA256"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aECDH"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kECDH/ECDSA"
        "mac" String "SHA256"
        "name" String "ECDH-ECDSA-AES128-SHA256"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aECDH"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kECDH/RSA"
        "mac" String "SHA1"
        "name" String "ECDH-RSA-AES128-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aECDH"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kECDH/ECDSA"
        "mac" String "SHA1"
        "name" String "ECDH-ECDSA-AES128-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "AESGCM"
        "export" String ""
        "keyExchange" String "kRSA"
        "mac" String "AEAD"
        "name" String "AES128-GCM-SHA256"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kRSA"
        "mac" String "SHA256"
        "name" String "AES128-SHA256"
        "protocolVersion" String "TLSv1.2"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "AES"
        "export" String ""
        "keyExchange" String "kRSA"
        "mac" String "SHA1"
        "name" String "AES128-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "3DES"
        "export" String ""
        "keyExchange" String "kECDH"
        "mac" String "SHA1"
        "name" String "ECDHE-RSA-DES-CBC3-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aECDSA"
        "encryption" String "3DES"
        "export" String ""
        "keyExchange" String "kECDH"
        "mac" String "SHA1"
        "name" String "ECDHE-ECDSA-DES-CBC3-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "3DES"
        "export" String ""
        "keyExchange" String "kDH"
        "mac" String "SHA1"
        "name" String "EDH-RSA-DES-CBC3-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aDSS"
        "encryption" String "3DES"
        "export" String ""
        "keyExchange" String "kDH"
        "mac" String "SHA1"
        "name" String "EDH-DSS-DES-CBC3-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aECDH"
        "encryption" String "3DES"
        "export" String ""
        "keyExchange" String "kECDH/RSA"
        "mac" String "SHA1"
        "name" String "ECDH-RSA-DES-CBC3-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aECDH"
        "encryption" String "3DES"
        "export" String ""
        "keyExchange" String "kECDH/ECDSA"
        "mac" String "SHA1"
        "name" String "ECDH-ECDSA-DES-CBC3-SHA"
        "protocolVersion" String "SSLv3"

        nrOfElements 7
        "authentication" String "aRSA"
        "encryption" String "3DES"
        "export" String ""
        "keyExchange" String "kRSA"
        "mac" String "SHA1"
        "name" String "DES-CBC3-SHA"
        "protocolVersion" String "SSLv3" 
)
DEF

########################################################################
#Making MML script#
########################################################################
cat >> mgw1.mml << ABC
.open $simName
.select $nodeName
.start
kertayle:file="$Path/${nodeName}_ssh.mo";
ABC
cat >> mgw2.mml << ABC
.open $simName
.select $nodeName
.start
kertayle:file="$Path/${nodeName}_tls.mo";
ABC
########################################################################
moFiles+=(${nodeName}_ssh.mo)
moFiles+=(${nodeName}_tls.mo)
done

/netsim/inst/netsim_pipe < mgw1.mml
/netsim/inst/netsim_pipe < mgw2.mml
for filenum in ${moFiles[@]}
do
rm $filenum
done
rm mgw*.mml
echo "$0 ended at" $( date +%T );

