#!/bin/bash
echo "=== Lab Setup: Q19 NetworkPolicy ==="
oc whoami &>/dev/null || { echo "ERROR: Not logged in"; exit 1; }
oc new-project database 2>/dev/null || oc project database
oc create deployment mysql --image=registry.ocp4.example.com:8443/ubi9/ubi-minimal:latest -n database 2>/dev/null
oc label deployment mysql deployment=mysql -n database 2>/dev/null
echo "✅ Project 'database' with mysql deployment ready."
echo "   Create the NetworkPolicy to restrict ingress."
