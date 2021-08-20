
source ../.env


sshpass -p ${SSHPASS} ssh -o StrictHostKeyChecking=no ${SSHUSER}@${PEER_IP} "echo 'IP_ADDRESS=${PEER_IP}' >> /home/${SSHUSER}/loyalty_hyperledger/peer*/.env"

if [[ $SSHUSER = 'ewallet' ]]; then
sshpass -p ${SSHPASS} ssh -o StrictHostKeyChecking=no ${SSHUSER}@${PEER_IP} <<EOF


    cd /home/ewallet/loyalty_hyperledger/peer*
    source start-peer-remote.sh
EOF
elif [[ $SSHUSER = 'loyalty' ]]; then
sshpass -p ${SSHPASS} ssh -o StrictHostKeyChecking=no ${SSHUSER}@${PEER_IP} <<EOF
    if [ -d /var/loyalty/peer* ]; then
        rm -rf /var/loyalty/peer*/*
    else
        mkdir -p /var/loyalty
    fi

    cd /home/loyalty/loyalty_hyperledger/peer*
    source start-peer-remote.sh
EOF
elif [[ $SSHUSER = 'ubuntu' ]]; then
sshpass -p ${SSHPASS} ssh -o StrictHostKeyChecking=no ${SSHUSER}@${PEER_IP} <<EOF
    if [ -d /var/loyalty/peer* ]; then
        rm -rf /var/loyalty/peer*/*
    else
        mkdir -p /var/loyalty
    fi

    cd /home/ubuntu/loyalty_hyperledger/peer*
    source start-peer-remote.sh
EOF
fi

# end loop through orgs