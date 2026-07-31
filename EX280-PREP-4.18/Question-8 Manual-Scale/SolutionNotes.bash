#!/bin/bash
cat << 'SOLUTION'
═══════════════════════════════════════════════════════════════════════════════
  SOLUTION: Q8 - Scale Application Manually
═══════════════════════════════════════════════════════════════════════════════

  oc project gru
  oc scale deployment minion --replicas=5

Verify:
  oc get deployment minion
  oc get pods -l app=minion

═══════════════════════════════════════════════════════════════════════════════
SOLUTION
