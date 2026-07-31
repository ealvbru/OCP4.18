#!/bin/bash
cat << 'SOLUTION'
═══════════════════════════════════════════════════════════════════════════════
  SOLUTION: Q1 - Configure HTPasswd Identity Provider
═══════════════════════════════════════════════════════════════════════════════

Step 1: Create the htpasswd file with all users
─────────────────────────────────────────────────
  htpasswd -c -B -b /tmp/htpasswd-file armstrong indionce
  htpasswd -B -b /tmp/htpasswd-file collins veraster
  htpasswd -B -b /tmp/htpasswd-file aldrin roonkere
  htpasswd -B -b /tmp/htpasswd-file jobs sestiver
  htpasswd -B -b /tmp/htpasswd-file wozniak glegunge

Step 2: Create the secret in openshift-config namespace
────────────────────────────────────────────────────────
  oc create secret generic ex280-idp-secret \
    --from-file=htpasswd=/tmp/htpasswd-file \
    -n openshift-config

Step 3: Configure the OAuth cluster resource
─────────────────────────────────────────────
  oc get oauth/cluster -o yaml > /tmp/oauth.yaml

  Edit /tmp/oauth.yaml and add under spec:
  spec:
    identityProviders:
    - name: ex280-htpasswd
      mappingMethod: claim
      type: HTPasswd
      htpasswd:
        fileData:
          name: ex280-idp-secret

  oc replace -f /tmp/oauth.yaml

Step 4: Verify logins (wait ~60s for OAuth pods to restart)
───────────────────────────────────────────────────────────
  oc login -u armstrong -p indionce
  oc login -u collins -p veraster
  oc login -u aldrin -p roonkere
  oc login -u jobs -p sestiver
  oc login -u wozniak -p glegunge

═══════════════════════════════════════════════════════════════════════════════
SOLUTION
