#!/bin/bash
cat << 'QUESTION'
╔══════════════════════════════════════════════════════════════════════════════╗
║  QUESTION 20: Create a PersistentVolume and PersistentVolumeClaim            ║
║  Domain: Storage                                                             ║
║  Weight: 7%                                                                  ║
╚══════════════════════════════════════════════════════════════════════════════╝

SIMULATION

Create persistent storage resources with the following requirements:

PersistentVolume:
  • Name: landing-pv
  • Capacity: 1Gi
  • Access Mode: ReadOnlyMany
  • NFS server: utility.lab.example.com
  • NFS path: /open001
  • Reclaim Policy: Retain
  • Storage Class: nfs2

PersistentVolumeClaim:
  • Name: landing-pvc
  • Capacity request: 1Gi
  • Access Mode: ReadOnlyMany
  • Storage Class: nfs2

QUESTION
