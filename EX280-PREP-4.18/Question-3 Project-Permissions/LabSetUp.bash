#!/bin/bash
echo "=== Lab Setup: Q3 Project Permissions ==="
oc whoami &>/dev/null || { echo "ERROR: Not logged in"; exit 1; }
echo "Creating required projects..."
for p in apollo manhattan gemini bluebook titan; do
  oc new-project $p 2>/dev/null || oc project $p 2>/dev/null
done
echo "✅ Projects created. Proceed with role bindings."
