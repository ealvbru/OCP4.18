#!/bin/bash
cat << 'QUESTION'
╔══════════════════════════════════════════════════════════════════════════════╗
║  QUESTION 13: Configure a Service Account with SCC                           ║
║  Domain: Security                                                            ║
║  Weight: 5%                                                                  ║
╚══════════════════════════════════════════════════════════════════════════════╝

SIMULATION

Configure a service account in the "apples" project to meet the following
requirements:

  • The name of the service account is: ex280sa
  • The account allows pods to be run as any available user (anyuid SCC)

QUESTION
