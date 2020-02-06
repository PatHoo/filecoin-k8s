FROM lotus:hkc as builder
LABEL maintainer="PatHoo <QuInfoTP@gmail.com>"  description="Use multi-stage builds"

FROM ubuntu:hkc
LABEL maintainer="PatHoo <QuInfoTP@gmail.com>"  description="Use multi-stage builds"
COPY --from=builder /data/lotus /data/lotus-storage-miner /data/lotus-seal-worker  /usr/bin/

# Command to run the executable
#CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
#CMD exec /bin/sh -c "trap : TERM INT; (while true; do sleep 1000; done) & wait"

