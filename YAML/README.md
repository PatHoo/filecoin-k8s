## Apply YAML file
```
mkdir -p /home/file/go-fil/{tmp,lotus,lotusstorage}
cd filecoin-k8s/YAML
kubectl apply -f filecoin.yaml
```

## Get Logs
`kubectl logs filecoin-vd5w2 -c lotus-storage-miner -f` OR `kubectl attach filecoin-vd5w2 -c lotus-storage-miner`
```
2020-02-08T08:54:36.786Z        WARN    main    lotus-storage-miner/main.go:76  repo at '/home/file/go-fil/lotusstorage' is not initialized, run 'lotus-storage-miner init' to set it up:
2020-02-08T09:29:06.742Z        WARN    main    lotus-storage-miner/main.go:76  repo is already locked
2020-02-08T09:29:36.921Z        INFO    main    lotus-storage-miner/run.go:67   Checking full node sync status
2020-02-08T09:29:36.980Z        INFO    badger  v2@v2.0.1-rc1.0.20200120142413-c3333a5a830e/logger.go:46        All 1 tables opened in 0s
2020-02-08T09:32:46.729Z        WARN    deals   impl/provider_asks.go:86        no previous ask found, miner will not accept deals until a price is set
2020-02-08T09:32:46.800Z        WARN    modules modules/core.go:42      Generating new API secret
2020-02-08T09:32:46.810Z        INFO    storageminer    storage/miner.go:112    starting up miner t018934, worker addr t3rrjlody6ptkyljtlqomo7fszqs7uvgagukupmsbtvrxke4jq2ee7imw26rnff4jv7lcbeudxyoc7lbhy7y2q
2020-02-08T09:32:46.903Z        INFO    main    lotus-storage-miner/run.go:125  Remote version 0.2.7+git21a603ed+api0.1.6
2020-02-08T09:40:40.524Z        INFO    sectors sealing/garbage.go:39   Pledge 1, contains []
```

## Init miner via con
```
kubectl exec -it filecoin-vd5w2 -c lotus-storage-miner -- /bin/bash
root@filecoin-vd5w2:/# lotus wallet list
root@filecoin-vd5w2:/# lotus wallet new bls
t3rrjlody6ptkyljtlqomo7fszqs7uvgagukupmsbtvrxke4jq2ee7imw26rnff4jv7lcbeudxyoc7lbhy7y2q
root@filecoin-vd5w2:/# lotus wallet list
t3rrjlody6ptkyljtlqomo7fszqs7uvgagukupmsbtvrxke4jq2ee7imw26rnff4jv7lcbeudxyoc7lbhy7y2q

With your wallet address:
Visit the faucet
Click "Create Miner"

lotus-storage-miner init --actor=ACTOR_VALUE_RECEIVED --owner=OWNER_VALUE_RECEIVED

root@filecoin-vd5w2:/# lotus-storage-miner init --actor=t018912 --owner=t3rrjlody6ptkyljtlqomo7fszqs7uvgagukupmsbtvrxke4jq2ee7imw26rnff4jv7lcbeudxyoc7lbhy7y2q
root@filecoin-vd5w2:/# lotus-storage-miner pledge-sector
```

NOTE: You don't need to execute `lotus-storage-miner run` command, it will run automatically itself, see the logs. 
