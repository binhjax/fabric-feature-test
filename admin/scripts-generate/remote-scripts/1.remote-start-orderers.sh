source .env
source ./export-ip.sh

export SSHUSER=${ORDERER_SSHUSER}; export SSHPASS=${ORDERER_SSHPASS}; export ORG=org1; export ORDERER=orderer0; export ORDERER_IP=${ORDERER0_IP}; ./remote-start-orderer.sh
export SSHUSER=${ORDERER_SSHUSER}; export SSHPASS=${ORDERER_SSHPASS}; export ORG=org1; export ORDERER=orderer1; export ORDERER_IP=${ORDERER1_IP}; ./remote-start-orderer.sh
export SSHUSER=${ORDERER_SSHUSER}; export SSHPASS=${ORDERER_SSHPASS}; export ORG=org1; export ORDERER=orderer2; export ORDERER_IP=${ORDERER2_IP}; ./remote-start-orderer.sh


