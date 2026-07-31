#!/bin/bash
echo "=== Lab Setup: Q10 Secure Route ==="
oc whoami &>/dev/null || { echo "ERROR: Not logged in"; exit 1; }
oc new-project area51 2>/dev/null || oc project area51
oc create deployment oxcart --image=registry.ocp4.example.com:8443/redhattraining/hello-world-nginx:v1.0 -n area51 2>/dev/null
oc expose deployment oxcart --port=8080 -n area51 2>/dev/null
echo "✅ Deployment and service 'oxcart' created."
echo "   Generate a TLS certificate and create a secure edge route."
