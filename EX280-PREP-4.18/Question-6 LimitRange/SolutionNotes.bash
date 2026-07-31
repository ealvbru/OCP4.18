#!/bin/bash
cat << 'SOLUTION'
═══════════════════════════════════════════════════════════════════════════════
  SOLUTION: Q6 - Configure LimitRange
═══════════════════════════════════════════════════════════════════════════════

Create a file limitrange.yaml:

apiVersion: v1
kind: LimitRange
metadata:
  name: ex280-limits
  namespace: bluebook
spec:
  limits:
  - type: Pod
    max:
      cpu: "500m"
      memory: "300Mi"
    min:
      cpu: "10m"
      memory: "5Mi"
  - type: Container
    max:
      cpu: "500m"
      memory: "300Mi"
    min:
      cpu: "10m"
      memory: "5Mi"
    defaultRequest:
      cpu: "100m"
      memory: "100Mi"

Apply:
  oc apply -f limitrange.yaml

Verify:
  oc describe limitrange ex280-limits -n bluebook

═══════════════════════════════════════════════════════════════════════════════
SOLUTION
