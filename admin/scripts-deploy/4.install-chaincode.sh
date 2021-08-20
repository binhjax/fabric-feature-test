#!/bin/bash
source .env

# Peer environment variables
export FABRIC_CFG_PATH=./config/startup
export GENERATED_FOLDER=/var/data/generated


export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID=${ORG^}MSP

eval export PORT="\${${PEER^^}_PORT}"
eval export ORDERER_PORT="\${${ORDERER^^}_PORT}"

export ORDERER_CA=${GENERATED_FOLDER}/${ORG}/orderers/crypto-config/ordererOrganizations/${ORG}.${CONSORTIUM}/orderers/${ORDERER}.${ORG}.${CONSORTIUM}/msp/tlscacerts/tlsca.${ORG}.${CONSORTIUM}-cert.pem
export CORE_PEER_ADDRESS=$PEER.$ORG.$CONSORTIUM:$PORT
export CORE_PEER_MSPCONFIGPATH=$GENERATED_FOLDER/${ORG}/peers/crypto-config/peerOrganizations/$ORG.$CONSORTIUM/users/Admin@$ORG.$CONSORTIUM/msp
export CORE_PEER_TLS_ROOTCERT_FILE=$GENERATED_FOLDER/${ORG}/peers/crypto-config/peerOrganizations/$ORG.$CONSORTIUM/peers/$PEER.$ORG.$CONSORTIUM/tls/ca.crt
export CORE_PEER_TLS_CERT_FILE=$GENERATED_FOLDER/${ORG}/peers/crypto-config/peerOrganizations/$ORG.$CONSORTIUM/peers/$PEER.$ORG.$CONSORTIUM/tls/server.crt
export CORE_PEER_TLS_KEY_FILE=$GENERATED_FOLDER/${ORG}/peers/crypto-config/peerOrganizations/$ORG.$CONSORTIUM/peers/$PEER.$ORG.$CONSORTIUM/tls/server.key

CC_SRC_PATH=${GENERATED_FOLDER}/chaincodes/accounting-cc/src
LANGUAGE="golang"
PKG_DIR="./chaincodes"
mkdir -p $PKG_DIR

# ==================
# ==================
PKG_NAME=${CC_NAME}-${CC_VERSION}
CC_LABEL=$CC_NAME-$CC_VERSION
SEQUENCE=$CC_SEQUENCE

# echo "================   Package Chaincode ${CC_NAME} Version ${CC_VERSION} ================ "
# if [ ! -f $PKG_DIR/$PKG_NAME.tar.gz ]; then
#     ./bin/peer lifecycle chaincode package $PKG_DIR/$PKG_NAME.tar.gz --path $CC_SRC_PATH --lang $LANGUAGE --label $CC_LABEL
# else
#     echo "Chaincode ${CC_NAME} Version ${CC_VERSION} is already packed!"
# fi

echo "================ INSTALL CHAINCODE $CC_NAME VERSION $CC_VERSION ON $PEER.$ORG ================"
if [ -f $PKG_DIR/$PKG_NAME.tar.gz ]; then
    set -x
    ./bin/peer lifecycle chaincode install $PKG_DIR/$PKG_NAME.tar.gz
    set +x
else
    echo "Chaincode package not found!"
    exit
fi

echo "================ QUERY INSTALLED CHAINCODE TO GET PACKAGE_ID ================"
set -x
./bin/peer lifecycle chaincode queryinstalled | grep $CC_LABEL >$PKG_DIR/log.txt
set +x
cat $PKG_DIR/log.txt
PACKAGE_ID=`sed -n '/Package/{s/^Package ID: //; s/, Label:.*$//; p;}' $PKG_DIR/log.txt`
rm $PKG_DIR/log.txt
echo $PACKAGE_ID

echo "================ APPROVE CHAINCODE ================"
set -x
./bin/peer lifecycle chaincode approveformyorg \
-o ${ORDERER}.${ORG}.${CONSORTIUM}:${ORDERER_PORT} \
--channelID $CHANNEL_NAME \
--signature-policy ${SIGNATURE_POLICY} \
--name $CC_NAME \
--version $CC_VERSION \
--init-required \
--package-id $PACKAGE_ID \
--sequence $SEQUENCE \
--waitForEvent \
--tls $CORE_PEER_TLS_ENABLED \
--cafile $ORDERER_CA \
set +x


echo "================ CHECK COMMIT READINESS ================"
set -x
./bin/peer lifecycle chaincode checkcommitreadiness \
--channelID $CHANNEL_NAME \
--signature-policy ${SIGNATURE_POLICY} \
--name $CC_NAME \
--version $CC_VERSION \
--init-required \
--sequence $SEQUENCE \
--output json
set +x
