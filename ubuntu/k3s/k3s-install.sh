#!/bin/bash
set -ex

export HOME=/root
export DEBIAN_FRONTEND=noninteractive
export INSTALL_K3S_SKIP_START=true

systemctl stop unattended-upgrades
apt-get -y purge unattended-upgrades

apt-get update
apt-get -y install \
    git curl wget \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    conntrack \
    jq vim nano emacs joe \
    inotify-tools \
    socat make golang-go \
    unzip \
    bash-completion \
    dnsutils \
    iputils-ping

curl -sfL https://get.k3s.io | sh -

mkdir -p /root/.kube
ln -sf /etc/rancher/k3s/k3s.yaml /root/.kube/config