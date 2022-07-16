#!/bin/bash

set -euxo pipefail

BASH=$(which bash)

# Prerequisites
$BASH ./Settings.sh

# Install CRI
$BASH ./CRI-Install.sh

# Install Kubeadm
$BASH ./Kubeadm-Install.sh
