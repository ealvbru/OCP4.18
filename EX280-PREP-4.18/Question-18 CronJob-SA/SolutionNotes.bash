#!/bin/bash
cat << 'SOLUTION'
═══════════════════════════════════════════════════════════════════════════════
  SOLUTION: Q18 - CronJob with Service Account
═══════════════════════════════════════════════════════════════════════════════

  oc project scheduled

  # Create service account
  oc create sa jupiter

  # Grant anyuid SCC
  oc adm policy add-scc-to-user anyuid -z jupiter -n scheduled

  # Grant cluster-admin
  oc adm policy add-cluster-role-to-user cluster-admin \
    system:serviceaccount:scheduled:jupiter

  # Patch CronJob to use the SA
  oc patch cronjob cron-test -p \
    '{"spec":{"jobTemplate":{"spec":{"template":{"spec":{"serviceAccountName":"jupiter"}}}}}}'

Verify:
  oc get cronjob cron-test -o yaml | grep serviceAccountName
  oc get sa jupiter

═══════════════════════════════════════════════════════════════════════════════
SOLUTION
