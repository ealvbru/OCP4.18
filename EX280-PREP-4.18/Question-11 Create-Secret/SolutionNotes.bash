#!/bin/bash
cat << 'SOLUTION'
═══════════════════════════════════════════════════════════════════════════════
  SOLUTION: Q11 - Create Secret
═══════════════════════════════════════════════════════════════════════════════

  oc project math
  oc create secret generic magic \
    --from-literal=MYSQL_ROOT_PASSWORD=redhat

Verify:
  oc get secret magic -n math
  oc describe secret magic -n math

═══════════════════════════════════════════════════════════════════════════════
SOLUTION
