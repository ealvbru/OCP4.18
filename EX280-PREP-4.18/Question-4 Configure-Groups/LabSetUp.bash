#!/bin/bash
echo "=== Lab Setup: Q4 Configure Groups ==="
oc whoami &>/dev/null || { echo "ERROR: Not logged in"; exit 1; }
oc get project apollo &>/dev/null || oc new-project apollo
echo "✅ Lab setup complete. Proceed with group creation and role bindings."
