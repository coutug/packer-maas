#!/bin/bash +x

INSTALL_K3S_EXEC="agent --server https://10.220.118.2:6443 --token K10368065757c24fb40107267dbdc19e27930ea4d6a6840862bd8d1e63c6c02e73b::server:810e237c186dbdbe321d3d9d56d0c338"

/usr/local/bin/k3s $INSTALL_K3S_EXEC