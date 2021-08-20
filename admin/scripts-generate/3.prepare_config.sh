source .env

CONFIG_FOLDER=$(pwd)/config
GENERATE_FOLDER=/var/data/generated
NETWORK_FOLDER=/var/data/network


if [ -d $NETWORK_FOLDER ]; then
  rm -rf $NETWORK_FOLDER/*
fi
# Loop through orgs
for i in $(seq 1)
do
  ORG=org${i}
  ORG_FOLDER=$GENERATE_FOLDER/$ORG
  mkdir -p $NETWORK_FOLDER/$ORG

  #Create config for order
  for ORDERER in "orderer0" "orderer1" "orderer2" "orderer3" "orderer4" "orderer5" "orderer6" "orderer7" "orderer8"; do
    FOLDER_ORDER=$NETWORK_FOLDER/$ORG/$ORDERER # network/data/network/org1/orderer0
    mkdir -p $FOLDER_ORDER
    eval export ORDERER_CHANNEL_NAME="\${${ORDERER^^}_CHANNEL_NAME}"

    cp $CONFIG_FOLDER/startup/orderer.yaml  $FOLDER_ORDER
    cp $CONFIG_FOLDER/startup/start-orderer.sh  $FOLDER_ORDER
    cp $CONFIG_FOLDER/startup/start-orderer-remote.sh  $FOLDER_ORDER
    cp -R $GENERATE_FOLDER/channel-artifacts $FOLDER_ORDER

    cp $(pwd)/.env $FOLDER_ORDER

    CRYPTO_FOLDER=$ORG_FOLDER/orderers
    cp -R $CRYPTO_FOLDER $FOLDER_ORDER
    echo "ORG=$ORG">> $FOLDER_ORDER/.env
    echo "ORDERER=$ORDERER">> $FOLDER_ORDER/.env
    echo "ORDERER_CHANNEL_NAME=$ORDERER_CHANNEL_NAME">> $FOLDER_ORDER/.env
    chmod +x $FOLDER_ORDER/start-orderer.sh
  done

  #Create config for peer
  for PEER in "peer0" "peer1" "peer2" "peer3" "peer4" "peer5" "peer6" "peer7" "peer8" ; do
    PEER_FOLDER=$NETWORK_FOLDER/$ORG/$PEER # network/data/network/org1/peer0
    mkdir -p $PEER_FOLDER

    cp $CONFIG_FOLDER/startup/core.yaml  $PEER_FOLDER
    cp $CONFIG_FOLDER/startup/start-peers.sh  $PEER_FOLDER
    cp $CONFIG_FOLDER/startup/start-peer-remote.sh  $PEER_FOLDER
    cp -R $GENERATE_FOLDER/channel-artifacts $PEER_FOLDER

    cp $(pwd)/.env $PEER_FOLDER
    
    cp -R $ORG_FOLDER/peers $PEER_FOLDER
    chmod +x $PEER_FOLDER/start-peers.sh
    echo "ORG=$ORG">> $PEER_FOLDER/.env
    echo "PEER=$PEER">> $PEER_FOLDER/.env
    echo "IP_ADDRESS=${PEER}.${ORG}.${CONSORTIUM}" >> $PEER_FOLDER/.env
  done

# End Loop through orgs
done
