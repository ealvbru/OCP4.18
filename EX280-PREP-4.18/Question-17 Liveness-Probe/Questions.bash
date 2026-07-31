#!/bin/bash
cat << 'QUESTION'
╔══════════════════════════════════════════════════════════════════════════════╗
║  QUESTION 17: Configure a Liveness Probe                                     ║
║  Domain: Application Health                                                  ║
║  Weight: 5%                                                                  ║
╚══════════════════════════════════════════════════════════════════════════════╝

SIMULATION

Add a Liveness Probe to the deployment in the "probes" project with the
following requirements:

  • Probe type: HTTP GET
  • Path: /
  • Port: 8080
  • Initial delay: 10 seconds
  • Period: 30 seconds

QUESTION
