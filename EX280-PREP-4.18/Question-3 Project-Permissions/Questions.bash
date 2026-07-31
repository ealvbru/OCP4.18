#!/bin/bash
cat << 'QUESTION'
╔══════════════════════════════════════════════════════════════════════════════╗
║  QUESTION 3: Configure Project Permissions                                 ║
║  Domain: Authorization & RBAC                                              ║
║  Weight: 5%                                                                ║
╚══════════════════════════════════════════════════════════════════════════════╝

SIMULATION

Configure your OpenShift cluster to meet the following requirements:

  • The following projects must exist:
      apollo, manhattan, gemini, bluebook, titan

  • The user account "armstrong" is an administrator for project apollo
    and project gemini

  • The user account "wozniak" can view project titan but cannot
    administer or delete it

QUESTION
