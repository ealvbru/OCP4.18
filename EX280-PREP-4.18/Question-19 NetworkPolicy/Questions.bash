#!/bin/bash
cat << 'QUESTION'
╔══════════════════════════════════════════════════════════════════════════════╗
║  QUESTION 19: Create a NetworkPolicy                                       ║
║  Domain: Networking & Security                                             ║
║  Weight: 7%                                                                ║
╚══════════════════════════════════════════════════════════════════════════════╝

SIMULATION

Create a NetworkPolicy named "mysql-db-conn" in the "database" project that
permits ingress traffic to database pods with the following requirements:

  • Target pods have the label: deployment=mysql
  • Allow traffic ONLY from:
    - Namespaces labeled: team=devsecops
    - AND pods labeled: deployment=my-web-mysql
  • Allow traffic ONLY on TCP port 3306
  • Policy type: Ingress

QUESTION
