#!/bin/bash

##### Script file to setup and connect to local testnet for development

##### Constants

DEV_DIR="$HOME/dev"
DATA_DIR="$DEV_DIR/chaindata"
GENESIS_FILE="genesis.json"
IPC_PATH="$DATA_DIR/geth.ipc"

COMMAND=$1

##### Functions

init()
{
    mkdir -p $DATA_DIR
    geth --datadir $DATA_DIR init $GENESIS_FILE
}

accounts()
{
    geth account list --datadir $DATA_DIR
}

connect()
{
    geth --datadir $DATA_DIR --networkid=15
}

attach()
{
    geth attach $IPC_PATH
}

teardown()
{
    geth --datadir $DATA_DIR removedb
}


$COMMAND
