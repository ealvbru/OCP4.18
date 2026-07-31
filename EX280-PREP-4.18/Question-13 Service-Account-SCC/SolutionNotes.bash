#!/bin/bash
cat << 'SOLUTION'
═══════════════════════════════════════════════════════════════════════════════
  SOLUTION: Q13 - Service Account with SCC
═══════════════════════════════════════════════════════════════════════════════

  oc project apples
  oc create sa ex280sa
  oc adm policy add-scc-to-user anyuid -z ex280sa -n apples

Verify:
  oc get sa ex280sa -n apples
  oc adm policy who-can use scc anyuid | grep ex280sa

═══════════════════════════════════════════════════════════════════════════════
SOLUTION
