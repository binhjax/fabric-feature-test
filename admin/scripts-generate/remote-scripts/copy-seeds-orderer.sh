
source ../.env

echo
echo "#### Prepare environment on Orderer ${ORDERER} @${ORDERER_IP} ######"
echo "##########################################################"
sshpass -p ${SSHPASS} scp -r \
../../bin \
../../data/network/${ORG}/${ORDERER} \
${SSHUSER}@${ORDERER_IP}:/home/${SSHUSER}/loyalty_hyperledger/

echo "DONE"
