PRIVATE_CONFIG=ignore nohup geth --datadir qdata --verbosity 5 --networkid 10 --raft --rpc --rpcaddr 0.0.0.0 --rpcapi admin,db,eth,debug,miner,net,shh,txpool,personal,web3,quorum,raft --rpccorsdomain=* --rpcvhosts=* --ws --wsaddr 0.0.0.0 --wsorigins=* --wsapi admin,db,eth,debug,miner,net,shh,txpool,personal,web3,quorum,raft --emitcheckpoints --raftport 11111 --wsport 63000 --rpcport 62000 --port 61000 --unlock 0 --password /dev/null 2>>qdata/node.log &

echo "PRIVATE_CONFIG=ignore nohup geth --datadir qdata --verbosity 5 --networkid 10 --raft --rpc --rpcaddr 0.0.0.0 --rpcapi admin,db,eth,debug,miner,net,shh,txpool,personal,web3,quorum,raft --rpccorsdomain=* --rpcvhosts=* --ws --wsaddr 0.0.0.0 --wsorigins=* --wsapi admin,db,eth,debug,miner,net,shh,txpool,personal,web3,quorum,raft --emitcheckpoints --raftport 11111 --wsport 63000 --rpcport 62000 --port 61000 --unlock 0 --password /dev/null 2>>qdata/node.log &"
