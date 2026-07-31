#!/bin/bash
cat << 'SOLUTION'
═══════════════════════════════════════════════════════════════════════════════
  SOLUTION: Q4 - Configure Groups
═══════════════════════════════════════════════════════════════════════════════

  oc adm groups new commander
  oc adm groups new pilot
  oc adm groups add-users commander armstrong
  oc adm groups add-users pilot collins
  oc adm groups add-users pilot aldrin
  oc adm policy add-role-to-group edit commander -n apollo
  oc adm policy add-role-to-group view pilot -n apollo

Verify:
  oc get groups
  oc get rolebinding -n apollo

═══════════════════════════════════════════════════════════════════════════════
SOLUTION
