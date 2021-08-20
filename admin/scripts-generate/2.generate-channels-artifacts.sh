
export ORDERDER_PROFILE_NAME=MultiNodeEtcdRaft1
export ORDERER_CHANNEL_NAME=vnpay-channel-1
export CHANNEL_NAME=vnpay-channel-1; 
export ORGMSP=Org1MSP; 
export CONFIG_DIR=$(pwd)/config/channel-artifacts/channel1; 

CMD=$(pwd)/scripts-generate
$CMD/generate-channel-artifacts.sh

export ORDERDER_PROFILE_NAME=MultiNodeEtcdRaft2
export ORDERER_CHANNEL_NAME=vnpay-channel-2
export CHANNEL_NAME=vnpay-channel-2; 
export ORGMSP=Org1MSP; 
export CONFIG_DIR=$(pwd)/config/channel-artifacts/channel2; 
$CMD/generate-channel-artifacts.sh

export ORDERDER_PROFILE_NAME=MultiNodeEtcdRaft3
export ORDERER_CHANNEL_NAME=vnpay-channel-3
export CHANNEL_NAME=vnpay-channel-3;
 export ORGMSP=Org1MSP; 
 export CONFIG_DIR=$(pwd)/config/channel-artifacts/channel3; 
$CMD/generate-channel-artifacts.sh

export ORDERER_CHANNEL_NAME=vnpay-channel-0
export CHANNEL_NAME=vnpay-channel-0; 
export ORGMSP=Org1MSP; 
export CONFIG_DIR=$(pwd)/config/channel-artifacts/channel0; 
$CMD/generate-channel-tx.sh
