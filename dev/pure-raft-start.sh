#!/bin/bash
# e.g.
# ./raft-start.sh 4 YES 0
# count=$1
# permissioned=$2
# peerid=$3

set -u
set -e
source ./format.sh

start_raft(){

    node=$1
    nodiscover=$2
    permissioned=$3
    peerid=$4

    let k=1

    j="$(($node-$k))"

    NETWORK_ID=$(cat genesis.json | grep chainId | awk -F " " '{print $2}' | awk -F "," '{print $1}')
    ARGS=""

    if [ $NETWORK_ID -eq 1 ]
    then
	      echo "  Quorum should not be run with a chainId of 1 (Ethereum mainnet)"
        echo "  please set the chainId in the genensis.json to another value "
	      echo "  1337 is the recommend ChainId for Geth private clients."
    fi
    mkdir -p qdata/logs

    if [ "$nodiscover" == "YES" ]
    then
        ARGS+=" --nodiscover "
    fi

    if [ "$permissioned" == "YES" ]
    then
        ARGS+=" --permissioned "
    fi

    ARGS+=" --verbosity 5 --networkid $NETWORK_ID --raft --rpc --rpcaddr 0.0.0.0 --rpcapi admin,db,eth,debug,miner,net,shh,txpool,personal,web3,quorum,raft --rpccorsdomain=* --rpcvhosts=* --ws --wsaddr 0.0.0.0 --wsorigins=* --wsapi admin,db,eth,debug,miner,net,shh,txpool,personal,web3,quorum,raft --emitcheckpoints "

    if [ "$peerid" != "0" ]
    then
        ARGS+=" --raftjoinexisting $peerid "
    fi
    echo "PRIVATE_CONFIG=ignore nohup geth --datadir qdata/dd$node $ARGS --raftport 5040$node --wsport 2300$j --rpcport 2200$j --port 2100$j --unlock 0 --password passwords.txt 2>>qdata/logs/$node.log &"
    PRIVATE_CONFIG=ignore nohup geth --datadir qdata/dd$node $ARGS --raftport 5040$node --wsport 2300$j --rpcport 2200$j --port 2100$j --unlock 0 --password passwords.txt 2>>qdata/logs/$node.log &

}
###### main execution #######################################
# input total number of nodes to start (say 4), node is permissioned or not
count=$1
permissioned=$2
peerid=$3

if [ "$peerid" == "0" ]
then
    start=1
else
    start=$count
fi

# start the tessera nodes
# nohup ./tessera-start-node.sh --nodelow $start --nodehigh $count

# start the geth nodes
for i in $(seq "$start" "$count")
do
    echo "Starting geth node - $i"
    start_raft $i "YES" $permissioned $peerid
done
