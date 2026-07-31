#!/bin/bash
cat << 'SOLUTION'
═══════════════════════════════════════════════════════════════════════════════
  SOLUTION: Q21 - Project Template
═══════════════════════════════════════════════════════════════════════════════

  # Generate the default template
  oc adm create-bootstrap-project-template -o yaml > template.yaml

  # (Optional) Edit template.yaml to add custom resources like
  # NetworkPolicies, LimitRanges, etc.

  # Create the template in openshift-config
  oc create -f template.yaml -n openshift-config

  # Configure the cluster to use it
  oc edit project.config.openshift.io/cluster

  # Add under spec:
  spec:
    projectRequestTemplate:
      name: project-request

  # Validate by creating a new project
  oc new-project test-template
  oc get project test-template -o yaml

═══════════════════════════════════════════════════════════════════════════════
SOLUTION
