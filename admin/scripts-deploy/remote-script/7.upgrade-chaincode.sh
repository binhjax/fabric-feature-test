
source ../.env

# Peer environment variables
export FABRIC_CFG_PATH=../
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID=${ORG^}MSP

eval export PORT="\${${PEER^^}_PORT}"
eval export ORDERER_PORT="\${${ORDERER^^}_PORT}"

export ORDERER_CA=${PWD}/../${ORG}/orderers/crypto-config/ordererOrganizations/${ORG}.${CONSORTIUM}/orderers/${ORDERER}.${ORG}.${CONSORTIUM}/msp/tlscacerts/tlsca.${ORG}.${CONSORTIUM}-cert.pem
export CORE_PEER_ADDRESS=$PEER.$ORG.$CONSORTIUM:$PORT
export CORE_PEER_MSPCONFIGPATH=${PWD}/../${ORG}/peers/crypto-config/peerOrganizations/$ORG.$CONSORTIUM/users/Admin@$ORG.$CONSORTIUM/msp
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/../${ORG}/peers/crypto-config/peerOrganizations/$ORG.$CONSORTIUM/peers/$PEER.$ORG.$CONSORTIUM/tls/ca.crt
export CORE_PEER_TLS_CERT_FILE=${PWD}/../${ORG}/peers/crypto-config/peerOrganizations/$ORG.$CONSORTIUM/peers/$PEER.$ORG.$CONSORTIUM/tls/server.crt
export CORE_PEER_TLS_KEY_FILE=${PWD}/../${ORG}/peers/crypto-config/peerOrganizations/$ORG.$CONSORTIUM/peers/$PEER.$ORG.$CONSORTIUM/tls/server.key

# CC_SRC_PATH=${PWD}/../../../../../chaincodes/accounting-cc/src/main
LANGUAGE="golang"
PKG_DIR="../packed-cc"
mkdir -p $PKG_DIR

# ================
# ================
PKG_NAME=${CC_NAME}-${CC_VERSION}
CC_LABEL=$CC_NAME-$CC_VERSION
SEQUENCE=$CC_SEQUENCE


echo "================   Package Chaincode ${CC_NAME} Version ${CC_VERSION} ================ "
if [ ! -f $PKG_DIR/$PKG_NAME.tar.gz ]; then
    ../../../../bin/peer lifecycle chaincode package $PKG_DIR/$PKG_NAME.tar.gz --path $CC_SRC_PATH --lang $LANGUAGE --label $CC_LABEL
else
    echo "Chaincode ${CC_NAME} Version ${CC_VERSION} is already packed!"
fi

echo "================ INSTALL CHAINCODE $CC_NAME VERSION $CC_VERSION ON $PEER.$ORG ================"
if [ -f $PKG_DIR/$PKG_NAME.tar.gz ]; then
    ../../../../bin/peer lifecycle chaincode install $PKG_DIR/$PKG_NAME.tar.gz
else
    echo "Chaincode package not found!"
    exit
fi


echo "================ QUERY INSTALLED CHAINCODE TO GET PACKAGE_ID ================"
../../../../bin/peer lifecycle chaincode queryinstalled | grep $CC_LABEL >$PKG_DIR/log.txt
cat $PKG_DIR/log.txt
PACKAGE_ID=`sed -n '/Package/{s/^Package ID: //; s/, Label:.*$//; p;}' $PKG_DIR/log.txt`
rm $PKG_DIR/log.txt
echo $PACKAGE_ID



echo "================ APPROVE CHAINCODE ================"
../../../../bin/peer lifecycle chaincode approveformyorg \
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


echo "================ CHECK COMMIT READINESS ================"
../../../../bin/peer lifecycle chaincode checkcommitreadiness \
--channelID $CHANNEL_NAME \
--signature-policy ${SIGNATURE_POLICY} \
--name $CC_NAME \
--version $CC_VERSION \
--init-required \
--sequence $SEQUENCE \
--output json
