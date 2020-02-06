FROM lotus:hkc as builder
LABEL maintainer="PatHoo <QuInfoTP@gmail.com>"  description="Use multi-stage builds"

FROM ubuntu:18.04
LABEL maintainer="PatHoo <QuInfoTP@gmail.com>"  description="Use multi-stage builds"
RUN ln -sf /bin/bash /bin/sh
RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    apt-get update && \
    add-apt-repository -y ppa:longsleep/golang-backports && \
    apt-get update && \
    apt-get install -y mesa-opencl-icd ocl-icd-opencl-dev && \
    apt-get install -y vim git curl wget tree zfsutils iproute2 net-tools ethtool ipvsadm

COPY --from=builder /data/lotus /data/lotus-storage-miner /data/lotus-seal-worker  /usr/bin/

# Command to run the executable
#CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
#CMD exec /bin/sh -c "trap : TERM INT; (while true; do sleep 1000; done) & wait"

