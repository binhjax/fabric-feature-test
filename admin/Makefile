
.PHONY : gen-certs gen-artifacts prepare create-channel join-channel update-anchor deploy-all
 
gen-certs:
	bash scripts-generate/1.generate-certificates.sh

gen-artifacts:
	bash scripts-generate/2.generate-channels-artifacts.sh

prepare:
	bash scripts-generate/3.prepare_config.sh

create-channel-1:
	ORG=org1 PEER=peer0 ORDERER=orderer0 CHANNEL_NAME=vnpay-channel-1 scripts-deploy/1.create-channel.sh

create-channel-2:
	ORG=org1 PEER=peer1 ORDERER=orderer1 CHANNEL_NAME=vnpay-channel-2 scripts-deploy/1.create-channel.sh

create-channel-3:
	ORG=org1 PEER=peer2 ORDERER=orderer2 CHANNEL_NAME=vnpay-channel-3 scripts-deploy/1.create-channel.sh
	
create-channel-0:
	ORG=org1 PEER=peer0  ORDERER=orderer0  CHANNEL_NAME=vnpay-channel-0  scripts-deploy/1.create-channel.sh 

create-channel: create-channel-1 create-channel-2  create-channel-3  create-channel-0

join-channel-0:
	ORG=org1 CHANNEL_NAME=vnpay-channel-0 PEER=peer0 scripts-deploy/2.join-channel.sh
	ORG=org1 CHANNEL_NAME=vnpay-channel-0 PEER=peer1 scripts-deploy/2.join-channel.sh
	ORG=org1 CHANNEL_NAME=vnpay-channel-0 PEER=peer2 scripts-deploy/2.join-channel.sh

join-channel-1:
	ORG=org1 CHANNEL_NAME=vnpay-channel-1 PEER=peer0 scripts-deploy/2.join-channel.sh

join-channel-2:
	ORG=org1 CHANNEL_NAME=vnpay-channel-2 PEER=peer1 scripts-deploy/2.join-channel.sh

join-channel-3:
	ORG=org1 CHANNEL_NAME=vnpay-channel-3 PEER=peer2 scripts-deploy/2.join-channel.sh

join-channel: join-channel-0 join-channel-1 join-channel-2 join-channel-3

update-anchor-channel-0:
	ORG=org1 ORGMSP=Org1MSP PEER=peer0 ORDERER=orderer0 CHANNEL_NAME=vnpay-channel-0 scripts-deploy/3.update-anchor-peer.sh

update-anchor-channel-1:
	ORG=org1 ORGMSP=Org1MSP PEER=peer0 ORDERER=orderer0 CHANNEL_NAME=vnpay-channel-1 scripts-deploy/3.update-anchor-peer.sh

update-anchor-channel-2:
	ORG=org1 ORGMSP=Org1MSP PEER=peer1 ORDERER=orderer1 CHANNEL_NAME=vnpay-channel-2 scripts-deploy/3.update-anchor-peer.sh

update-anchor-channel-3:
	ORG=org1 ORGMSP=Org1MSP PEER=peer2 ORDERER=orderer2 CHANNEL_NAME=vnpay-channel-3 scripts-deploy/3.update-anchor-peer.sh


update-anchor: update-anchor-channel-0  update-anchor-channel-1  update-anchor-channel-2  update-anchor-channel-3

install-chaincode-keyman:
	CC_SRC_PATH=${PWD}/src SIGNATURE_POLICY="OutOf(1,'Org1MSP.peer')" CC_NAME="keyman_1" ORG=org1 CC_VERSION="1" CC_SEQUENCE=1 ORDERER=orderer0 CHANNEL_NAME=vnpay-channel-0 PEER=peer0 scripts-deploy/4.install-chaincode.sh
	CC_SRC_PATH=${PWD}/src SIGNATURE_POLICY="OutOf(1,'Org1MSP.peer')" CC_NAME="keyman_1" ORG=org1 CC_VERSION="1" CC_SEQUENCE=1 ORDERER=orderer0 CHANNEL_NAME=vnpay-channel-0 PEER=peer1 scripts-deploy/4.install-chaincode.sh
	CC_SRC_PATH=${PWD}/src SIGNATURE_POLICY="OutOf(1,'Org1MSP.peer')" CC_NAME="keyman_1" ORG=org1 CC_VERSION="1" CC_SEQUENCE=1 ORDERER=orderer0 CHANNEL_NAME=vnpay-channel-0 PEER=peer2 scripts-deploy/4.install-chaincode.sh

