
source .env

# Generate orderer genesis block
# Generate channel configuration transaction - channel.tx
# Generate anchor peer update for Orgs
[[ -z "$ORG" ]] && export ORG=org1

# CONFIG_DIR=../config/channel-artifacts-1
OUTPUT_DIR=/var/data/generated/channel-artifacts
CMD_DIR=$(pwd)

mkdir -p $OUTPUT_DIR


# if [ -d ${OUTPUT_DIR} ]; then
#     rm -f ${OUTPUT_DIR}/*.tx
#     rm -f ${OUTPUT_DIR}/*.block
# fi


if [ ! -f ${OUTPUT_DIR}/genesis_${ORDERER_CHANNEL_NAME}.block ]; then
echo
echo "#################################################################"
echo "### Generating genesis configuration 'channel.tx' ###"
echo "#################################################################"
set -x
$CMD_DIR/bin/configtxgen -channelID $ORDERER_CHANNEL_NAME-sys-channel -profile $ORDERDER_PROFILE_NAME  -configPath ${CONFIG_DIR} -outputBlock ${OUTPUT_DIR}/genesis_${ORDERER_CHANNEL_NAME}.block
res=$?
set +x
if [ $res -ne 0 ]; then
echo "Failed to generate channel configuration transaction..."
sleep 5
exit 1
fi
fi

PROFILE_NAME=OneOrgChannel

echo
echo "#################################################################"
echo "### Generating channel configuration transaction 'channel.tx' ###"
echo "#################################################################"
set -x
$CMD_DIR/bin/configtxgen -profile $PROFILE_NAME -configPath ${CONFIG_DIR} -outputCreateChannelTx ${OUTPUT_DIR}/${CHANNEL_NAME}.tx -channelID $CHANNEL_NAME
res=$?
set +x
if [ $res -ne 0 ]; then
echo "Failed to generate channel configuration transaction..."
sleep 5
exit 1
fi


if [ ! -f ${OUTPUT_DIR}/${ORGMSP}anchors.tx ]; then
echo "#################################################################"
echo "#######    Generating anchor peer update for ${ORGMSP}   ########"
echo "#################################################################"
set -x
$CMD_DIR/bin/configtxgen -profile $PROFILE_NAME -configPath ${CONFIG_DIR} -outputAnchorPeersUpdate ${OUTPUT_DIR}/${CHANNEL_NAME}_${ORGMSP}anchors.tx -channelID $CHANNEL_NAME -asOrg ${ORGMSP}
res=$?
set +x
if [ $res -ne 0 ]; then
echo "Failed to generate anchor peer update for ${ORGMSP}..."
sleep 5
exit 1
fi

fi