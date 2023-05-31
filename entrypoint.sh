#!/bin/sh -l
 
# delimiter for trivy json reports
IFS=','

# sudo builkitd
# docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Ports}}"

# Install Docker CLI
apt-get update
apt-get install -y docker.io

# Start buildkitd container
docker network create mynetwork
docker run --detach --rm --privileged -p 127.0.0.1:8888:8888 --network=mynetwork --name buildkitd --entrypoint buildkitd moby/buildkit:v0.11.4 --addr tcp://0.0.0.0:8888

for img in $1
do
    echo $img
    # hardcoded for now, change to image name & image report
    copa patch -i mcr.microsoft.com/oss/nginx/nginx:1.21.6 -r /data/nginx.1.21.6.json -t patched --addr tcp://0.0.0.0:8888 #"$2"
done
