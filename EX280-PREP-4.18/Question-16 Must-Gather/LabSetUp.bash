#!/bin/bash
echo "=== Lab Setup: Q16 Must-Gather ==="
oc whoami &>/dev/null || { echo "ERROR: Not logged in"; exit 1; }
echo "✅ No special setup needed. Run must-gather and archive the output."
