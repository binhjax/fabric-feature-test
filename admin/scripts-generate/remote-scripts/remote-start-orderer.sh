
source ../.env
echo "##########################################################"
echo "####  Start ${ORDERER}.${ORG}.${CONSORTIUM} @${ORDERER_IP} #######"
echo "cd /home/$SSHUSER/loyalty_hyperledger/${ORDERER}/;source start-orderer-remote.sh" | sshpass -p ${SSHPASS} ssh -o StrictHostKeyChecking=no ${SSHUSER}@${ORDERER_IP} 

