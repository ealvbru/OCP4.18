#!/bin/bash
echo "=== Lab Setup: Q12 Use Secret ==="
oc whoami &>/dev/null || { echo "ERROR: Not logged in"; exit 1; }
oc project math 2>/dev/null || oc new-project math
oc create deployment monday --image=registry.ocp4.example.com:8443/ubi9/ubi-minimal:latest -n math 2>/dev/null
echo "✅ Deployment 'monday' created. Inject the 'magic' secret as env vars."
