FROM golang:latest
ARG KIND_VERSION='v0.9.0'
ARG HELM_VERSION='v3.4.0'
ARG TANKA_VERSION='v0.12.0'
ARG JSONNET_VERSION='v0.16.0'
ARG JSONNET_BUNDLER_VERSION='v0.4.0'
ARG DOCKER_VERSION='19.03.13'
ARG YQ_VERSION='3.4.0'
RUN apt update && apt install -y jq less
RUN GO111MODULE="on" go get "sigs.k8s.io/kind@${KIND_VERSION}"
RUN curl -fLO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" && chmod +x kubectl && mv kubectl /usr/local/bin
RUN curl -fLO "https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz" && tar -zxvf "helm-${HELM_VERSION}-linux-amd64.tar.gz" && mv linux-amd64/helm /usr/local/bin
RUN GO111MODULE="on" go get "github.com/grafana/tanka/cmd/tk@${TANKA_VERSION}"
RUN curl -fLO "https://github.com/google/jsonnet/releases/download/v0.16.0/jsonnet-bin-${JSONNET_VERSION}-linux.tar.gz" \
 && tar -xvf "jsonnet-bin-${JSONNET_VERSION}-linux.tar.gz" \
 && mv jsonnet jsonnetfmt /usr/local/bin
RUN curl -fLO "https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz" \
 && tar -xvf "docker-${DOCKER_VERSION}.tgz" \
 && cp docker/docker /usr/local/bin \
 && rm -rf docker
RUN curl -fLo /usr/local/bin/jb "https://github.com/jsonnet-bundler/jsonnet-bundler/releases/download/${JSONNET_BUNDLER_VERSION}/jb-linux-amd64" && chmod +x /usr/local/bin/jb
RUN curl -fLo /usr/local/bin/yq "https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64" && chmod +x /usr/local/bin/yq
COPY entrypoint.sh Dockerfile /
ENTRYPOINT /entrypoint.sh
RUN echo 'export PS1="\u@tanka:\w\$ "' >> /etc/bash.bashrc
