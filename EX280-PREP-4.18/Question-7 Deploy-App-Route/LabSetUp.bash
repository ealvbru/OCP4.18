#!/bin/bash
echo "=== Lab Setup: Q7 Deploy App with Route ==="
oc whoami &>/dev/null || { echo "ERROR: Not logged in"; exit 1; }
oc new-project bullwinkle 2>/dev/null || oc project bullwinkle
echo "Creating deployment rocky..."
oc create deployment rocky --image=registry.ocp4.example.com:8443/redhattraining/hello-world-nginx:v1.0 -n bullwinkle 2>/dev/null
oc expose deployment rocky --port=8080 -n bullwinkle 2>/dev/null
echo "✅ Deployment and service created. You need to create/fix the route."
echo "   The app should be reachable at: http://rocky.apps.ocp4.example.com"
