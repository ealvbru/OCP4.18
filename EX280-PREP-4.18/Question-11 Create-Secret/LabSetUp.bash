#!/bin/bash
echo "=== Lab Setup: Q11 Create Secret ==="
oc whoami &>/dev/null || { echo "ERROR: Not logged in"; exit 1; }
oc new-project math 2>/dev/null || oc project math
echo "✅ Project 'math' ready. Create the secret."
