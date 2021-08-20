
source ../.env

echo
echo "########## Cleaning on Peer ${PEER} @${PEER_IP} ###########"
echo "##########################################################"

if [[ $SSHUSER = 'ewallet' ]]; then
sshpass -p ${SSHPASS} ssh -o StrictHostKeyChecking=no ${SSHUSER}@${PEER_IP} <<EOF
pkill peer
# sleep 2
docker rm $(docker ps -aq)

echo "Cleaning..."
if [ -d /home/ewallet/loyalty_hyperledger ]; then
rm -rf /home/ewallet/loyalty_hyperledger/*
fi
# sleep 2

if [ ! -d /home/ewallet/loyalty_hyperledger ]; then
echo "Create folder /home/ewallet/loyalty_hyperledger"
mkdir -p /home/ewallet/loyalty_hyperledger
cd /home/ewallet/loyalty_hyperledger
pwd
fi

rm -rf /var/log/loyalty/*
rm -rf /var/loyalty/*
EOF
elif [[ $SSHUSER = 'loyalty' ]]; then
sshpass -p ${SSHPASS} ssh -o StrictHostKeyChecking=no ${SSHUSER}@${PEER_IP} <<EOF
pkill peer
# sleep 2
docker rm $(docker ps -aq)

echo "Cleaning..."
if [ -d /home/loyalty/loyalty_hyperledger ]; then
rm -rf /home/loyalty/loyalty_hyperledger/*
fi
# sleep 2

if [ ! -d /home/loyalty/loyalty_hyperledger ]; then
echo "Create folder /home/loyalty/loyalty_hyperledger"
mkdir -p /home/loyalty/loyalty_hyperledger
cd /home/loyalty/loyalty_hyperledger
pwd
fi

rm -rf /var/log/loyalty/*
rm -rf /var/loyalty/*
EOF
fi

echo
echo "#### Prepare environment on Peer ${PEER} @${PEER_IP}######"
echo "##########################################################"
sshpass -p ${SSHPASS} scp -r \
../../bin \
../../data/network/${ORG}/${PEER}/ \
${SSHUSER}@${PEER_IP}:/home/${SSHUSER}/loyalty_hyperledger/

