#!/bin/bash
cat << 'QUESTION'
╔══════════════════════════════════════════════════════════════════════════════╗
║  QUESTION 4: Configure Groups                                                ║
║  Domain: Authorization & RBAC                                                ║
║  Weight: 5%                                                                  ║
╚══════════════════════════════════════════════════════════════════════════════╝

SIMULATION

Configure your OpenShift cluster to meet the following requirements:

  • The user account "armstrong" is a member of the "commander" group
  • The user account "collins" is a member of the "pilot" group
  • The user account "aldrin" is a member of the "pilot" group
  • Members of the "commander" group have edit permission in the apollo project
  • Members of the "pilot" group have view permission in the apollo project

QUESTION
