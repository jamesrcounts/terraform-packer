#!/usr/bin/env bash
set -euox pipefail

apt-get update && \
    apt-get install software-properties-common
    
curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
apt-get update && \
    apt-get install packer
