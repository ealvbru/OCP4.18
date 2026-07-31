#!/bin/bash
cat << 'QUESTION'
╔══════════════════════════════════════════════════════════════════════════════╗
║  QUESTION 9: Autoscale an Application (HPA)                                ║
║  Domain: Application Management                                            ║
║  Weight: 5%                                                                ║
╚══════════════════════════════════════════════════════════════════════════════╝

SIMULATION

Automatically scale the "hydra" application deployment in the "lerna" project
with the following requirements:

  • Minimum number of replicas: 6
  • Maximum number of replicas: 9
  • Target average CPU utilization: 60 percent
  • Container CPU resource request: 25m
  • Container CPU resource limit: 100m

QUESTION
