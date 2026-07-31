#!/bin/bash
cat << 'SOLUTION'
═══════════════════════════════════════════════════════════════════════════════
  SOLUTION: Q3 - Configure Project Permissions
═══════════════════════════════════════════════════════════════════════════════

  oc adm policy add-role-to-user admin armstrong -n apollo
  oc adm policy add-role-to-user admin armstrong -n gemini
  oc adm policy add-role-to-user view wozniak -n titan

Verify:
  oc get rolebinding -n apollo | grep armstrong
  oc get rolebinding -n gemini | grep armstrong
  oc get rolebinding -n titan | grep wozniak

═══════════════════════════════════════════════════════════════════════════════
SOLUTION
