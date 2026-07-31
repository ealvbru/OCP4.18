#!/bin/bash
echo "=== Lab Setup: Q18 CronJob SA ==="
oc whoami &>/dev/null || { echo "ERROR: Not logged in"; exit 1; }
oc new-project scheduled 2>/dev/null || oc project scheduled
cat <<CRONJOB | oc apply -f - -n scheduled
apiVersion: batch/v1
kind: CronJob
metadata:
  name: cron-test
spec:
  schedule: "*/5 * * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: hello
            image: registry.ocp4.example.com:8443/ubi9/ubi-minimal:latest
            command: ["echo", "Hello from cron-test"]
          restartPolicy: OnFailure
CRONJOB
echo "✅ CronJob 'cron-test' created. Configure the service account."
