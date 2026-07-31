#!/bin/bash
echo "=== Lab Setup: Q8 Manual Scale ==="
oc whoami &>/dev/null || { echo "ERROR: Not logged in"; exit 1; }
oc new-project gru 2>/dev/null || oc project gru
oc create deployment minion --image=registry.ocp4.example.com:8443/redhattraining/hello-world-nginx:v1.0 -n gru 2>/dev/null
echo "✅ Deployment 'minion' created in project 'gru'. Scale it to 5 replicas."
