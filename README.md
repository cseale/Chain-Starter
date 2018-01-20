# Patreon-The-Blockchain
A kickstarter rip-off built on top of Request Network


# Development

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
