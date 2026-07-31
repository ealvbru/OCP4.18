#!/bin/bash
echo "=== Lab Setup: Q15 Helm Chart ==="
oc whoami &>/dev/null || { echo "ERROR: Not logged in"; exit 1; }
which helm &>/dev/null || { echo "Installing helm..."; curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash; }
echo "✅ Helm is available. Add the repo and install the chart."