commit-chaincode-keyman:
	CORE_PEER_TLS_ENABLED=true CC_SRC_PATH=${PWD}/src SIGNATURE_POLICY="OutOf(1,'Org1MSP.peer')" CC_NAME="keyman_1" ORG=org1  ORG2=org1 CC_VERSION="1" CC_SEQUENCE=1 ORDERER=orderer0 CHANNEL_NAME=vnpay-channel-0 PEER=peer0 scripts-deploy/5.1.commit-chaincode-single-proposer.sh

upgrade-chaincode-keyman:
	CC_SRC_PATH=${PWD}/src SIGNATURE_POLICY="OutOf(1,'Org1MSP.peer')" CC_NAME="keyman_1" ORG=org1 CC_VERSION=$(new-version) CC_SEQUENCE=$(new-version)  ORDERER=orderer0 CHANNEL_NAME=vnpay-channel-0 PEER=peer0 scripts-deploy/7.upgrade-chaincode.sh
	CC_SRC_PATH=${PWD}/src SIGNATURE_POLICY="OutOf(1,'Org1MSP.peer')" CC_NAME="keyman_1" ORG=org1 CC_VERSION=$(new-version) CC_SEQUENCE=$(new-version)  ORDERER=orderer0 CHANNEL_NAME=vnpay-channel-0 PEER=peer1 scripts-deploy/7.upgrade-chaincode.sh
	CC_SRC_PATH=${PWD}/src SIGNATURE_POLICY="OutOf(1,'Org1MSP.peer')" CC_NAME="keyman_1" ORG=org1 CC_VERSION=$(new-version) CC_SEQUENCE=$(new-version)  ORDERER=orderer0 CHANNEL_NAME=vnpay-channel-0 PEER=peer2 scripts-deploy/7.upgrade-chaincode.sh
	CORE_PEER_TLS_ENABLED=true CC_SRC_PATH=${PWD}/src SIGNATURE_POLICY="OutOf(1,'Org1MSP.peer')" CC_NAME="keyman_1" ORG=org1  ORG2=org1 CC_VERSION=$(new-version) CC_SEQUENCE=$(new-version)  ORDERER=orderer0 CHANNEL_NAME=vnpay-channel-0 PEER=peer0 scripts-deploy/5.1.commit-chaincode-single-proposer.sh


install-chaincode-loyalty:
	CC_SRC_PATH=${PWD}/src SIGNATURE_POLICY="OutOf(1,'Org1MSP.peer')" CC_NAME="loyalty_cc_3" ORG=org1 CC_VERSION="1" CC_SEQUENCE=1 ORDERER=orderer0 CHANNEL_NAME=vnpay-channel-1 PEER=peer0 scripts-deploy/4.install-chaincode.sh
	CC_SRC_PATH=${PWD}/src SIGNATURE_POLICY="OutOf(1,'Org1MSP.peer')" CC_NAME="loyalty_cc_3" ORG=org1 CC_VERSION="1" CC_SEQUENCE=1 ORDERER=orderer1 CHANNEL_NAME=vnpay-channel-2 PEER=peer1 scripts-deploy/4.install-chaincode.sh
	CC_SRC_PATH=${PWD}/src SIGNATURE_POLICY="OutOf(1,'Org1MSP.peer')" CC_NAME="loyalty_cc_3" ORG=org1 CC_VERSION="1" CC_SEQUENCE=1 ORDERER=orderer2 CHANNEL_NAME=vnpay-channel-3 PEER=peer2 scripts-deploy/4.install-chaincode.sh

