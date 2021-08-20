
source .env

CONFIG_FOLDER=$(pwd)/config

# Generate orderers certificates
# Generate peers certificates


# Loop through orgs
for i in $(seq 1)
do
ORG=org${i}

ORG_FOLDER=/var/data/generated/$ORG
ORDERER_FOLDER=$ORG_FOLDER/orderers
mkdir -p $ORDERER_FOLDER

echo
echo "##########################################################"
echo "######### Generate $ORG's orderers certificates ##########"
echo "##########################################################"

if [ -d ${ORDERER_FOLDER}/crypto-config ]; then
    rm -Rf ${ORDERER_FOLDER}/crypto-config
fi
if [ -d ${ORDERER_FOLDER}/data ]; then
    rm -Rf ${ORDERER_FOLDER}/data
fi
if [ -d ${ORDERER_FOLDER}/etcdraft ]; then
    rm -Rf ${ORDERER_FOLDER}/etcdraft
fi

set -x
./bin/cryptogen generate --config=$CONFIG_FOLDER/orderers/crypto-config-orderer-${ORG}.yaml --output=${ORDERER_FOLDER}/crypto-config
res=$?
set +x

if [ $res -ne 0 ]; then
echo "Failed to generate orderers certificates..."
sleep 5
exit 1
fi


echo
echo "##########################################################"
echo "######### Generate $ORG's peers certificates #############"
echo "##########################################################"

PEERS_FOLDER=$ORG_FOLDER/peers
mkdir -p $PEERS_FOLDER

if [ -d ${PEERS_FOLDER}/crypto-config ]; then
rm -Rf ${PEERS_FOLDER}/crypto-config
fi
if [ -d ${PEERS_FOLDER}/data ]; then
rm -Rf ${PEERS_FOLDER}/data
fi

sleep 1

set -x
./bin/cryptogen generate --config=$CONFIG_FOLDER/peers/crypto-config-peer-${ORG}.yaml --output=${PEERS_FOLDER}/crypto-config
res=$?
set +x

if [ $res -ne 0 ]; then
echo "Failed to generate peers certificates..."
sleep 5
exit 1
fi

done
