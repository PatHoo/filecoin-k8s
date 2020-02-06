# filecoin-k8s
Deply Lotus via K8S platform. It's not product ready, just Develop environment.

# SealOS
[SealOS](https://github.com/fanux/sealos) is a K8S deply tool. See [official site](https://sealyun.com).

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

