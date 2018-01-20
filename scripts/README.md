# Development Scripts
DEPRECATED - Recommend using the [Truffle Framework](http://truffleframework.com/) and [Ganache](http://truffleframework.com/ganache/) for setting up a private Ethereum network.

## Working with the testnet

- Create genesis block and connect to geth network
```
cd ./scripts
./testnet.sh setup # Create the gensis block
./testnet.sh connect # Estabilsh connect to geth network
```

- In a 2nd tab, attach a console
```
./testnet.sh attach # Establish connection and start geth console
```

- If needed, teardown the database
```
./testnet.sh teardown # Clean up private blockchain data
```

- Other useful stuff in geth
```
personal.newAccount() // create new account
miner.start() // begin mining
miner.stop() // stop mining
```