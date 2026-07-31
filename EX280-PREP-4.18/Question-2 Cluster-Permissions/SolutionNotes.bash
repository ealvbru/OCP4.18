#!/bin/bash
cat << 'SOLUTION'
═══════════════════════════════════════════════════════════════════════════════
  SOLUTION: Q2 - Configure Cluster Permissions
═══════════════════════════════════════════════════════════════════════════════

Step 1: Grant cluster-admin to jobs
─────────────────────────────────────
  oc adm policy add-cluster-role-to-user cluster-admin jobs

Step 2: Remove self-provisioner from all authenticated users
─────────────────────────────────────────────────────────────
  oc adm policy remove-cluster-role-from-group self-provisioner \
    system:authenticated:oauth

Step 3: Grant self-provisioner to wozniak only
───────────────────────────────────────────────
  oc adm policy add-cluster-role-to-user self-provisioner wozniak

Step 4: Delete kubeadmin secret (CAUTION!)
───────────────────────────────────────────
  oc delete secret kubeadmin -n kube-system

Step 5: Verify
───────────────
  oc login -u jobs -p sestiver
  oc get nodes  # Should work (cluster-admin)

  oc login -u wozniak -p glegunge
  oc new-project test-wozniak  # Should work
  oc delete project test-wozniak

  oc login -u armstrong -p indionce
  oc new-project test-armstrong  # Should FAIL

═══════════════════════════════════════════════════════════════════════════════
SOLUTION
