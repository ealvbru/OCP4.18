#!/bin/bash
cat << 'SOLUTION'
═══════════════════════════════════════════════════════════════════════════════
  SOLUTION: Q19 - NetworkPolicy
═══════════════════════════════════════════════════════════════════════════════

Create mysql-db-conn.yaml:

apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: mysql-db-conn
  namespace: database
spec:
  podSelector:
    matchLabels:
      deployment: mysql
  policyTypes:
  - Ingress
  ingress:
  - from:
    - namespaceSelector:
        matchLabels:
          team: devsecops
      podSelector:
        matchLabels:
          deployment: my-web-mysql
    ports:
    - protocol: TCP
      port: 3306

Apply:
  oc apply -f mysql-db-conn.yaml

Verify:
  oc get networkpolicy -n database
  oc describe networkpolicy mysql-db-conn -n database

═══════════════════════════════════════════════════════════════════════════════
SOLUTION
