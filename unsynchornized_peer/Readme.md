# Test case: Check Fabric process when peers have different height 
- Scenario: 
    + Peers have different block height 
    + Transaction continually send to fabric 
- Model test:
    + One orderer, 3 peer and one client 
    + Blocking Time: 3s 
- Case: 
    + Case 1:  One peer less block height than others
        - Client send transactions to fabric 
        - Stop one peer and start to cause low block height 
        - Check result
    + Case 2: One peer less txNum than others 
        - Transaction send same in two peer but delay one transaction to send other 
        - Check result 
    + Case 3:  Different Txnum for each peer
        - Create transaction in queue and send to peer in random 
        - Check result 

        
