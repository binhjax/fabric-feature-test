
source ../.env

# Peer environment variables
export FABRIC_CFG_PATH=../

export CHAN_ARTI_PATH=../channel-artifacts
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID=${ORG^}MSP

export ORDERER=${ORDERER}
eval export ORDERER_PORT="\${${ORDERER^^}_PORT}"

export PEER=${PEER}
eval export PORT="\${${PEER^^}_PORT}"

export ORDERER_CA=${PWD}/../${ORG}/orderers/crypto-config/ordererOrganizations/${ORG}.${CONSORTIUM}/orderers/${ORDERER}.${ORG}.${CONSORTIUM}/msp/tlscacerts/tlsca.${ORG}.${CONSORTIUM}-cert.pem

export CORE_PEER_ADDRESS=${PEER}.${ORG}.${CONSORTIUM}:${PORT}
export CORE_PEER_MSPCONFIGPATH=${PWD}/../${ORG}/peers/crypto-config/peerOrganizations/${ORG}.${CONSORTIUM}/users/Admin@${ORG}.${CONSORTIUM}/msp
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/../${ORG}/peers/crypto-config/peerOrganizations/${ORG}.${CONSORTIUM}/peers/${PEER}.${ORG}.${CONSORTIUM}/tls/ca.crt
export CORE_PEER_TLS_CERT_FILE=${PWD}/../${ORG}/peers/crypto-config/peerOrganizations/${ORG}.${CONSORTIUM}/peers/${PEER}.${ORG}.${CONSORTIUM}/tls/server.crt
export CORE_PEER_TLS_KEY_FILE=${PWD}/../${ORG}/peers/crypto-config/peerOrganizations/${ORG}.${CONSORTIUM}/peers/${PEER}.${ORG}.${CONSORTIUM}/tls/server.key

../../../../bin/peer channel update -o ${ORDERER}.${ORG}.${CONSORTIUM}:${ORDERER_PORT}  -c $CHANNEL_NAME -f ${CHAN_ARTI_PATH}/${CHANNEL_NAME}_${ORG^}MSPanchors.tx --tls --cafile $ORDERER_CA
