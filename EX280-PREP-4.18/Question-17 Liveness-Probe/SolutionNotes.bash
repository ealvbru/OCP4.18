#!/bin/bash
cat << 'SOLUTION'
═══════════════════════════════════════════════════════════════════════════════
  SOLUTION: Q17 - Liveness Probe
═══════════════════════════════════════════════════════════════════════════════

  oc project probes

  oc set probe deployment/probe-app --liveness \
    --get-url=http://:8080/ \
    --initial-delay-seconds=10 \
    --period-seconds=30

Verify:
  oc describe deployment probe-app | grep -A10 Liveness
  oc get pods -l app=probe-app

═══════════════════════════════════════════════════════════════════════════════
SOLUTION
