
source .env

# Peer environment variables
export FABRIC_CFG_PATH=./
export CORE_PEER_TLS_ENABLED=true

# ================
# ================

export CORE_PEER_LOCALMSPID=${ORG^}MSP
eval export PORT="\${${PEER^^}_PORT}"
eval export PORT2="\${${PEER2^^}_PORT}"
eval export ORDERER_PORT="\${${ORDERER^^}_PORT}"


export ORDERER_CA=${PWD}/${ORG}/orderers/crypto-config/ordererOrganizations/${ORG}.${CONSORTIUM}/orderers/${ORDERER}.${ORG}.${CONSORTIUM}/msp/tlscacerts/tlsca.${ORG}.${CONSORTIUM}-cert.pem
export CORE_PEER_ADDRESS=$PEER.$ORG.$CONSORTIUM:$PORT
export CORE_PEER_MSPCONFIGPATH=${PWD}/${ORG}/peers/crypto-config/peerOrganizations/$ORG.$CONSORTIUM/users/Admin@$ORG.$CONSORTIUM/msp
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/${ORG}/peers/crypto-config/peerOrganizations/$ORG.$CONSORTIUM/peers/$PEER.$ORG.$CONSORTIUM/tls/ca.crt
export CORE_PEER_TLS_ROOTCERT_FILE_2=${PWD}/${ORG2}/peers/crypto-config/peerOrganizations/${ORG2}.$CONSORTIUM/peers/$PEER2.${ORG2}.$CONSORTIUM/tls/ca.crt
export CORE_PEER_TLS_CERT_FILE=${PWD}/${ORG}/peers/crypto-config/peerOrganizations/$ORG.$CONSORTIUM/peers/$PEER.$ORG.$CONSORTIUM/tls/server.crt
export CORE_PEER_TLS_KEY_FILE=${PWD}/${ORG}/peers/crypto-config/peerOrganizations/$ORG.$CONSORTIUM/peers/$PEER.$ORG.$CONSORTIUM/tls/server.key


# ===========================================
# ===========================================
PKG_NAME=${CC_NAME}-${CC_VERSION}
SEQUENCE=$CC_SEQUENCE

./bin/peer chaincode query -o ${ORDERER}.${ORG}.${CONSORTIUM}:${ORDERER_PORT} -C $CHANNEL_NAME -n $CC_NAME --peerAddresses $CORE_PEER_ADDRESS --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE  -c ${ARGS} --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA