#!/bin/bash
cat << 'QUESTION'
╔══════════════════════════════════════════════════════════════════════════════╗
║  QUESTION 5: Configure Resource Quotas                                     ║
║  Domain: Resource Management                                               ║
║  Weight: 5%                                                                ║
╚══════════════════════════════════════════════════════════════════════════════╝

SIMULATION

Configure your OpenShift cluster to use quotas in the "manhattan" project with
the following requirements:

  • The name of the ResourceQuota resource is: ex280-quota
  • The amount of memory consumed across all containers may not exceed 1Gi
  • The total amount of CPU usage consumed across all containers may not exceed
    2 full cores
  • The maximum number of replication controllers does not exceed 3
  • The maximum number of pods does not exceed 3
  • The maximum number of services does not exceed 6

QUESTION
