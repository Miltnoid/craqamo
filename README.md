Testing Instructions
====================
1. Start ZooKeeper Service

    $zookeeper-3.1.1/bin/zkServer.sh start

2. Setup port forwarding (with delay). `listen_port` is where the server node is actually listening to, 
and `external_port` is the port that clients and other servers should connect to. `delay_sec` can be
considered as the propagation time from one end of a channel to another in seconds.

    $ncat --sh-exec "ncat 127.0.0.1 [listen_port]" --listen [external_port] --keep-open --delay [delay_sec]

3. Start Chain Nodes

    $chain_node config/sample_chain_node0.cfg
    $chain_node config/sample_chain_node1.cfg
    .....

4. Run Tests from `test/` folder.


