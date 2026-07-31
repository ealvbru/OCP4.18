#!/bin/bash
cat << 'QUESTION'
╔══════════════════════════════════════════════════════════════════════════════╗
║  QUESTION 6: Configure LimitRange                                          ║
║  Domain: Resource Management                                               ║
║  Weight: 5%                                                                ║
╚══════════════════════════════════════════════════════════════════════════════╝

SIMULATION

Configure your OpenShift cluster to use limits in the "bluebook" project with
the following requirements:

  • The name of the LimitRange resource is: ex280-limits
  • The amount of memory consumed by a single pod is between 5Mi and 300Mi
  • The amount of memory consumed by a single container is between 5Mi and
    300Mi with a default request value of 100Mi
  • The amount of CPU consumed by a single pod is between 10m and 500m
  • The amount of CPU consumed by a single container is between 10m and 500m
    with a default request value of 100m

QUESTION
