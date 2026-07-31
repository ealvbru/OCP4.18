#!/bin/bash
echo "=== Lab Setup: Q6 LimitRange ==="
oc whoami &>/dev/null || { echo "ERROR: Not logged in"; exit 1; }
oc get project bluebook &>/dev/null || oc new-project bluebook
echo "✅ Project bluebook ready. Proceed with LimitRange creation."
