#!/bin/bash
cat << 'SOLUTION'
═══════════════════════════════════════════════════════════════════════════════
  SOLUTION: Q5 - Configure Resource Quotas
═══════════════════════════════════════════════════════════════════════════════

  oc project manhattan
  oc create quota ex280-quota \
    --hard=memory=1Gi,cpu=2,pods=3,services=6,replicationcontrollers=3

Verify:
  oc get resourcequota -n manhattan
  oc describe quota ex280-quota -n manhattan

═══════════════════════════════════════════════════════════════════════════════
SOLUTION
