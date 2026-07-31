#!/bin/bash
cat << 'QUESTION'
╔══════════════════════════════════════════════════════════════════════════════╗
║  QUESTION 18: Configure a CronJob with Service Account                     ║
║  Domain: Workload Management                                               ║
║  Weight: 5%                                                                ║
╚══════════════════════════════════════════════════════════════════════════════╝

SIMULATION

In the "scheduled" project, configure the following:

  • Create a service account named "jupiter"
  • Grant the "anyuid" SCC to the jupiter service account
  • Grant "cluster-admin" role to the jupiter service account
  • Update the CronJob "cron-test" to use the "jupiter" service account

QUESTION
