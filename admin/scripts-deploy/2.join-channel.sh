#!/bin/bash
source .env

# Peer environment variables
export FABRIC_CFG_PATH=./config/startup
export GENERATED_FOLDER=/var/data/generated

export CHAN_ARTI_PATH=$GENERATED_FOLDER/channel-artifacts
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID=${ORG^}MSP


eval export PORT="\${${PEER^^}_PORT}"

export CORE_PEER_ADDRESS=${PEER}.${ORG}.${CONSORTIUM}:${PORT}
export CORE_PEER_MSPCONFIGPATH=${GENERATED_FOLDER}/${ORG}/peers/crypto-config/peerOrganizations/${ORG}.${CONSORTIUM}/users/Admin@${ORG}.${CONSORTIUM}/msp
export CORE_PEER_TLS_ROOTCERT_FILE=${GENERATED_FOLDER}/${ORG}/peers/crypto-config/peerOrganizations/${ORG}.${CONSORTIUM}/peers/${PEER}.${ORG}.${CONSORTIUM}/tls/ca.crt
export CORE_PEER_TLS_CERT_FILE=${GENERATED_FOLDER}/${ORG}/peers/crypto-config/peerOrganizations/${ORG}.${CONSORTIUM}/peers/${PEER}.${ORG}.${CONSORTIUM}/tls/server.crt
export CORE_PEER_TLS_KEY_FILE=${GENERATED_FOLDER}/${ORG}/peers/crypto-config/peerOrganizations/${ORG}.${CONSORTIUM}/peers/${PEER}.${ORG}.${CONSORTIUM}/tls/server.key

echo
echo "#################################################################"
echo "####### Start joining ${PEER}.${ORG} into ${CHANNEL_NAME} ###########"
echo "#################################################################"
set -x
./bin/peer channel join -b ${CHAN_ARTI_PATH}/${CHANNEL_NAME}.block
set +x
sleep 2

set -x
./bin/peer channel list
set +x
