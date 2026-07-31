#!/bin/bash
cat << 'QUESTION'
╔══════════════════════════════════════════════════════════════════════════════╗
║  QUESTION 15: Install a Helm Chart                                         ║
║  Domain: Application Deployment                                            ║
║  Weight: 5%                                                                ║
╚══════════════════════════════════════════════════════════════════════════════╝

SIMULATION

Install an application using Helm with the following requirements:

  • Add the Helm repository named "do280-repo" with URL:
    http://helm.ocp4.example.com/charts

  • Install a release named "example-app" from the chart "etherpad"
    in the do280-repo repository

QUESTION
