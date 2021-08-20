source .env
source ./export-ip.sh

export SSHUSER=${ORDERER_SSHUSER}; export SSHPASS=${ORDERER_SSHPASS}; export ORG=org1; export ORDERER=orderer0; export ORDERER_IP=${ORDERER0_IP}; ./clean-orderers.sh 
export SSHUSER=${ORDERER_SSHUSER}; export SSHPASS=${ORDERER_SSHPASS}; export ORG=org1; export ORDERER=orderer1; export ORDERER_IP=${ORDERER1_IP}; ./clean-orderers.sh 
export SSHUSER=${ORDERER_SSHUSER}; export SSHPASS=${ORDERER_SSHPASS}; export ORG=org1; export ORDERER=orderer2; export ORDERER_IP=${ORDERER2_IP}; ./clean-orderers.sh 

export SSHUSER=${ORDERER_SSHUSER}; export SSHPASS=${ORDERER_SSHPASS}; export ORG=org1; export ORDERER=orderer0; export ORDERER_IP=${ORDERER0_IP}; ./copy-seeds-orderer.sh
export SSHUSER=${ORDERER_SSHUSER}; export SSHPASS=${ORDERER_SSHPASS}; export ORG=org1; export ORDERER=orderer1; export ORDERER_IP=${ORDERER1_IP}; ./copy-seeds-orderer.sh
export SSHUSER=${ORDERER_SSHUSER}; export SSHPASS=${ORDERER_SSHPASS}; export ORG=org1; export ORDERER=orderer2; export ORDERER_IP=${ORDERER2_IP}; ./copy-seeds-orderer.sh


export SSHUSER=${PEER_SSHUSER}; export SSHPASS=${PEER_SSHPASS}; export ORG=org1; export PEER=peer0; export PEER_IP=${PEER0_IP}; ./copy-seeds-peer.sh
export SSHUSER=${PEER_SSHUSER}; export SSHPASS=${PEER_SSHPASS}; export ORG=org1; export PEER=peer1; export PEER_IP=${PEER1_IP}; ./copy-seeds-peer.sh
export SSHUSER=${PEER_SSHUSER}; export SSHPASS=${PEER_SSHPASS}; export ORG=org1; export PEER=peer2; export PEER_IP=${PEER2_IP}; ./copy-seeds-peer.sh
