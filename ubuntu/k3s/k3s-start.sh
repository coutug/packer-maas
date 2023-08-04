#!/bin/bash +x

K3S_URL="https://10.220.118.7:6443"
K3S_TOKEN="token"
INSTALL_K3S_EXEC="agent"



/usr/local/bin/k3s $K3S_URL $K3S_TOKEN $INSTALL_K3S_EXEC