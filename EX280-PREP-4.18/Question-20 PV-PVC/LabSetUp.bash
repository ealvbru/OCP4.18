#!/bin/bash
echo "=== Lab Setup: Q20 PV and PVC ==="
oc whoami &>/dev/null || { echo "ERROR: Not logged in"; exit 1; }
echo "✅ No special setup needed. Create the PV and PVC YAML files."
