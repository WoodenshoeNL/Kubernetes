#!/bin/bash

sudo kubeadm join 10.11.0.4:6443 \
    --token 50405s.rh37yvsmp7nn7znk \
    --discovery-token-ca-cert-hash sha256:65d3f1b3400fab19359bb718fd9562a82582f5786f0398540d2ff73e9b43cd37

