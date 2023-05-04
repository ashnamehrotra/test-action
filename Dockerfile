FROM ubuntu:latest

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Copy all trivy report data
COPY *.json /data/

# Mount data volume
VOLUME /data

# Install required packages
RUN apt-get update && \
    apt-get install -y wget tar runc sudo systemd

# Install Copa
RUN wget https://github.com/project-copacetic/copacetic/releases/download/v0.2.0/copa_0.2.0_linux_amd64.tar.gz && \
    tar -zxvf copa_0.2.0_linux_amd64.tar.gz && \
    cp copa /usr/local/bin/

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
