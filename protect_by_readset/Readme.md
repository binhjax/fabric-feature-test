# Test case: Protect double spend by readset 
- Scenario: 
    + Chaincode using ledger in localMemory 
    + Transaction protect by readset by Nonce Number 
    + Ledger loaded to memory when start chaincode 
- Model test:
    + One orderer, one peer and one client 
- Case: 
    + Case 1:  Double spend prevent by  Nonce Number in Chaincode 
        - 10 thread sens trasanction to chaincode 
        - Each thread send 100 transation
        - Check result:
    + Case 2:  Double spend prevent by Nonce Number 
        - Send 10 transaction but not submit 
        - Restart peer to load Nonce from ledger 
        - Create new 10 transaction and submit 
        - Submit 10 transction before 
    + Case 3:  Double spend prevent by Nonce Number 
        - Send 10 transaction but not submit 
        - Restart peer to load Nonce from ledger 
        - Submit 1 transaction at fifth   
        - Submit 10 transction to verify reject in transaction 5 

        
