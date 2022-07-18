#!/bin/bash

set -euxo pipefail

# Install Requirements
apt-get update
apt-get install -y apt-transport-https ca-certificates curl

# Download the Google Cloud public signing key
curl -s https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | sudo apt-key add -

# Add K8s apt repository
echo "deb https://mirrors.aliyun.com/kubernetes/apt kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list

# Install
apt-get update
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl

# Install Kubernetes Images
images=(
    kube-apiserver:v1.24.3
    kube-controller-manager:v1.24.3
    kube-scheduler:v1.24.3
    kube-proxy:v1.24.3
    pause:3.7
    etcd:3.5.3-0
)

ALIYUN_ADDR=registry.cn-hangzhou.aliyuncs.com/google_containers

for image in ${images[@]}; do
    docker pull ${ALIYUN_ADDR}/$image
done

docker pull coredns/coredns:1.8.6
