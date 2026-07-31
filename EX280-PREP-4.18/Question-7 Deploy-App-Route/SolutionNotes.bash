#!/bin/bash
cat << 'SOLUTION'
═══════════════════════════════════════════════════════════════════════════════
  SOLUTION: Q7 - Deploy Application with Route
═══════════════════════════════════════════════════════════════════════════════

  oc project bullwinkle

  # Check if pods are running
  oc get pods

  # If pods are Pending, check for taints
  oc describe nodes | grep -i taint
  # Remove problematic taints if needed:
  # oc adm taint nodes <node> key1=value1:NoSchedule-

  # Delete existing route if wrong
  oc delete route rocky 2>/dev/null

  # Create route with correct hostname
  oc expose svc rocky --hostname=rocky.apps.ocp4.example.com

  # Verify
  oc get route
  curl http://rocky.apps.ocp4.example.com

═══════════════════════════════════════════════════════════════════════════════
SOLUTION
