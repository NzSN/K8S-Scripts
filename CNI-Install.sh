#!/bin/bash

set -euxo pipefail

mkdir -p /opt/bin

if [ ! -f "/opt/bin/flanneld" ]; then
    wget https://github.com/flannel-io/flannel/releases/download/v0.18.1/flanneld-amd64 -O /opt/bin/flanneld
fi

