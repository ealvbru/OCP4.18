#!/bin/bash
cat << 'SOLUTION'
═══════════════════════════════════════════════════════════════════════════════
  SOLUTION: Q10 - Secure Route (Edge TLS)
═══════════════════════════════════════════════════════════════════════════════

  oc project area51

  # Generate key and certificate
  openssl genrsa -out ex280.key 2048
  openssl req -new -key ex280.key -out ex280.csr \
    -subj "/C=US/ST=NV/L=Hiko/O=CIA/OU=USAF/CN=classified.apps.ocp4.example.com"
  openssl x509 -req -in ex280.csr -signkey ex280.key -out ex280.crt -days 365

  # Delete existing route if any
  oc delete route oxcart 2>/dev/null

  # Create edge route
  oc create route edge oxcart \
    --service=oxcart \
    --key=ex280.key \
    --cert=ex280.crt \
    --hostname=classified.apps.ocp4.example.com

Verify:
  oc get route oxcart
  curl -k https://classified.apps.ocp4.example.com

═══════════════════════════════════════════════════════════════════════════════
SOLUTION
