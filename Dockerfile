FROM debian:sid-slim

ENV LANG=en_US.UTF-8 \
    # adding a sane default is needed since we're not erroring out via exec.
     CODER_PASSWORD="coder"

#Change this via --arg in Docker CLI
ARG CODER_VERSION=1.1156-vsc1.33.1

COPY exec /opt

RUN apt-get update && \
    apt-get install -y  \
      sudo \
      openssl \
      net-tools \
      git \
      locales \
      curl \
      dumb-init \
      nodejs \
      npm \
      wget && \
    locale-gen en_US.UTF-8 && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    cd /tmp && \
    wget -O - https://github.com/codercom/code-server/releases/download/${CODER_VERSION}/code-server${CODER_VERSION}-linux-x64.tar.gz | tar -xzv && \
    chmod -R 755 code-server${CODER_VERSION}-linux-x64/code-server && \
    mv code-server${CODER_VERSION}-linux-x64/code-server /usr/bin/ && \
    rm -rf code-server-${CODER_VERSION}-linux-x64 && mkdir -p /home/coder

RUN sudo apt-get update && sudo apt-get install -y apt-transport-https && \
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - && \
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list && \
sudo apt-get update && \
sudo apt-get install -y kubectl


WORKDIR /home/coder

RUN mkdir -p projects && mkdir -p certs && \
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash && \
    sudo chmod -R g+rw projects/ && \
    sudo chmod -R g+rw certs/ && \
    sudo chmod -R g+rw .nvm;

COPY entrypoint /home/coder

VOLUME ["/home/coder/projects", "/home/coder/certs"];


ENTRYPOINT ["/home/coder/entrypoint"]

EXPOSE 9000

CMD ["/opt/exec"]
