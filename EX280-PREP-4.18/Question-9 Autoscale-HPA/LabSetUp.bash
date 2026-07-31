#!/bin/bash
echo "=== Lab Setup: Q9 Autoscale HPA ==="
oc whoami &>/dev/null || { echo "ERROR: Not logged in"; exit 1; }
oc new-project lerna 2>/dev/null || oc project lerna
oc create deployment hydra --image=registry.ocp4.example.com:8443/redhattraining/hello-world-nginx:v1.0 -n lerna 2>/dev/null
echo "✅ Deployment 'hydra' created. Configure HPA and resource requests/limits."
