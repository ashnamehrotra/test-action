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

# Install Docker for Buildkit Container
RUN apt-get install -y \
    ca-certificates \
    curl \
    gnupg

RUN install -m 0755 -d /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
RUN chmod a+r /etc/apt/keyrings/docker.gpg

RUN echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt-get update
RUN apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Install Copa
RUN wget https://github.com/project-copacetic/copacetic/releases/download/v0.2.0/copa_0.2.0_linux_amd64.tar.gz && \
    tar -zxvf copa_0.2.0_linux_amd64.tar.gz && \
    cp copa /usr/local/bin/



# Install Buildkit
RUN mkdir /temp && \
    wget https://github.com/moby/buildkit/releases/download/v0.11.6/buildkit-v0.11.6.linux-amd64.tar.gz && \
    tar -zxvf buildkit-v0.11.6.linux-amd64.tar.gz -C temp && \
    mv /temp/bin/buildkitd /buildkitd && \
    cp -r /buildkitd /usr/local/bin/ &&  \
    mv /temp/bin/buildkit-runc /buildkit-runc && \
    cp -r /buildkit-runc /usr/local/bin/


# OR

# Run Buildkit in a container, docker sock isnt working?
RUN systemctl start docker 
RUN systemctl status docker
RUN docker run --detach --rm --privileged -p 127.0.0.1:8888:8888/tcp --name buildkitd --entrypoint buildkitd moby/buildkit:v0.11.4 --addr tcp://0.0.0.0:8888
# -v /var/run/docker.sock:/var/run/docker.sock

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
