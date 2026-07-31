#!/bin/bash
cat << 'SOLUTION'
═══════════════════════════════════════════════════════════════════════════════
  SOLUTION: Q20 - PV and PVC
═══════════════════════════════════════════════════════════════════════════════

Create landing-pv.yaml:

apiVersion: v1
kind: PersistentVolume
metadata:
  name: landing-pv
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadOnlyMany
  nfs:
    path: /open001
    server: utility.lab.example.com
  persistentVolumeReclaimPolicy: Retain
  storageClassName: nfs2

Create landing-pvc.yaml:

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: landing-pvc
spec:
  accessModes:
    - ReadOnlyMany
  resources:
    requests:
      storage: 1Gi
  storageClassName: nfs2

Apply:
  oc apply -f landing-pv.yaml
  oc apply -f landing-pvc.yaml

Verify:
  oc get pv landing-pv
  oc get pvc landing-pvc
  oc describe pv landing-pv

═══════════════════════════════════════════════════════════════════════════════
SOLUTION
