#!/bin/bash
echo "=== Lab Setup: Q21 Project Template ==="
oc whoami &>/dev/null || { echo "ERROR: Not logged in"; exit 1; }
echo "✅ No special setup needed."
echo "   Generate the bootstrap template, create it, and configure the cluster."
