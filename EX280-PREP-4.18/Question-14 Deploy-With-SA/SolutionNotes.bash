#!/bin/bash
cat << 'SOLUTION'
═══════════════════════════════════════════════════════════════════════════════
  SOLUTION: Q14 - Deploy with Service Account
═══════════════════════════════════════════════════════════════════════════════

  oc project apples
  oc set serviceaccount deployment/oranges ex280sa

Verify:
  oc get deployment oranges -o yaml | grep serviceAccountName
  oc get pods -l app=oranges

═══════════════════════════════════════════════════════════════════════════════
SOLUTION
