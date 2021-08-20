source .env

export FABRIC_CFG_PATH=./
export CHAN_ARTI_PATH=./channel-artifacts
export ORDERER_GENERAL_LOCALMSPID=Orderer${ORG^}MSP
export FABRIC_LOGGING_SPEC=INFO
export ORDERER_GENERAL_LISTENADDRESS=0.0.0.0
export ORDERER_GENERAL_TLS_ENABLED=true
export ORDERER_GENERAL_BOOTSTRAPMETHOD=file


export ORDERER=${ORDERER}
eval export PORT="\${${ORDERER^^}_PORT}"
eval export ORDERER_OPERATIONS_LISTENADDRESS="\${${ORDERER^^}_ORDERER_OPERATIONS_LISTENADDRESS}"
# export PORT=7050
# export ORDERER_OPERATIONS_LISTENADDRESS=127.0.0.1:8443

export CHANNEL=${ORDERER_CHANNEL_NAME}

export ORDERER_GENERAL_BOOTSTRAPFILE=${PWD}/$CHAN_ARTI_PATH/genesis_${CHANNEL}.block
export ORDERER_FILELEDGER_LOCATION=${ORDERER_FOLDER}/${ORDERER}_${ORG}/data
export ORDERER_GENERAL_LISTENPORT=${PORT}
export ORDERER_GENERAL_LOCALMSPDIR=${PWD}/orderers/crypto-config/ordererOrganizations/${ORG}.${CONSORTIUM}/orderers/${ORDERER}.${ORG}.${CONSORTIUM}/msp
export ORDERER_GENERAL_TLS_PRIVATEKEY=${PWD}/orderers/crypto-config/ordererOrganizations/${ORG}.${CONSORTIUM}/orderers/${ORDERER}.${ORG}.${CONSORTIUM}/tls/server.key
export ORDERER_GENERAL_TLS_CERTIFICATE=${PWD}/orderers/crypto-config/ordererOrganizations/${ORG}.${CONSORTIUM}/orderers/${ORDERER}.${ORG}.${CONSORTIUM}/tls/server.crt
export ORDERER_GENERAL_TLS_ROOTCAS=[${PWD}/orderers/crypto-config/ordererOrganizations/${ORG}.${CONSORTIUM}/orderers/${ORDERER}.${ORG}.${CONSORTIUM}/tls/ca.crt]
export ORDERER_GENERAL_CLUSTER_CLIENTCERTIFICATE=${PWD}/orderers/crypto-config/ordererOrganizations/${ORG}.${CONSORTIUM}/orderers/${ORDERER}.${ORG}.${CONSORTIUM}/tls/server.crt
export ORDERER_GENERAL_CLUSTER_CLIENTPRIVATEKEY=${PWD}/orderers/crypto-config/ordererOrganizations/${ORG}.${CONSORTIUM}/orderers/${ORDERER}.${ORG}.${CONSORTIUM}/tls/server.key
export ORDERER_GENERAL_CLUSTER_ROOTCAS=[${PWD}/orderers/crypto-config/ordererOrganizations/${ORG}.${CONSORTIUM}/orderers/${ORDERER}.${ORG}.${CONSORTIUM}/tls/ca.crt]

mkdir -p $LOG_FOLDER

set -x
#./bin/orderer &>${LOG_FOLDER}/${ORDERER}_log.txt
./bin/orderer
# disown
res=$?
set +x
