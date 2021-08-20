
source ../.env

echo
echo "########## Cleaning on Orderer ${ORDERER} @${ORDERER_IP} ###########"
echo "##########################################################"
if [[ $SSHUSER = 'ewallet' ]]; then
sshpass -p ${SSHPASS} ssh -o StrictHostKeyChecking=no ${SSHUSER}@${ORDERER_IP} <<EOF
pkill orderer

# sleep 2

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
sshpass -p ${SSHPASS} ssh -o StrictHostKeyChecking=no ${SSHUSER}@${ORDERER_IP} <<EOF
pkill orderer

# sleep 2

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

elif [[ $SSHUSER = 'ubuntu' ]]; then
sshpass -p ${SSHPASS} ssh -o StrictHostKeyChecking=no ${SSHUSER}@${ORDERER_IP} <<EOF
pkill orderer

# sleep 2

echo "Cleaning..."
if [ -d /home/ubuntu/loyalty_hyperledger ]; then
rm -rf /home/ubuntu/loyalty_hyperledger/*
fi
# sleep 2

if [ ! -d /home/ubuntu/loyalty_hyperledger ]; then
echo "Create folder /home/ubuntu/loyalty_hyperledger"
mkdir -p /home/ubuntu/loyalty_hyperledger
cd /home/ubuntu/loyalty_hyperledger
pwd
fi

rm -rf /var/log/loyalty/*
rm -rf /var/loyalty/*
EOF

fi
