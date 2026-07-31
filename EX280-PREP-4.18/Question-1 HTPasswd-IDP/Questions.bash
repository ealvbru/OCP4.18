#!/bin/bash
cat << 'QUESTION'
╔══════════════════════════════════════════════════════════════════════════════╗
║  QUESTION 1: Configure an HTPasswd Identity Provider                         ║
║  Domain: Authentication & Authorization                                      ║
║  Weight: 7%                                                                  ║
╚══════════════════════════════════════════════════════════════════════════════╝

SIMULATION

Configure your OpenShift cluster to use an HTPasswd identity provider with the
following requirements:

  • The name of the identity provider is: ex280-htpasswd
  • The name of the secret is: ex280-idp-secret (in openshift-config namespace)
  • Create the following user accounts with their passwords:
      - armstrong / indionce
      - collins   / veraster
      - aldrin    / roonkere
      - jobs      / sestiver
      - wozniak   / glegunge
  • All users must be able to log in to the cluster after configuration.

REFERENCES:
  https://docs.openshift.com/container-platform/4.18/authentication/identity_providers/configuring-htpasswd-identity-provider.html

QUESTION
