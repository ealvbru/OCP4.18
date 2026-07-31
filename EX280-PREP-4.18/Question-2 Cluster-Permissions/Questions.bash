#!/bin/bash
cat << 'QUESTION'
╔══════════════════════════════════════════════════════════════════════════════╗
║  QUESTION 2: Configure Cluster Permissions                                 ║
║  Domain: Authorization & RBAC                                              ║
║  Weight: 7%                                                                ║
╚══════════════════════════════════════════════════════════════════════════════╝

SIMULATION

Configure your OpenShift cluster to meet the following requirements:

  • The user account "jobs" can perform cluster administration tasks
  • The user account "wozniak" can create projects
  • The user account "wozniak" cannot perform cluster administration tasks
  • The user account "armstrong" cannot create projects
  • The user account "kubeadmin" is not present (delete the kubeadmin secret)

NOTE: Ensure you have another cluster-admin user before removing kubeadmin!

REFERENCES:
  https://docs.openshift.com/container-platform/4.18/authentication/using-rbac.html

QUESTION
