#!/bin/bash
echo "=== Lab Setup: Q1 HTPasswd Identity Provider ==="
echo "Verifying prerequisites..."
oc whoami &>/dev/null || { echo "ERROR: Not logged in to OpenShift cluster"; exit 1; }
echo "Installing httpd-tools for htpasswd command..."
sudo yum install -y httpd-tools &>/dev/null || sudo dnf install -y httpd-tools &>/dev/null
echo ""
echo "✅ Lab setup complete. You may now proceed with the question."
echo "   Hint: Use 'htpasswd' to create the password file, then create a secret."
