#!/bin/bash
echo "=== Lab Setup: Q17 Liveness Probe ==="
oc whoami &>/dev/null || { echo "ERROR: Not logged in"; exit 1; }
oc new-project probes 2>/dev/null || oc project probes
oc create deployment probe-app --image=registry.ocp4.example.com:8443/redhattraining/hello-world-nginx:v1.0 -n probes 2>/dev/null
echo "✅ Deployment 'probe-app' created. Add a liveness probe."
