#!/bin/bash
cat << 'SOLUTION'
═══════════════════════════════════════════════════════════════════════════════
  SOLUTION: Q15 - Install Helm Chart
═══════════════════════════════════════════════════════════════════════════════

  # Add the repository
  helm repo add do280-repo http://helm.ocp4.example.com/charts

  # Update repos
  helm repo update

  # Install the chart
  helm install example-app do280-repo/etherpad

Verify:
  helm list
  oc get all

═══════════════════════════════════════════════════════════════════════════════
SOLUTION
