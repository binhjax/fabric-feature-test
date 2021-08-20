package main

/*
func LogError() {
	traceNo := ""

	signedProposal :=
		fmt.Println("FlowTransactionBatchTransfer", traceNo, "[nampkh] signedProposal length = %d", nil, nil, len(signedProposal.Content))
	var a1 []byte
	for n, r := range signedProposal.Content {
		if r.Response.Status < 200 || r.Response.Status >= 400 {
			fmt.Println("FlowTransactionBatchTransfer", traceNo, "[nampkh]proposal response was not successful, error code %d, msg %s", nil, nil, r.Response.Status, r.Response.Message)
			continue
		}

		if n == 0 {
			a1 = r.Payload
			continue
		}

		if !bytes.Equal(a1, r.Payload) {
			fmt.Println("FlowTransactionBatchTransfer", traceNo, "[nampkh] ProposalResponsePayloads do not match", nil, r.Payload)

			fmt.Printf("[nampkh] ProposalResponsePayloads do not match")

			ok := true
			for i, b := range a1 {
				if len(r.Payload) > i {
					if b != r.Payload[i] {
						fmt.Println("FlowTransactionBatchTransfer", traceNo, "[nampkh] payload byte not match:", nil, nil, b, r.Payload[i])

						fmt.Println("[nampkh] payload byte not match: ", b, r.Payload[i])
						ok = false
					}
				} else {
					ok = false
				}
			}

			if ok {
				fmt.Println("FlowTransactionBatchTransfer", traceNo, "[nampkh] how can it be?, every byte is equal", nil, nil)
			}

			continue
		}
	}

	for i, content := range signedProposal.Content {
		payload := content.Response.Payload

		chaincodeResponse, err := lf.DecodeChaincodeResponse(payload, txID)
		if err != nil {
			errMsg := fmt.Sprintf("Error while decode chaincode response: %s", err.Error())
			log.Errorf("FlowTransactionBatchTransfer", traceNo, errMsg, nil, nil)

			if signedProposal != nil {
				for _, content := range signedProposal.Content {
					if content.Response.Message != "" {
						errMsg := content.Response.Message
						log.Errorf("FlowTransactionBatchTransfer", traceNo, errMsg, nil, nil)
					}
				}
			}

			// return txID, &ErrStage{
			// 	Stage: "Decode",
			// 	Err:   err,
			// }
		}
		fmt.Printf("[nampkh] payload length %d: %d \n", i, len(payload)) //reponsoe.payload: Chaincode tra ra ko sai: giong nhau
		fmt.Println("[nampkh] payload bytes", i, ": ", content.Payload)  //Can check => Giong nhau
		fmt.Printf("[nampkh] payload data %d: %+v \n", i, content)       //All: Khac nhau payload + signer
		fmt.Printf("[nampkh] chaincodeResponse %d: %+v \n", i, chaincodeResponse)
	}

}
*/
