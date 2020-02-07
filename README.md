# filecoin-k8s
Deply Lotus via K8S platform. It's not product ready, just Develop environment.

# SealOS
[SealOS](https://github.com/fanux/sealos) is a K8S deploy tool. See [official site](https://sealyun.com).

## Build a production kubernetes HA cluster.
- A pure Golang project which is in rapid development.
- Every node config a ipvs proxy for masters LB, so we needn't haproxy or keepalived any more.
- Then run [lvscare](https://github.com/fanux/lvscare) as a staic pod to check apiserver is aviliable. The file: `/etc/kubernetes/manifests/sealyun-lvscare.yaml`
- If any master is down, lvscare will remove the ipvs realserver, when master recover it will add it back.
- SealOS will send package and apply install commands, so we needn't ansible.

### Get SealOS:
```
wget -c https://github.com/fanux/sealos/releases/download/v3.1.0/sealos && \
    chmod +x sealos && mv sealos /usr/bin
```
### Multi master HA:
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

cd lotus
docker build -f Dockerfile-init -t lotus:hkc --network host  .
docker build -f Dockerfile-hkc -t ubuntu:hkc  .
docker build -f Dockerfile -t filecoin  .

<!-- Harbor -->
#Harbor HA and Ingress and so on.
docker tag filecoin 116.31.96.131/library/filecoin:latest
docker push 116.31.96.131/library/filecoin:latest
docker pull 116.31.96.131/library/filecoin:latest

mkdir -p /home/file/go-fil/{tmp,lotus,lotusstorage}
cd ../filecoin-k8s/YAML
kubectl apply -f filecoin.yaml
```
