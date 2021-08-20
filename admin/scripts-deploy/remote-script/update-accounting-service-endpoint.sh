
source ../.env

# Peer environment variables
export FABRIC_CFG_PATH=../
export CORE_PEER_LOCALMSPID=${ORG^}MSP
export CORE_PEER_TLS_ENABLED=true

if [[ $ORG = 'org1' ]]; then
    ACCOUNTING_SERVICE_URL=${ACCOUNTING_SERVICE_URL_1}
    FINALIZING_SERVICE_URL=${FINALIZING_SERVICE_URL_1}
elif [[ $ORG = 'org2' ]]; then
    ACCOUNTING_SERVICE_URL=${ACCOUNTING_SERVICE_URL_2}
    FINALIZING_SERVICE_URL=${FINALIZING_SERVICE_URL_2}
else
    ACCOUNTING_SERVICE_URL=${ACCOUNTING_SERVICE_URL_3}
    FINALIZING_SERVICE_URL=${FINALIZING_SERVICE_URL_3}
fi

eval export PORT="\${${PEER^^}_PORT}"

if [[ $ORDERER = 'orderer0' ]]; then
    CHANNEL_NAME=${CHANNEL_1}
else
    CHANNEL_NAME=${CHANNEL_2}
fi

export CORE_PEER_ADDRESS=$PEER.$ORG.$CONSORTIUM:$PORT
export CORE_PEER_MSPCONFIGPATH=${PWD}/../${ORG}/peers/crypto-config/peerOrganizations/$ORG.$CONSORTIUM/users/Admin@$ORG.$CONSORTIUM/msp
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/../${ORG}/peers/crypto-config/peerOrganizations/$ORG.$CONSORTIUM/peers/$PEER.$ORG.$CONSORTIUM/tls/ca.crt
export CORE_PEER_TLS_CERT_FILE=${PWD}/../${ORG}/peers/crypto-config/peerOrganizations/$ORG.$CONSORTIUM/peers/$PEER.$ORG.$CONSORTIUM/tls/server.crt
export CORE_PEER_TLS_KEY_FILE=${PWD}/../${ORG}/peers/crypto-config/peerOrganizations/$ORG.$CONSORTIUM/peers/$PEER.$ORG.$CONSORTIUM/tls/server.key


echo "================ update-account-service + finalizing service ================"
../../../../bin/peer chaincode query \
-C $CHANNEL_NAME \
-n $CC_NAME \
-c '{"Args":["update-accounting-service",''"'${ACCOUNTING_SERVICE_URL}'"','"'${FINALIZING_SERVICE_URL}'"]}'
