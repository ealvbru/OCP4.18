#!/bin/bash
echo "=== Lab Setup: Q13 Service Account SCC ==="
oc whoami &>/dev/null || { echo "ERROR: Not logged in"; exit 1; }
oc new-project apples 2>/dev/null || oc project apples
echo "✅ Project 'apples' ready. Create the service account and assign SCC."
