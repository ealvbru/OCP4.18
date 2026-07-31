#!/bin/bash
echo "=== Lab Setup: Q5 Resource Quota ==="
oc whoami &>/dev/null || { echo "ERROR: Not logged in"; exit 1; }
oc get project manhattan &>/dev/null || oc new-project manhattan
echo "✅ Project manhattan ready. Proceed with quota creation."
