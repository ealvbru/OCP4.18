#!/bin/bash
cat << 'QUESTION'
╔══════════════════════════════════════════════════════════════════════════════╗
║  QUESTION 7: Deploy an Application with Route                                ║
║  Domain: Application Deployment                                              ║
║  Weight: 5%                                                                  ║
╚══════════════════════════════════════════════════════════════════════════════╝

SIMULATION

Deploy the application called "rocky" in the "bullwinkle" project so that the
following conditions are true:

  • The application is reachable at the following address:
    http://rocky.apps.ocp4.example.com

  • The application produces output (responds to HTTP requests)

  • If the application pods are not scheduling, investigate node taints

QUESTION
