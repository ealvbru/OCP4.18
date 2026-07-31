#!/bin/bash
cat << 'SOLUTION'
═══════════════════════════════════════════════════════════════════════════════
  SOLUTION: Q12 - Use Secret in Application
═══════════════════════════════════════════════════════════════════════════════

  oc project math
  oc set env deployment/monday --from=secret/magic

Verify:
  oc set env deployment/monday --list
  oc describe deployment monday | grep -A5 Environment

═══════════════════════════════════════════════════════════════════════════════
SOLUTION
