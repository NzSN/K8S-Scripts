#!/bin/bash

set -euxo pipefail

BASH=$(which bash)

# Prerequisites
$BASH ./Settings.sh

# Install CRI
$BASH ./CRI-Install.sh

# Install Kubeadm
$BASH ./Kubeadm-Install.sh

# Install CNI-Plugins
mkdir -p /opt/bin
if [ ! -f "/opt/bin/flanneld" ]; then
    wget https://github.com/flannel-io/flannel/releases/download/v0.18.1/flanneld-amd64 -O /opt/bin/flanneld
fi
