package main

import (
	"fmt"

	"github.com/golang/protobuf/proto"
	"github.com/hyperledger/fabric-protos-go/ledger/rwset"
	"github.com/hyperledger/fabric-protos-go/ledger/rwset/kvrwset"
	"github.com/hyperledger/fabric/protoutil"
)

type KVData struct {
	Collection string `json:"collection"` // optional
	Key        string `json:"key"`        // required
	Value      string `json:"value"`      // required for read, ignored for write
}

func main() {
	fmt.Println("Decode payload data 0")
	//Ok case 1
	// payload0 := "\n Vo\026\361d]\233\231\311\301 *\221\324C\211\253\357\335\277K\271\332\365\332\215V\212\241Mt\"\022\201\013\n\222\007\022?\n\n_lifecycle\0221\n/\n'namespaces/fields/loyalty_cc_2/Sequence\022\004\010\260\310\001\022\316\006\n\014loyalty_cc_2\022\275\006\n\030\n\020\000\364\217\277\277initialized\022\004\010\261\310\001\n\032\n\020001:100_channel1\022\006\010\316\361\005\020\001\032\221\002\n\213\002\000account~traceNo~nonce~reqType~amount~balanceBefore~balanceAfter~additionalPoint~totalPointBefore~totalPointAfter~txID\000001:100_channel1\000TRANS_TRANSFER1to1time1\00032\000TRANS_TRANSFER/TRANS_DEBIT\0001\0001\0000\0000\0000\0000\0005669db6d84ffae46fe7d62967cdae82f87e9481b86adde2d9e4a5269de643586\000\032\001\000\032\212\002\n\204\002\000account~traceNo~nonce~reqType~amount~balanceBefore~balanceAfter~additionalPoint~totalPointBefore~totalPointAfter~txID\000202:09\000TRANS_TRANSFER1to1time1\00019\000TRANS_TRANSFER/TRANS_CREDIT\0001\00016\00017\0000\0000\0000\0005669db6d84ffae46fe7d62967cdae82f87e9481b86adde2d9e4a5269de643586\000\032\001\000\032v\n\020001:100_channel1\032b32 16 0 0 d99c1600d8cbb08e674f3258ea4b503d2acd78673469d3e7eb3dc037ad6f624e TRANS_TRANSFER1to1time1\032l\n\006202:09\032b19 1 17 0 24145cfb168e4cfe123ebe58bdea04dc3c6346360e2bcc54a47c8b43034d5100 TRANS_TRANSFER1to1time1\032\326\003\010\310\001\032\320\003y\377\201\003\001\001\021ChaincodeResponse\001\377\202\000\001\006\001\004TxID\001\014\000\001\rAccountTxHash\001\014\000\001\016ReceiverTxHash\001\014\000\001\007Message\001\014\000\001\006Signer\001\014\000\001\017BatchJobWrapper\001\377\206\000\000\000'\377\205\002\001\001\030[]*types.BatchJobAccount\001\377\206\000\001\377\204\000\000F\377\203\003\001\002\377\204\000\001\004\001\tAccountID\001\014\000\001\nReceiverID\001\014\000\001\006ErrMsg\001\014\000\001\rChaincodeHash\001\014\000\000\000\377\345\377\202\001@5669db6d84ffae46fe7d62967cdae82f87e9481b86adde2d9e4a5269de643586\001@d99c1600d8cbb08e674f3258ea4b503d2acd78673469d3e7eb3dc037ad6f624e\003\017vnpay-channel-1\001\001\002\006202:09\002@24145cfb168e4cfe123ebe58bdea04dc3c6346360e2bcc54a47c8b43034d5100\000\000\"\021\022\014loyalty_cc_2\032\0012"
	// payload1 := "\n Vo\026\361d]\233\231\311\301 *\221\324C\211\253\357\335\277K\271\332\365\332\215V\212\241Mt\"\022\201\013\n\222\007\022?\n\n_lifecycle\0221\n/\n'namespaces/fields/loyalty_cc_2/Sequence\022\004\010\260\310\001\022\316\006\n\014loyalty_cc_2\022\275\006\n\030\n\020\000\364\217\277\277initialized\022\004\010\261\310\001\n\032\n\020001:100_channel1\022\006\010\316\361\005\020\001\032\221\002\n\213\002\000account~traceNo~nonce~reqType~amount~balanceBefore~balanceAfter~additionalPoint~totalPointBefore~totalPointAfter~txID\000001:100_channel1\000TRANS_TRANSFER1to1time1\00032\000TRANS_TRANSFER/TRANS_DEBIT\0001\0001\0000\0000\0000\0000\0005669db6d84ffae46fe7d62967cdae82f87e9481b86adde2d9e4a5269de643586\000\032\001\000\032\212\002\n\204\002\000account~traceNo~nonce~reqType~amount~balanceBefore~balanceAfter~additionalPoint~totalPointBefore~totalPointAfter~txID\000202:09\000TRANS_TRANSFER1to1time1\00019\000TRANS_TRANSFER/TRANS_CREDIT\0001\00016\00017\0000\0000\0000\0005669db6d84ffae46fe7d62967cdae82f87e9481b86adde2d9e4a5269de643586\000\032\001\000\032v\n\020001:100_channel1\032b32 16 0 0 d99c1600d8cbb08e674f3258ea4b503d2acd78673469d3e7eb3dc037ad6f624e TRANS_TRANSFER1to1time1\032l\n\006202:09\032b19 1 17 0 24145cfb168e4cfe123ebe58bdea04dc3c6346360e2bcc54a47c8b43034d5100 TRANS_TRANSFER1to1time1\032\326\003\010\310\001\032\320\003y\377\201\003\001\001\021ChaincodeResponse\001\377\202\000\001\006\001\004TxID\001\014\000\001\rAccountTxHash\001\014\000\001\016ReceiverTxHash\001\014\000\001\007Message\001\014\000\001\006Signer\001\014\000\001\017BatchJobWrapper\001\377\206\000\000\000'\377\205\002\001\001\030[]*types.BatchJobAccount\001\377\206\000\001\377\204\000\000F\377\203\003\001\002\377\204\000\001\004\001\tAccountID\001\014\000\001\nReceiverID\001\014\000\001\006ErrMsg\001\014\000\001\rChaincodeHash\001\014\000\000\000\377\345\377\202\001@5669db6d84ffae46fe7d62967cdae82f87e9481b86adde2d9e4a5269de643586\001@d99c1600d8cbb08e674f3258ea4b503d2acd78673469d3e7eb3dc037ad6f624e\003\017vnpay-channel-1\001\001\002\006202:09\002@24145cfb168e4cfe123ebe58bdea04dc3c6346360e2bcc54a47c8b43034d5100\000\000\"\021\022\014loyalty_cc_2\032\0012"
	// payload2 := "\n Vo\026\361d]\233\231\311\301 *\221\324C\211\253\357\335\277K\271\332\365\332\215V\212\241Mt\"\022\201\013\n\222\007\022?\n\n_lifecycle\0221\n/\n'namespaces/fields/loyalty_cc_2/Sequence\022\004\010\260\310\001\022\316\006\n\014loyalty_cc_2\022\275\006\n\030\n\020\000\364\217\277\277initialized\022\004\010\261\310\001\n\032\n\020001:100_channel1\022\006\010\316\361\005\020\001\032\221\002\n\213\002\000account~traceNo~nonce~reqType~amount~balanceBefore~balanceAfter~additionalPoint~totalPointBefore~totalPointAfter~txID\000001:100_channel1\000TRANS_TRANSFER1to1time1\00032\000TRANS_TRANSFER/TRANS_DEBIT\0001\0001\0000\0000\0000\0000\0005669db6d84ffae46fe7d62967cdae82f87e9481b86adde2d9e4a5269de643586\000\032\001\000\032\212\002\n\204\002\000account~traceNo~nonce~reqType~amount~balanceBefore~balanceAfter~additionalPoint~totalPointBefore~totalPointAfter~txID\000202:09\000TRANS_TRANSFER1to1time1\00019\000TRANS_TRANSFER/TRANS_CREDIT\0001\00016\00017\0000\0000\0000\0005669db6d84ffae46fe7d62967cdae82f87e9481b86adde2d9e4a5269de643586\000\032\001\000\032v\n\020001:100_channel1\032b32 16 0 0 d99c1600d8cbb08e674f3258ea4b503d2acd78673469d3e7eb3dc037ad6f624e TRANS_TRANSFER1to1time1\032l\n\006202:09\032b19 1 17 0 24145cfb168e4cfe123ebe58bdea04dc3c6346360e2bcc54a47c8b43034d5100 TRANS_TRANSFER1to1time1\032\326\003\010\310\001\032\320\003y\377\201\003\001\001\021ChaincodeResponse\001\377\202\000\001\006\001\004TxID\001\014\000\001\rAccountTxHash\001\014\000\001\016ReceiverTxHash\001\014\000\001\007Message\001\014\000\001\006Signer\001\014\000\001\017BatchJobWrapper\001\377\206\000\000\000'\377\205\002\001\001\030[]*types.BatchJobAccount\001\377\206\000\001\377\204\000\000F\377\203\003\001\002\377\204\000\001\004\001\tAccountID\001\014\000\001\nReceiverID\001\014\000\001\006ErrMsg\001\014\000\001\rChaincodeHash\001\014\000\000\000\377\345\377\202\001@5669db6d84ffae46fe7d62967cdae82f87e9481b86adde2d9e4a5269de643586\001@d99c1600d8cbb08e674f3258ea4b503d2acd78673469d3e7eb3dc037ad6f624e\003\017vnpay-channel-1\001\001\002\006202:09\002@24145cfb168e4cfe123ebe58bdea04dc3c6346360e2bcc54a47c8b43034d5100\000\000\"\021\022\014loyalty_cc_2\032\0012"

	//Ok case 2
	// payload0 := "\n \273\214h\256\352\256^\363\033\365\274n\231k\370q\010\3076}\031\237c\221?\322d\221vc9\250\022\201\013\n\222\007\022?\n\n_lifecycle\0221\n/\n'namespaces/fields/loyalty_cc_2/Sequence\022\004\010\260\310\001\022\316\006\n\014loyalty_cc_2\022\275\006\n\030\n\020\000\364\217\277\277initialized\022\004\010\261\310\001\n\032\n\020001:100_channel1\022\006\010\346\363\005\020\014\032\221\002\n\213\002\000account~traceNo~nonce~reqType~amount~balanceBefore~balanceAfter~additionalPoint~totalPointBefore~totalPointAfter~txID\000001:100_channel1\000TRANS_TRANSFER1to1time2\00034\000TRANS_TRANSFER/TRANS_DEBIT\0001\0001\0000\0000\0000\0000\000a835b96b50622be0901365a9499f52f6de8d6c5813db5d87b81ce3f51ba86cc4\000\032\001\000\032\212\002\n\204\002\000account~traceNo~nonce~reqType~amount~balanceBefore~balanceAfter~additionalPoint~totalPointBefore~totalPointAfter~txID\000202:09\000TRANS_TRANSFER1to1time2\00020\000TRANS_TRANSFER/TRANS_CREDIT\0001\00017\00018\0000\0000\0000\000a835b96b50622be0901365a9499f52f6de8d6c5813db5d87b81ce3f51ba86cc4\000\032\001\000\032v\n\020001:100_channel1\032b34 17 0 0 f96bbd06a4debc72ff4368c0fac5f5ec96946ab09f55b04845676bdea5af94bd TRANS_TRANSFER1to1time2\032l\n\006202:09\032b20 1 18 0 99b272864a6ac8ebce757dff3ebf7f27af308b28226b674542b19869f4bd80a9 TRANS_TRANSFER1to1time2\032\326\003\010\310\001\032\320\003y\377\201\003\001\001\021ChaincodeResponse\001\377\202\000\001\006\001\004TxID\001\014\000\001\rAccountTxHash\001\014\000\001\016ReceiverTxHash\001\014\000\001\007Message\001\014\000\001\006Signer\001\014\000\001\017BatchJobWrapper\001\377\206\000\000\000'\377\205\002\001\001\030[]*types.BatchJobAccount\001\377\206\000\001\377\204\000\000F\377\203\003\001\002\377\204\000\001\004\001\tAccountID\001\014\000\001\nReceiverID\001\014\000\001\006ErrMsg\001\014\000\001\rChaincodeHash\001\014\000\000\000\377\345\377\202\001@a835b96b50622be0901365a9499f52f6de8d6c5813db5d87b81ce3f51ba86cc4\001@f96bbd06a4debc72ff4368c0fac5f5ec96946ab09f55b04845676bdea5af94bd\003\017vnpay-channel-1\001\001\002\006202:09\002@99b272864a6ac8ebce757dff3ebf7f27af308b28226b674542b19869f4bd80a9\000\000\"\021\022\014loyalty_cc_2\032\0012"
	// payload1 := "\n \273\214h\256\352\256^\363\033\365\274n\231k\370q\010\3076}\031\237c\221?\322d\221vc9\250\022\201\013\n\222\007\022?\n\n_lifecycle\0221\n/\n'namespaces/fields/loyalty_cc_2/Sequence\022\004\010\260\310\001\022\316\006\n\014loyalty_cc_2\022\275\006\n\030\n\020\000\364\217\277\277initialized\022\004\010\261\310\001\n\032\n\020001:100_channel1\022\006\010\346\363\005\020\014\032\221\002\n\213\002\000account~traceNo~nonce~reqType~amount~balanceBefore~balanceAfter~additionalPoint~totalPointBefore~totalPointAfter~txID\000001:100_channel1\000TRANS_TRANSFER1to1time2\00034\000TRANS_TRANSFER/TRANS_DEBIT\0001\0001\0000\0000\0000\0000\000a835b96b50622be0901365a9499f52f6de8d6c5813db5d87b81ce3f51ba86cc4\000\032\001\000\032\212\002\n\204\002\000account~traceNo~nonce~reqType~amount~balanceBefore~balanceAfter~additionalPoint~totalPointBefore~totalPointAfter~txID\000202:09\000TRANS_TRANSFER1to1time2\00020\000TRANS_TRANSFER/TRANS_CREDIT\0001\00017\00018\0000\0000\0000\000a835b96b50622be0901365a9499f52f6de8d6c5813db5d87b81ce3f51ba86cc4\000\032\001\000\032v\n\020001:100_channel1\032b34 17 0 0 f96bbd06a4debc72ff4368c0fac5f5ec96946ab09f55b04845676bdea5af94bd TRANS_TRANSFER1to1time2\032l\n\006202:09\032b20 1 18 0 99b272864a6ac8ebce757dff3ebf7f27af308b28226b674542b19869f4bd80a9 TRANS_TRANSFER1to1time2\032\326\003\010\310\001\032\320\003y\377\201\003\001\001\021ChaincodeResponse\001\377\202\000\001\006\001\004TxID\001\014\000\001\rAccountTxHash\001\014\000\001\016ReceiverTxHash\001\014\000\001\007Message\001\014\000\001\006Signer\001\014\000\001\017BatchJobWrapper\001\377\206\000\000\000'\377\205\002\001\001\030[]*types.BatchJobAccount\001\377\206\000\001\377\204\000\000F\377\203\003\001\002\377\204\000\001\004\001\tAccountID\001\014\000\001\nReceiverID\001\014\000\001\006ErrMsg\001\014\000\001\rChaincodeHash\001\014\000\000\000\377\345\377\202\001@a835b96b50622be0901365a9499f52f6de8d6c5813db5d87b81ce3f51ba86cc4\001@f96bbd06a4debc72ff4368c0fac5f5ec96946ab09f55b04845676bdea5af94bd\003\017vnpay-channel-1\001\001\002\006202:09\002@99b272864a6ac8ebce757dff3ebf7f27af308b28226b674542b19869f4bd80a9\000\000\"\021\022\014loyalty_cc_2\032\0012"
	// payload2 := "\n \273\214h\256\352\256^\363\033\365\274n\231k\370q\010\3076}\031\237c\221?\322d\221vc9\250\022\201\013\n\222\007\022?\n\n_lifecycle\0221\n/\n'namespaces/fields/loyalty_cc_2/Sequence\022\004\010\260\310\001\022\316\006\n\014loyalty_cc_2\022\275\006\n\030\n\020\000\364\217\277\277initialized\022\004\010\261\310\001\n\032\n\020001:100_channel1\022\006\010\346\363\005\020\014\032\221\002\n\213\002\000account~traceNo~nonce~reqType~amount~balanceBefore~balanceAfter~additionalPoint~totalPointBefore~totalPointAfter~txID\000001:100_channel1\000TRANS_TRANSFER1to1time2\00034\000TRANS_TRANSFER/TRANS_DEBIT\0001\0001\0000\0000\0000\0000\000a835b96b50622be0901365a9499f52f6de8d6c5813db5d87b81ce3f51ba86cc4\000\032\001\000\032\212\002\n\204\002\000account~traceNo~nonce~reqType~amount~balanceBefore~balanceAfter~additionalPoint~totalPointBefore~totalPointAfter~txID\000202:09\000TRANS_TRANSFER1to1time2\00020\000TRANS_TRANSFER/TRANS_CREDIT\0001\00017\00018\0000\0000\0000\000a835b96b50622be0901365a9499f52f6de8d6c5813db5d87b81ce3f51ba86cc4\000\032\001\000\032v\n\020001:100_channel1\032b34 17 0 0 f96bbd06a4debc72ff4368c0fac5f5ec96946ab09f55b04845676bdea5af94bd TRANS_TRANSFER1to1time2\032l\n\006202:09\032b20 1 18 0 99b272864a6ac8ebce757dff3ebf7f27af308b28226b674542b19869f4bd80a9 TRANS_TRANSFER1to1time2\032\326\003\010\310\001\032\320\003y\377\201\003\001\001\021ChaincodeResponse\001\377\202\000\001\006\001\004TxID\001\014\000\001\rAccountTxHash\001\014\000\001\016ReceiverTxHash\001\014\000\001\007Message\001\014\000\001\006Signer\001\014\000\001\017BatchJobWrapper\001\377\206\000\000\000'\377\205\002\001\001\030[]*types.BatchJobAccount\001\377\206\000\001\377\204\000\000F\377\203\003\001\002\377\204\000\001\004\001\tAccountID\001\014\000\001\nReceiverID\001\014\000\001\006ErrMsg\001\014\000\001\rChaincodeHash\001\014\000\000\000\377\345\377\202\001@a835b96b50622be0901365a9499f52f6de8d6c5813db5d87b81ce3f51ba86cc4\001@f96bbd06a4debc72ff4368c0fac5f5ec96946ab09f55b04845676bdea5af94bd\003\017vnpay-channel-1\001\001\002\006202:09\002@99b272864a6ac8ebce757dff3ebf7f27af308b28226b674542b19869f4bd80a9\000\000\"\021\022\014loyalty_cc_2\032\0012"

	payload0 := "\n p\314:\374Y\332H\312\013\3302\005\331\031\271 1\217\013b\262wYz\260\317\321Pi\213\031?\022\201\013\n\222\007\022?\n\n_lifecycle\0221\n/\n'namespaces/fields/loyalty_cc_2/Sequence\022\004\010\260\310\001\022\316\006\n\014loyalty_cc_2\022\275\006\n\030\n\020\000\364\217\277\277initialized\022\004\010\261\310\001\n\032\n\020001:100_channel1\022\006\010\376\363\005\020\001\032\221\002\n\213\002\000account~traceNo~nonce~reqType~amount~balanceBefore~balanceAfter~additionalPoint~totalPointBefore~totalPointAfter~txID\000001:100_channel1\000TRANS_TRANSFER1to1time3\00036\000TRANS_TRANSFER/TRANS_DEBIT\0001\0001\0000\0000\0000\0000\00075dd677d0a3601d782690ec545e1e10cb0476887f742900d624350e4e5692c1b\000\032\001\000\032\212\002\n\204\002\000account~traceNo~nonce~reqType~amount~balanceBefore~balanceAfter~additionalPoint~totalPointBefore~totalPointAfter~txID\000202:09\000TRANS_TRANSFER1to1time3\00021\000TRANS_TRANSFER/TRANS_CREDIT\0001\00018\00019\0000\0000\0000\00075dd677d0a3601d782690ec545e1e10cb0476887f742900d624350e4e5692c1b\000\032\001\000\032v\n\020001:100_channel1\032b36 18 0 0 8d00ec9262f7bbed24cea3ed4f25845a67d2022338afe7569998e887b57183d0 TRANS_TRANSFER1to1time3\032l\n\006202:09\032b21 1 19 0 91036f7dcc493349020153dbe251fd380430c5464428e3d6ebbad7e9c1647eec TRANS_TRANSFER1to1time3\032\326\003\010\310\001\032\320\003y\377\201\003\001\001\021ChaincodeResponse\001\377\202\000\001\006\001\004TxID\001\014\000\001\rAccountTxHash\001\014\000\001\016ReceiverTxHash\001\014\000\001\007Message\001\014\000\001\006Signer\001\014\000\001\017BatchJobWrapper\001\377\206\000\000\000'\377\205\002\001\001\030[]*types.BatchJobAccount\001\377\206\000\001\377\204\000\000F\377\203\003\001\002\377\204\000\001\004\001\tAccountID\001\014\000\001\nReceiverID\001\014\000\001\006ErrMsg\001\014\000\001\rChaincodeHash\001\014\000\000\000\377\345\377\202\001@75dd677d0a3601d782690ec545e1e10cb0476887f742900d624350e4e5692c1b\001@8d00ec9262f7bbed24cea3ed4f25845a67d2022338afe7569998e887b57183d0\003\017vnpay-channel-1\001\001\002\006202:09\002@91036f7dcc493349020153dbe251fd380430c5464428e3d6ebbad7e9c1647eec\000\000\"\021\022\014loyalty_cc_2\032\0012"
	payload1 := "\n p\314:\374Y\332H\312\013\3302\005\331\031\271 1\217\013b\262wYz\260\317\321Pi\213\031?\022\201\013\n\222\007\022?\n\n_lifecycle\0221\n/\n'namespaces/fields/loyalty_cc_2/Sequence\022\004\010\260\310\001\022\316\006\n\014loyalty_cc_2\022\275\006\n\030\n\020\000\364\217\277\277initialized\022\004\010\261\310\001\n\032\n\020001:100_channel1\022\006\010\376\363\005\020\001\032\221\002\n\213\002\000account~traceNo~nonce~reqType~amount~balanceBefore~balanceAfter~additionalPoint~totalPointBefore~totalPointAfter~txID\000001:100_channel1\000TRANS_TRANSFER1to1time3\00036\000TRANS_TRANSFER/TRANS_DEBIT\0001\0001\0000\0000\0000\0000\00075dd677d0a3601d782690ec545e1e10cb0476887f742900d624350e4e5692c1b\000\032\001\000\032\212\002\n\204\002\000account~traceNo~nonce~reqType~amount~balanceBefore~balanceAfter~additionalPoint~totalPointBefore~totalPointAfter~txID\000202:09\000TRANS_TRANSFER1to1time3\00021\000TRANS_TRANSFER/TRANS_CREDIT\0001\00018\00019\0000\0000\0000\00075dd677d0a3601d782690ec545e1e10cb0476887f742900d624350e4e5692c1b\000\032\001\000\032v\n\020001:100_channel1\032b36 18 0 0 8d00ec9262f7bbed24cea3ed4f25845a67d2022338afe7569998e887b57183d0 TRANS_TRANSFER1to1time3\032l\n\006202:09\032b21 1 19 0 91036f7dcc493349020153dbe251fd380430c5464428e3d6ebbad7e9c1647eec TRANS_TRANSFER1to1time3\032\326\003\010\310\001\032\320\003y\377\201\003\001\001\021ChaincodeResponse\001\377\202\000\001\006\001\004TxID\001\014\000\001\rAccountTxHash\001\014\000\001\016ReceiverTxHash\001\014\000\001\007Message\001\014\000\001\006Signer\001\014\000\001\017BatchJobWrapper\001\377\206\000\000\000'\377\205\002\001\001\030[]*types.BatchJobAccount\001\377\206\000\001\377\204\000\000F\377\203\003\001\002\377\204\000\001\004\001\tAccountID\001\014\000\001\nReceiverID\001\014\000\001\006ErrMsg\001\014\000\001\rChaincodeHash\001\014\000\000\000\377\345\377\202\001@75dd677d0a3601d782690ec545e1e10cb0476887f742900d624350e4e5692c1b\001@8d00ec9262f7bbed24cea3ed4f25845a67d2022338afe7569998e887b57183d0\003\017vnpay-channel-1\001\001\002\006202:09\002@91036f7dcc493349020153dbe251fd380430c5464428e3d6ebbad7e9c1647eec\000\000\"\021\022\014loyalty_cc_2\032\0012"
	payload2 := "\n p\314:\374Y\332H\312\013\3302\005\331\031\271 1\217\013b\262wYz\260\317\321Pi\213\031?\022\201\013\n\222\007\022?\n\n_lifecycle\0221\n/\n'namespaces/fields/loyalty_cc_2/Sequence\022\004\010\260\310\001\022\316\006\n\014loyalty_cc_2\022\275\006\n\030\n\020\000\364\217\277\277initialized\022\004\010\261\310\001\n\032\n\020001:100_channel1\022\006\010\376\363\005\020\001\032\221\002\n\213\002\000account~traceNo~nonce~reqType~amount~balanceBefore~balanceAfter~additionalPoint~totalPointBefore~totalPointAfter~txID\000001:100_channel1\000TRANS_TRANSFER1to1time3\00036\000TRANS_TRANSFER/TRANS_DEBIT\0001\0001\0000\0000\0000\0000\00075dd677d0a3601d782690ec545e1e10cb0476887f742900d624350e4e5692c1b\000\032\001\000\032\212\002\n\204\002\000account~traceNo~nonce~reqType~amount~balanceBefore~balanceAfter~additionalPoint~totalPointBefore~totalPointAfter~txID\000202:09\000TRANS_TRANSFER1to1time3\00021\000TRANS_TRANSFER/TRANS_CREDIT\0001\00018\00019\0000\0000\0000\00075dd677d0a3601d782690ec545e1e10cb0476887f742900d624350e4e5692c1b\000\032\001\000\032v\n\020001:100_channel1\032b36 18 0 0 8d00ec9262f7bbed24cea3ed4f25845a67d2022338afe7569998e887b57183d0 TRANS_TRANSFER1to1time3\032l\n\006202:09\032b21 1 19 0 91036f7dcc493349020153dbe251fd380430c5464428e3d6ebbad7e9c1647eec TRANS_TRANSFER1to1time3\032\326\003\010\310\001\032\320\003y\377\201\003\001\001\021ChaincodeResponse\001\377\202\000\001\006\001\004TxID\001\014\000\001\rAccountTxHash\001\014\000\001\016ReceiverTxHash\001\014\000\001\007Message\001\014\000\001\006Signer\001\014\000\001\017BatchJobWrapper\001\377\206\000\000\000'\377\205\002\001\001\030[]*types.BatchJobAccount\001\377\206\000\001\377\204\000\000F\377\203\003\001\002\377\204\000\001\004\001\tAccountID\001\014\000\001\nReceiverID\001\014\000\001\006ErrMsg\001\014\000\001\rChaincodeHash\001\014\000\000\000\377\345\377\202\001@75dd677d0a3601d782690ec545e1e10cb0476887f742900d624350e4e5692c1b\001@8d00ec9262f7bbed24cea3ed4f25845a67d2022338afe7569998e887b57183d0\003\017vnpay-channel-1\001\001\002\006202:09\002@91036f7dcc493349020153dbe251fd380430c5464428e3d6ebbad7e9c1647eec\000\000\"\021\022\014loyalty_cc_2\032\0012"

	//Error case
	// payload0 := "\n \252WUb\270\350\\\357\034\td\245\216\245\236K\224t\227\226#f\210\305\177\024\256\221\262\021\2518\022\377\n\n\220\007\022?\n\n_lifecycle\0221\n/\n'namespaces/fields/loyalty_cc_2/Sequence\022\004\010\260\310\001\022\314\006\n\014loyalty_cc_2\022\273\006\n\030\n\020\000\364\217\277\277initialized\022\004\010\261\310\001\n\030\n\020001:100_channel1\022\004\010\221\364\005\032\221\002\n\213\002\000account~traceNo~nonce~reqType~amount~balanceBefore~balanceAfter~additionalPoint~totalPointBefore~totalPointAfter~txID\000001:100_channel1\000TRANS_TRANSFER1to1time5\00040\000TRANS_TRANSFER/TRANS_DEBIT\0001\0001\0000\0000\0000\0000\000a256f301b8656c16e375d6f179a61968e4ef96a3235ff5403d4646b3cc88de30\000\032\001\000\032\212\002\n\204\002\000account~traceNo~nonce~reqType~amount~balanceBefore~balanceAfter~additionalPoint~totalPointBefore~totalPointAfter~txID\000202:09\000TRANS_TRANSFER1to1time5\00023\000TRANS_TRANSFER/TRANS_CREDIT\0001\00020\00021\0000\0000\0000\000a256f301b8656c16e375d6f179a61968e4ef96a3235ff5403d4646b3cc88de30\000\032\001\000\032v\n\020001:100_channel1\032b40 20 0 0 2fcd4defd6a0de96d90e4067a8de141e2e8a05cf50e763c35d2a56fa4b7237d1 TRANS_TRANSFER1to1time5\032l\n\006202:09\032b23 1 21 0 7f35b15f549bdcb92e0437dc84f8c6560c5a088830c51d60f8f405de8affb56d TRANS_TRANSFER1to1time5\032\326\003\010\310\001\032\320\003y\377\201\003\001\001\021ChaincodeResponse\001\377\202\000\001\006\001\004TxID\001\014\000\001\rAccountTxHash\001\014\000\001\016ReceiverTxHash\001\014\000\001\007Message\001\014\000\001\006Signer\001\014\000\001\017BatchJobWrapper\001\377\206\000\000\000'\377\205\002\001\001\030[]*types.BatchJobAccount\001\377\206\000\001\377\204\000\000F\377\203\003\001\002\377\204\000\001\004\001\tAccountID\001\014\000\001\nReceiverID\001\014\000\001\006ErrMsg\001\014\000\001\rChaincodeHash\001\014\000\000\000\377\345\377\202\001@a256f301b8656c16e375d6f179a61968e4ef96a3235ff5403d4646b3cc88de30\001@2fcd4defd6a0de96d90e4067a8de141e2e8a05cf50e763c35d2a56fa4b7237d1\003\017vnpay-channel-1\001\001\002\006202:09\002@7f35b15f549bdcb92e0437dc84f8c6560c5a088830c51d60f8f405de8affb56d\000\000\"\021\022\014loyalty_cc_2\032\0012"
	// payload1 := "\n \252WUb\270\350\\\357\034\td\245\216\245\236K\224t\227\226#f\210\305\177\024\256\221\262\021\2518\022\201\013\n\222\007\022?\n\n_lifecycle\0221\n/\n'namespaces/fields/loyalty_cc_2/Sequence\022\004\010\260\310\001\022\316\006\n\014loyalty_cc_2\022\275\006\n\030\n\020\000\364\217\277\277initialized\022\004\010\261\310\001\n\032\n\020001:100_channel1\022\006\010\231\364\005\020\n\032\221\002\n\213\002\000account~traceNo~nonce~reqType~amount~balanceBefore~balanceAfter~additionalPoint~totalPointBefore~totalPointAfter~txID\000001:100_channel1\000TRANS_TRANSFER1to1time5\00040\000TRANS_TRANSFER/TRANS_DEBIT\0001\0001\0000\0000\0000\0000\000a256f301b8656c16e375d6f179a61968e4ef96a3235ff5403d4646b3cc88de30\000\032\001\000\032\212\002\n\204\002\000account~traceNo~nonce~reqType~amount~balanceBefore~balanceAfter~additionalPoint~totalPointBefore~totalPointAfter~txID\000202:09\000TRANS_TRANSFER1to1time5\00023\000TRANS_TRANSFER/TRANS_CREDIT\0001\00020\00021\0000\0000\0000\000a256f301b8656c16e375d6f179a61968e4ef96a3235ff5403d4646b3cc88de30\000\032\001\000\032v\n\020001:100_channel1\032b40 20 0 0 2fcd4defd6a0de96d90e4067a8de141e2e8a05cf50e763c35d2a56fa4b7237d1 TRANS_TRANSFER1to1time5\032l\n\006202:09\032b23 1 21 0 7f35b15f549bdcb92e0437dc84f8c6560c5a088830c51d60f8f405de8affb56d TRANS_TRANSFER1to1time5\032\326\003\010\310\001\032\320\003y\377\201\003\001\001\021ChaincodeResponse\001\377\202\000\001\006\001\004TxID\001\014\000\001\rAccountTxHash\001\014\000\001\016ReceiverTxHash\001\014\000\001\007Message\001\014\000\001\006Signer\001\014\000\001\017BatchJobWrapper\001\377\206\000\000\000'\377\205\002\001\001\030[]*types.BatchJobAccount\001\377\206\000\001\377\204\000\000F\377\203\003\001\002\377\204\000\001\004\001\tAccountID\001\014\000\001\nReceiverID\001\014\000\001\006ErrMsg\001\014\000\001\rChaincodeHash\001\014\000\000\000\377\345\377\202\001@a256f301b8656c16e375d6f179a61968e4ef96a3235ff5403d4646b3cc88de30\001@2fcd4defd6a0de96d90e4067a8de141e2e8a05cf50e763c35d2a56fa4b7237d1\003\017vnpay-channel-1\001\001\002\006202:09\002@7f35b15f549bdcb92e0437dc84f8c6560c5a088830c51d60f8f405de8affb56d\000\000\"\021\022\014loyalty_cc_2\032\0012"
	// payload2 := "\n \252WUb\270\350\\\357\034\td\245\216\245\236K\224t\227\226#f\210\305\177\024\256\221\262\021\2518\022\377\n\n\220\007\022?\n\n_lifecycle\0221\n/\n'namespaces/fields/loyalty_cc_2/Sequence\022\004\010\260\310\001\022\314\006\n\014loyalty_cc_2\022\273\006\n\030\n\020\000\364\217\277\277initialized\022\004\010\261\310\001\n\030\n\020001:100_channel1\022\004\010\221\364\005\032\221\002\n\213\002\000account~traceNo~nonce~reqType~amount~balanceBefore~balanceAfter~additionalPoint~totalPointBefore~totalPointAfter~txID\000001:100_channel1\000TRANS_TRANSFER1to1time5\00040\000TRANS_TRANSFER/TRANS_DEBIT\0001\0001\0000\0000\0000\0000\000a256f301b8656c16e375d6f179a61968e4ef96a3235ff5403d4646b3cc88de30\000\032\001\000\032\212\002\n\204\002\000account~traceNo~nonce~reqType~amount~balanceBefore~balanceAfter~additionalPoint~totalPointBefore~totalPointAfter~txID\000202:09\000TRANS_TRANSFER1to1time5\00023\000TRANS_TRANSFER/TRANS_CREDIT\0001\00020\00021\0000\0000\0000\000a256f301b8656c16e375d6f179a61968e4ef96a3235ff5403d4646b3cc88de30\000\032\001\000\032v\n\020001:100_channel1\032b40 20 0 0 2fcd4defd6a0de96d90e4067a8de141e2e8a05cf50e763c35d2a56fa4b7237d1 TRANS_TRANSFER1to1time5\032l\n\006202:09\032b23 1 21 0 7f35b15f549bdcb92e0437dc84f8c6560c5a088830c51d60f8f405de8affb56d TRANS_TRANSFER1to1time5\032\326\003\010\310\001\032\320\003y\377\201\003\001\001\021ChaincodeResponse\001\377\202\000\001\006\001\004TxID\001\014\000\001\rAccountTxHash\001\014\000\001\016ReceiverTxHash\001\014\000\001\007Message\001\014\000\001\006Signer\001\014\000\001\017BatchJobWrapper\001\377\206\000\000\000'\377\205\002\001\001\030[]*types.BatchJobAccount\001\377\206\000\001\377\204\000\000F\377\203\003\001\002\377\204\000\001\004\001\tAccountID\001\014\000\001\nReceiverID\001\014\000\001\006ErrMsg\001\014\000\001\rChaincodeHash\001\014\000\000\000\377\345\377\202\001@a256f301b8656c16e375d6f179a61968e4ef96a3235ff5403d4646b3cc88de30\001@2fcd4defd6a0de96d90e4067a8de141e2e8a05cf50e763c35d2a56fa4b7237d1\003\017vnpay-channel-1\001\001\002\006202:09\002@7f35b15f549bdcb92e0437dc84f8c6560c5a088830c51d60f8f405de8affb56d\000\000\"\021\022\014loyalty_cc_2\032\0012"

	data0 := []byte(payload0)

	pRespPayload0, err := protoutil.UnmarshalProposalResponsePayload(data0)
	if err != nil {
		fmt.Println("Error: ", err)
		return
	}

	data1 := []byte(payload1)
	pRespPayload1, err := protoutil.UnmarshalProposalResponsePayload(data1)
	if err != nil {
		fmt.Println("Error: ", err)
		return
	}

	data2 := []byte(payload2)
	pRespPayload2, err := protoutil.UnmarshalProposalResponsePayload(data2)
	if err != nil {
		fmt.Println("Error: ", err)
		return
	}
	// fmt.Println("Extension1 = ", pRespPayload1.Extension)
	// if bytes.Equal(pRespPayload0.ProposalHash, pRespPayload1.ProposalHash) {
	// 	fmt.Println("ProposalHash0 = ProposalHash1", pRespPayload0.ProposalHash)
	// } else {
	// 	fmt.Println("ProposalHash0 !=  ProposalHash1")
	// 	fmt.Println("ProposalHash0=", pRespPayload0.ProposalHash)
	// 	fmt.Println("ProposalHash0=", pRespPayload1.ProposalHash)
	// }
	//Compare extension
	ccAction0, err := protoutil.UnmarshalChaincodeAction(pRespPayload0.Extension)
	if err != nil {
		fmt.Println("UnmarshalChaincodeAction :  pRespPayload0.Extension ", err)
		return
	}

	ccAction1, err := protoutil.UnmarshalChaincodeAction(pRespPayload1.Extension)
	if err != nil {
		fmt.Println("UnmarshalChaincodeAction :  pRespPayload1.Extension ", err)
		return
	}

	ccAction2, err := protoutil.UnmarshalChaincodeAction(pRespPayload2.Extension)
	if err != nil {
		fmt.Println("UnmarshalChaincodeAction :  pRespPayload1.Extension ", err)
		return
	}

	// fmt.Println("ccAction0.ChaincodeId = ", ccAction0.ChaincodeId)
	// fmt.Println("ccAction1.ChaincodeId = ", ccAction1.ChaincodeId)

	// fmt.Println("ccAction0.Events = ", ccAction0.Events)
	// fmt.Println("ccAction1.Events = ", ccAction1.Events)

	// fmt.Println("ccAction0.Response.Status = ", ccAction0.Response.Status)
	// fmt.Println("ccAction1.Response.Status = ", ccAction1.Response.Status)

	// fmt.Println("ccAction0.Response.Message = ", ccAction0.Response.Message)
	// fmt.Println("ccAction1.Response.Message = ", ccAction1.Response.Message)

	// if bytes.Equal(ccAction0.Response.Payload, ccAction0.Response.Payload) {
	// 	fmt.Println("ccAction0.Response.Payload = ccAction1.Response.Payload")

	// } else {
	// 	fmt.Println("ccAction0.Response.Payload = ", ccAction0.Response.Payload)
	// 	fmt.Println("ccAction1.Response.Payload = ", ccAction1.Response.Payload)
	// }

	fmt.Println("ccAction0.Results Len ", len(ccAction0.Results))

	txRWSet0 := &rwset.TxReadWriteSet{}
	err = proto.Unmarshal(ccAction0.Results, txRWSet0)
	if err != nil {
		fmt.Println("Cannot decode ccAction0.Results", err)
		return
	}
	fmt.Println("txRWSet0.DataModel:", txRWSet0.DataModel)
	for i, item := range txRWSet0.NsRwset {
		fmt.Printf("txRWSet0.Item %d, namespace: %s \n", i, item.Namespace)
		kvrwset := &kvrwset.KVRWSet{}
		err := proto.Unmarshal(item.Rwset, kvrwset)
		if err != nil {
			fmt.Printf("txRWSet0.Item %d, namespace: %s, rwset failed Unmarshal: %s \n", i, item.Namespace, err)
			continue
		}
		fmt.Printf("txRWSet0.Item %d, namespace: %s: All readset \n", i, item.Namespace)
		for j, rset := range kvrwset.Reads {
			if rset != nil {
				fmt.Printf("txRWSet1.Item %d, namespace: %s: redset: %d, key: %s, version.BlockNum: %d , version.TxNum: %d  \n", i, item.Namespace, j, rset.Key, rset.Version.BlockNum, rset.Version.TxNum)
			}
		}
		// fmt.Printf("txRWSet0.Item %d, namespace: %s: All writeset \n", i, item.Namespace)
		// for j, wset := range kvrwset.Writes {
		// 	if wset != nil {
		// 		fmt.Printf("txRWSet0.Item %d, namespace: %s: wset: %d, key: %s, value: %+v, isDelete: %t \n", i, item.Namespace, j, wset.Key, wset.Value, wset.IsDelete)
		// 	}
		// }

	}

	txRWSet1 := &rwset.TxReadWriteSet{}
	err = proto.Unmarshal(ccAction1.Results, txRWSet1)
	if err != nil {
		fmt.Println("Cannot decode ccAction0.Results", err)
		return
	}
	fmt.Println("txRWSet1.DataModel:", txRWSet1.DataModel)
	for i, item := range txRWSet1.NsRwset {
		fmt.Printf("txRWSet1.Item %d, namespace: %s \n", i, item.Namespace)
		kvrwset := &kvrwset.KVRWSet{}
		err := proto.Unmarshal(item.Rwset, kvrwset)
		if err != nil {
			fmt.Printf("txRWSet1.Item %d, namespace: %s, rwset failed Unmarshal: %s \n", i, item.Namespace, err)
			continue
		}
		fmt.Printf("txRWSet1.Item %d, namespace: %s: All readset \n", i, item.Namespace)
		for j, rset := range kvrwset.Reads {
			if rset != nil {
				fmt.Printf("txRWSet1.Item %d, namespace: %s: redset: %d, key: %s, version.BlockNum: %d , version.TxNum: %d  \n", i, item.Namespace, j, rset.Key, rset.Version.BlockNum, rset.Version.TxNum)
			}
		}
		// fmt.Printf("txRWSet1.Item %d, namespace: %s: All writeset \n", i, item.Namespace)
		// for j, wset := range kvrwset.Writes {
		// 	if wset != nil {
		// 		fmt.Printf("txRWSet1.Item %d, namespace: %s: wset: %d, key: %s, value: %+v, isDelete: %t \n", i, item.Namespace, j, wset.Key, wset.Value, wset.IsDelete)
		// 	}
		// }

	}

	txRWSet2 := &rwset.TxReadWriteSet{}
	err = proto.Unmarshal(ccAction2.Results, txRWSet2)
	if err != nil {
		fmt.Println("Cannot decode ccAction0.Results", err)
		return
	}
	fmt.Println("txRWSet2.DataModel:", txRWSet2.DataModel)
	for i, item := range txRWSet2.NsRwset {
		fmt.Printf("txRWSet2.Item %d, namespace: %s \n", i, item.Namespace)
		kvrwset := &kvrwset.KVRWSet{}
		err := proto.Unmarshal(item.Rwset, kvrwset)
		if err != nil {
			fmt.Printf("txRWSet2.Item %d, namespace: %s, rwset failed Unmarshal: %s \n", i, item.Namespace, err)
			continue
		}
		fmt.Printf("txRWSet2.Item %d, namespace: %s: All readset \n", i, item.Namespace)
		for j, rset := range kvrwset.Reads {
			if rset != nil {
				fmt.Printf("txRWSet2.Item %d, namespace: %s: redset: %d, key: %s, version.BlockNum: %d , version.TxNum: %d  \n", i, item.Namespace, j, rset.Key, rset.Version.BlockNum, rset.Version.TxNum)
			}
		}
		// fmt.Printf("txRWSet2.Item %d, namespace: %s: All writeset \n", i, item.Namespace)
		// for j, wset := range kvrwset.Writes {
		// 	if wset != nil {
		// 		fmt.Printf("txRWSet2.Item %d, namespace: %s: wset: %d, key: %s, value: %+v, isDelete: %t \n", i, item.Namespace, j, wset.Key, wset.Value, wset.IsDelete)
		// 	}
		// }

	}
}
