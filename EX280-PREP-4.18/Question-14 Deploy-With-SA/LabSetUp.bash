#!/bin/bash
echo "=== Lab Setup: Q14 Deploy with Service Account ==="
oc whoami &>/dev/null || { echo "ERROR: Not logged in"; exit 1; }
oc project apples 2>/dev/null || oc new-project apples
oc create deployment oranges --image=registry.ocp4.example.com:8443/ubi9/ubi-minimal:latest -n apples 2>/dev/null
echo "✅ Deployment 'oranges' created (may fail due to SCC)."
echo "   Set it to use the 'ex280sa' service account."
