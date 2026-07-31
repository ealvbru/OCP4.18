#!/bin/bash
cat << 'QUESTION'
╔══════════════════════════════════════════════════════════════════════════════╗
║  QUESTION 12: Use a Secret in an Application                               ║
║  Domain: Configuration & Secrets                                           ║
║  Weight: 4%                                                                ║
╚══════════════════════════════════════════════════════════════════════════════╝

SIMULATION

Configure the application called "monday" in the "math" project with the
following requirements:

  • The application uses the secret previously created called: magic
  • The secret is injected as environment variables
  • The application output no longer displays:
    "Sorry, application is not configured correctly."

QUESTION
