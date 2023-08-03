#!/bin/bash -e
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server" sh -s - --token token