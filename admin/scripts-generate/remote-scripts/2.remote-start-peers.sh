source .env
source ./export-ip.sh

export SSHUSER=${PEER_SSHUSER}; export SSHPASS=${PEER_SSHPASS}; export ORG=org1; export PEER=peer0; export PEER_IP=${PEER0_IP}; ./remote-start-peer.sh
export SSHUSER=${PEER_SSHUSER}; export SSHPASS=${PEER_SSHPASS}; export ORG=org1; export PEER=peer1; export PEER_IP=${PEER1_IP}; ./remote-start-peer.sh
export SSHUSER=${PEER_SSHUSER}; export SSHPASS=${PEER_SSHPASS}; export ORG=org1; export PEER=peer2; export PEER_IP=${PEER2_IP}; ./remote-start-peer.sh


