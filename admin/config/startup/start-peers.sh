
source .env

export FABRIC_CFG_PATH=./

export CORE_VM_ENDPOINT=unix://var/run/docker.sock
# the following setting starts chaincode containers on the same
# bridge network as the peers
# https://docs.docker.com/compose/networking/
export CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=${NETWORK_NAME}
export FABRIC_LOGGING_SPEC=INFO
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_PROFILE_ENABLED=false
export CORE_PEER_LOCALMSPID=${ORG^}MSP

export PEER=${PEER}
export IP_ADDRESS=${IP_ADDRESS}
eval export PORT="\${${PEER^^}_PORT}"
eval export CC_PORT="\${${PEER^^}_CC_PORT}"
eval export CORE_OPERATIONS_LISTENADDRESS="\${${PEER^^}_CORE_OPERATIONS_LISTENADDRESS}"

export CORE_PEER_FILESYSTEMPATH=${PEER_FOLDER}/${PEER}_${ORG}

export CORE_PEER_MSPCONFIGPATH=${PWD}/peers/crypto-config/peerOrganizations/${ORG}.${CONSORTIUM}/peers/${PEER}.${ORG}.${CONSORTIUM}/msp
export CORE_PEER_TLS_CERT_FILE=${PWD}/peers/crypto-config/peerOrganizations/${ORG}.${CONSORTIUM}/peers/${PEER}.${ORG}.${CONSORTIUM}/tls/server.crt
export CORE_PEER_TLS_KEY_FILE=${PWD}/peers/crypto-config/peerOrganizations/${ORG}.${CONSORTIUM}/peers/${PEER}.${ORG}.${CONSORTIUM}/tls/server.key
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/peers/crypto-config/peerOrganizations/${ORG}.${CONSORTIUM}/peers/${PEER}.${ORG}.${CONSORTIUM}/tls/ca.crt
export CORE_PEER_TLS_CLIENTROOTCAS_FILES=[${PWD}/peers/crypto-config/peerOrganizations/${ORG}.${CONSORTIUM}/peers/${PEER}.${ORG}.${CONSORTIUM}/tls/ca.crt]
# Peer specific variabes
export CORE_PEER_ID=${PEER}.${ORG}.${CONSORTIUM}
export CORE_PEER_ADDRESS=${PEER}.${ORG}.${CONSORTIUM}:${PORT}
export CORE_PEER_LISTENADDRESS=${PEER}.${ORG}.${CONSORTIUM}:${PORT}
export CORE_PEER_CHAINCODEADDRESS=${IP_ADDRESS}:${CC_PORT}
export CORE_PEER_CHAINCODELISTENADDRESS=0.0.0.0:${CC_PORT}
export CORE_PEER_GOSSIP_BOOTSTRAP=${PEER}.${ORG}.${CONSORTIUM}:${PORT}
export CORE_PEER_GOSSIP_EXTERNALENDPOINT=${PEER}.${ORG}.${CONSORTIUM}:${PORT}

mkdir -p $LOG_FOLDER

set -x
#./bin/peer node start &>${LOG_FOLDER}/${PEER}_${ORG}_log.txt
./bin/peer node start
# disown
res=$?
set +x
sleep 2
