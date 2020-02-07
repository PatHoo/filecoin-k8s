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

watch du -sh /home/file/go-fil/lotus/datastore/*.vlog

kubectl get pod -o wide -w|grep filecoin
kubectl get pod -o wide|grep filecoin|awk '{printf "%-20s%s\n",$1,$7}'

kubectl attach pod POD_NAME -c lotus-storage-miner
kubectl exec -it POD_NAME -c lotus-storage-miner -- /bin/bash
kubectl exec -it POD_NAME -c lotus-storage-miner -- watch lotus sync status

#kubectl delete pod POD_NAME --grace-period=0 --force
#kubectl get pod POD_NAME -o yaml | kubectl replace --force -f -

for pod in $(kubectl get pod -o wide|grep filecoin|awk '{print $1}')
do
  echo $pod
  kubectl exec -it $pod -c lotus-storage-miner -- lotus sync status|grep -E "Stage:"
  echo "======================================================================"
done

for pod in $(kubectl get pod -o wide|grep filecoin|awk '{print $1}')
do
  echo $pod
  kubectl exec -it $pod -c lotus-storage-miner -- lotus sync status|grep -A 6 0:|grep -E "Stage:|Height:"
  echo "======================================================================"
done

```

