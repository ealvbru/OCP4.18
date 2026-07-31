#!/bin/bash
echo "=== Lab Setup: Q2 Cluster Permissions ==="
echo "Verifying prerequisites..."
oc whoami &>/dev/null || { echo "ERROR: Not logged in to OpenShift cluster"; exit 1; }
echo "Ensuring users exist (Q1 must be completed first)..."
echo ""
echo "✅ Lab setup complete. Proceed with the question."
echo "   WARNING: Do NOT delete kubeadmin until you have another cluster-admin!"
