# filecoin-k8s
Deply Lotus via K8S platform. It's not product ready, just Develop environment.

# SealOS
[SealOS](https://github.com/fanux/sealos) is a K8S deply tool. See [official site](https://sealyun.com).
```
wget https://github.com/fanux/sealos/releases/download/v3.1.0-alpha.4/sealos && \
    chmod +x sealos && mv sealos /usr/bin
```
```
sealos init --passwd 123 \
  --master 116.31.96.131 --master 116.31.96.141 --master 116.31.96.151 \
  --node 116.31.96.158 --node 116.31.96.175 --nodes 116.31.96.177-116.31.96.179 \
  --vip 10.10.10.10 \
  --podcidr 10.63.0.0/10 \
  --svccidr 11.96.0.0/12 \
  --network calico \
  --apiserver apiserver.cluster.devops \
  --pkg-url https://sealyun.oss-cn-beijing.aliyuncs.com/413bd3624b2fb9e466601594b4f72072-1.17.0/kube1.17.0.tar.gz \
  --version v1.17.0 \
;
```

# Build Images
```
git clone https://github.com/filecoin-project/lotus.git
cd lotus
git pull origin master

cd ..
git clone https://github.com/PatHoo/filecoin-k8s.git
cp filecoin-k8s/Lotus/Dockerfile* lotus/

docker build -f Dockerfile-init -t lotus:hkc --network host  .
docker build -f Dockerfile-hkc -t ubuntu:hkc  .
docker build -f Dockerfile -t filecoin  .

<!-- Harbor -->
docker tag filecoin 116.31.96.131/library/filecoin:latest
docker push 116.31.96.131/library/filecoin:latest
docker pull 116.31.96.131/library/filecoin:latest

mkdir -p /home/file/go-fil/{tmp,lotus,lotusstorage}
cd filecoin-k8s/YAML
kubectl apply -f filecoin.yaml
```

