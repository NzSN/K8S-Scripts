#!/bin/bash

set -euxo pipefail

WORKPATH=$(cd $(dirname $0); pwd)
BUILD_DIR=${WORKPATH}/build

if [ ! -d "./build" ]; then
    mkdir build
fi

cd $BUILD_DIR

# Install Containerd
if [ ! -f "containerd-1.6.6-linux-amd64.tar.gz" ]; then
    wget https://github.com/containerd/containerd/releases/download/v1.6.6/containerd-1.6.6-linux-amd64.tar.gz
fi
tar Cxzvf /usr/local containerd-1.6.6-linux-amd64.tar.gz
cp ${WORKPATH}/cfgs/containerd.service /etc/systemd/system/

# Install Runc
if [ ! -f "runc.amd64" ]; then
    wget https://github.com/opencontainers/runc/releases/download/v1.1.3/runc.amd64
fi
install -m 755 runc.amd64 /usr/local/sbin/runc

# Install CNI Plugins
if [ ! -f "cni-plugins-linux-amd64-v1.1.1.tgz" ]; then
    wget https://github.com/containernetworking/plugins/releases/download/v1.1.1/cni-plugins-linux-amd64-v1.1.1.tgz
fi
if [ ! -d "/opt/cni/bin" ]; then
    mkdir -p /opt/cni/bin
fi
tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.1.1.tgz

# Start containerd
if [ ! -d '/etc/containerd' ]; then
    mkdir /etc/containerd
fi

cp ${WORKPATH}/cfgs/config.toml /etc/containerd/config.toml

systemctl daemon-reload
systemctl enable --now containerd
systemctl start containerd

