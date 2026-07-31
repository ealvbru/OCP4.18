#!/bin/bash
cat << 'QUESTION'
╔══════════════════════════════════════════════════════════════════════════════╗
║  QUESTION 10: Configure a Secure Route (Edge TLS)                          ║
║  Domain: Networking & Routes                                               ║
║  Weight: 7%                                                                ║
╚══════════════════════════════════════════════════════════════════════════════╝

SIMULATION

Configure the "oxcart" application in the "area51" project with the following
requirements:

  • The application uses a route called "oxcart"
  • The application uses a CA signed certificate with the following subject:
    /C=US/ST=NV/L=Hiko/O=CIA/OU=USAF/CN=classified.apps.ocp4.example.com
  • The application is reachable ONLY at:
    https://classified.apps.ocp4.example.com
  • The application produces output
  • Use edge TLS termination

QUESTION
