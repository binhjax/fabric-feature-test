#!/bin/bash
source .env

# Peer environment variables
export FABRIC_CFG_PATH=./config/startup
export GENERATED_FOLDER=/var/data/generated

export CORE_PEER_TLS_ENABLED=true

# ================
# ================

export CORE_PEER_LOCALMSPID=${ORG^}MSP
eval export PORT="\${${PEER^^}_PORT}"
eval export PORT2="\${${PEER2^^}_PORT}"
eval export ORDERER_PORT="\${${ORDERER^^}_PORT}"

export ORDERER_CA=${GENERATED_FOLDER}/${ORG}/orderers/crypto-config/ordererOrganizations/${ORG}.${CONSORTIUM}/orderers/${ORDERER}.${ORG}.${CONSORTIUM}/msp/tlscacerts/tlsca.${ORG}.${CONSORTIUM}-cert.pem
export CORE_PEER_ADDRESS=$PEER.$ORG.$CONSORTIUM:$PORT
export CORE_PEER_MSPCONFIGPATH=${GENERATED_FOLDER}/${ORG}/peers/crypto-config/peerOrganizations/$ORG.$CONSORTIUM/users/Admin@$ORG.$CONSORTIUM/msp
export CORE_PEER_TLS_ROOTCERT_FILE=${GENERATED_FOLDER}/${ORG}/peers/crypto-config/peerOrganizations/$ORG.$CONSORTIUM/peers/$PEER.$ORG.$CONSORTIUM/tls/ca.crt
export CORE_PEER_TLS_ROOTCERT_FILE_2=${GENERATED_FOLDER}/${ORG2}/peers/crypto-config/peerOrganizations/${ORG2}.$CONSORTIUM/peers/$PEER2.${ORG2}.$CONSORTIUM/tls/ca.crt
export CORE_PEER_TLS_CERT_FILE=${GENERATED_FOLDER}/${ORG}/peers/crypto-config/peerOrganizations/$ORG.$CONSORTIUM/peers/$PEER.$ORG.$CONSORTIUM/tls/server.crt
export CORE_PEER_TLS_KEY_FILE=${GENERATED_FOLDER}/${ORG}/peers/crypto-config/peerOrganizations/$ORG.$CONSORTIUM/peers/$PEER.$ORG.$CONSORTIUM/tls/server.key



# ===========================================
# ===========================================
PKG_NAME=${CC_NAME}-${CC_VERSION}
SEQUENCE=$CC_SEQUENCE

echo "================ COMMIT CHAINCODE ${CC_NAME} ================"
echo "================ This will start chaincode container ================"
./bin/peer lifecycle chaincode commit \
-o ${ORDERER}.${ORG}.${CONSORTIUM}:${ORDERER_PORT} \
--channelID $CHANNEL_NAME \
--signature-policy ${SIGNATURE_POLICY} \
--name $CC_NAME \
--version $CC_VERSION \
--sequence $SEQUENCE \
--init-required \
--peerAddresses $CORE_PEER_ADDRESS \
--tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE \
--peerAddresses ${PEER2}.${ORG2}.${CONSORTIUM}:${PORT2} \
--tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_2 \
--tls $CORE_PEER_TLS_ENABLED \
--cafile $ORDERER_CA \
--waitForEvent

echo "================ INVOKE CHAINCODE (INIT FUNCTION) ================"
./bin/peer chaincode invoke \
-o ${ORDERER}.${ORG}.${CONSORTIUM}:${ORDERER_PORT} \
--isInit \
-C $CHANNEL_NAME \
-n $CC_NAME \
--peerAddresses $CORE_PEER_ADDRESS \
--tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE \
--peerAddresses ${PEER2}.${ORG2}.${CONSORTIUM}:${PORT2} \
--tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_2 \
-c '{"Args":["Init"]}' \
--waitForEvent \
--tls $CORE_PEER_TLS_ENABLED \
--cafile $ORDERER_CA \
--waitForEvent