#!/bin/bash
cat << 'SOLUTION'
═══════════════════════════════════════════════════════════════════════════════
  SOLUTION: Q9 - Autoscale Application (HPA)
═══════════════════════════════════════════════════════════════════════════════

  oc project lerna

  # Set resource requests and limits
  oc set resources deployment hydra \
    --requests=cpu=25m --limits=cpu=100m

  # Create HPA
  oc autoscale deployment hydra --min=6 --max=9 --cpu-percent=60

Verify:
  oc get hpa
  oc describe hpa hydra
  oc describe deployment hydra | grep -A3 Limits

═══════════════════════════════════════════════════════════════════════════════
SOLUTION