commit-chaincode-loyalty:
	CORE_PEER_TLS_ENABLED=true CC_SRC_PATH=${PWD}/src SIGNATURE_POLICY="OutOf(1,'Org1MSP.peer')" CC_NAME="loyalty_cc_3" ORG=org1  ORG2=org1 CC_VERSION="1" CC_SEQUENCE=1 ORDERER=orderer0 CHANNEL_NAME=vnpay-channel-1 PEER=peer0 scripts-deploy/5.1.commit-chaincode-single-proposer.sh
	CORE_PEER_TLS_ENABLED=true CC_SRC_PATH=${PWD}/src SIGNATURE_POLICY="OutOf(1,'Org1MSP.peer')" CC_NAME="loyalty_cc_3" ORG=org1  ORG2=org1 CC_VERSION="1" CC_SEQUENCE=1 ORDERER=orderer1 CHANNEL_NAME=vnpay-channel-2 PEER=peer1 scripts-deploy/5.1.commit-chaincode-single-proposer.sh
	CORE_PEER_TLS_ENABLED=true CC_SRC_PATH=${PWD}/src SIGNATURE_POLICY="OutOf(1,'Org1MSP.peer')" CC_NAME="loyalty_cc_3" ORG=org1  ORG2=org1 CC_VERSION="1" CC_SEQUENCE=1 ORDERER=orderer2 CHANNEL_NAME=vnpay-channel-3 PEER=peer2 scripts-deploy/5.1.commit-chaincode-single-proposer.sh

upgrade-chaincode-loyalty:
	CC_SRC_PATH=${PWD}/src SIGNATURE_POLICY="OutOf(1,'Org1MSP.peer')" CC_NAME="loyalty_cc_3" ORG=org1 CC_VERSION=$(new-version) CC_SEQUENCE=$(new-version)  ORDERER=orderer0 CHANNEL_NAME=vnpay-channel-1 PEER=peer0 scripts-deploy/7.upgrade-chaincode.sh
	CC_SRC_PATH=${PWD}/src SIGNATURE_POLICY="OutOf(1,'Org1MSP.peer')" CC_NAME="loyalty_cc_3" ORG=org1 CC_VERSION=$(new-version) CC_SEQUENCE=$(new-version)  ORDERER=orderer1 CHANNEL_NAME=vnpay-channel-2 PEER=peer1 scripts-deploy/7.upgrade-chaincode.sh
	CC_SRC_PATH=${PWD}/src SIGNATURE_POLICY="OutOf(1,'Org1MSP.peer')" CC_NAME="loyalty_cc_3" ORG=org1 CC_VERSION=$(new-version) CC_SEQUENCE=$(new-version)  ORDERER=orderer2 CHANNEL_NAME=vnpay-channel-3 PEER=peer2 scripts-deploy/7.upgrade-chaincode.sh
	CORE_PEER_TLS_ENABLED=true CC_SRC_PATH=${PWD}/src SIGNATURE_POLICY="OutOf(1,'Org1MSP.peer')" CC_NAME="loyalty_cc_3" ORG=org1  ORG2=org1 CC_VERSION=$(new-version) CC_SEQUENCE=$(new-version)  ORDERER=orderer0 CHANNEL_NAME=vnpay-channel-1 PEER=peer0 scripts-deploy/5.1.commit-chaincode-single-proposer.sh
	CORE_PEER_TLS_ENABLED=true CC_SRC_PATH=${PWD}/src SIGNATURE_POLICY="OutOf(1,'Org1MSP.peer')" CC_NAME="loyalty_cc_3" ORG=org1  ORG2=org1 CC_VERSION=$(new-version) CC_SEQUENCE=$(new-version)  ORDERER=orderer1 CHANNEL_NAME=vnpay-channel-2 PEER=peer1 scripts-deploy/5.1.commit-chaincode-single-proposer.sh
	CORE_PEER_TLS_ENABLED=true CC_SRC_PATH=${PWD}/src SIGNATURE_POLICY="OutOf(1,'Org1MSP.peer')" CC_NAME="loyalty_cc_3" ORG=org1  ORG2=org1 CC_VERSION=$(new-version) CC_SEQUENCE=$(new-version)  ORDERER=orderer2 CHANNEL_NAME=vnpay-channel-3 PEER=peer2 scripts-deploy/5.1.commit-chaincode-single-proposer.sh


deploy-chaincode-keyman: install-chaincode-keyman commit-chaincode-keyman


deploy-chaincode-loyalty: install-chaincode-loyalty  commit-chaincode-loyalty

deploy-all: create-channel join-channel update-anchor deploy-chaincode-keyman  deploy-chaincode-loyalty

