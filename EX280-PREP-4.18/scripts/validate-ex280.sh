#!/bin/bash
###############################################################################
#  EX280 OpenShift Administration 4.18 — Automated Exam Validator
#  Passing Score: 70%  |  Total Questions: 21  |  Weighted Scoring
###############################################################################
set -o pipefail

# ─── Colors ──────────────────────────────────────────────────────────────────
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; NC='\033[0m'

# ─── Counters ────────────────────────────────────────────────────────────────
declare -A Q_PASS Q_TOTAL Q_WEIGHT Q_NAME
TOTAL_CHECKS=0; TOTAL_PASSED=0
PASS_THRESHOLD=70

# ─── Weights (must sum to 100) ───────────────────────────────────────────────
Q_WEIGHT[1]=7;  Q_NAME[1]="HTPasswd Identity Provider"
Q_WEIGHT[2]=7;  Q_NAME[2]="Cluster Permissions (RBAC)"
Q_WEIGHT[3]=5;  Q_NAME[3]="Project Permissions"
Q_WEIGHT[4]=5;  Q_NAME[4]="Configure Groups"
Q_WEIGHT[5]=5;  Q_NAME[5]="Resource Quota"
Q_WEIGHT[6]=5;  Q_NAME[6]="LimitRange"
Q_WEIGHT[7]=5;  Q_NAME[7]="Deploy App with Route"
Q_WEIGHT[8]=3;  Q_NAME[8]="Manual Scale"
Q_WEIGHT[9]=5;  Q_NAME[9]="Autoscale (HPA)"
Q_WEIGHT[10]=7; Q_NAME[10]="Secure Route (Edge TLS)"
Q_WEIGHT[11]=4; Q_NAME[11]="Create Secret"
Q_WEIGHT[12]=4; Q_NAME[12]="Use Secret in App"
Q_WEIGHT[13]=5; Q_NAME[13]="Service Account SCC"
Q_WEIGHT[14]=4; Q_NAME[14]="Deploy with SA"
Q_WEIGHT[15]=5; Q_NAME[15]="Helm Chart"
Q_WEIGHT[16]=3; Q_NAME[16]="Must-Gather"
Q_WEIGHT[17]=5; Q_NAME[17]="Liveness Probe"
Q_WEIGHT[18]=5; Q_NAME[18]="CronJob with SA"
Q_WEIGHT[19]=7; Q_NAME[19]="NetworkPolicy"
Q_WEIGHT[20]=7; Q_NAME[20]="PV and PVC"
Q_WEIGHT[21]=5; Q_NAME[21]="Project Template"

# ─── Helper Functions ────────────────────────────────────────────────────────
check() {
  local qnum=$1 desc="$2" cmd="$3"
  Q_TOTAL[$qnum]=$(( ${Q_TOTAL[$qnum]:-0} + 1 ))
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
  if eval "$cmd" &>/dev/null; then
    Q_PASS[$qnum]=$(( ${Q_PASS[$qnum]:-0} + 1 ))
    TOTAL_PASSED=$((TOTAL_PASSED + 1))
    printf "  ${GREEN}✅${NC}  %-60s\n" "$desc"
  else
    printf "  ${RED}❌${NC}  %-60s\n" "$desc"
  fi
}

banner() {
  echo ""
  printf "  ${CYAN}${BOLD}Question %d: %s${NC}\n" "$1" "${Q_NAME[$1]}"
}

# ─── Validation Functions ────────────────────────────────────────────────────

validate_q1() {
  banner 1
  check 1 "Secret 'ex280-idp-secret' exists in openshift-config" \
    "oc get secret ex280-idp-secret -n openshift-config"
  check 1 "OAuth cluster has HTPasswd IDP named 'ex280-htpasswd'" \
    "oc get oauth cluster -o yaml | grep -q 'name: ex280-htpasswd'"
  check 1 "OAuth IDP type is HTPasswd" \
    "oc get oauth cluster -o yaml | grep -q 'type: HTPasswd'"
  check 1 "User 'armstrong' exists" \
    "oc get user armstrong"
  check 1 "User 'collins' exists" \
    "oc get user collins"
  check 1 "User 'aldrin' exists" \
    "oc get user aldrin"
  check 1 "User 'jobs' exists" \
    "oc get user jobs"
  check 1 "User 'wozniak' exists" \
    "oc get user wozniak"
}

validate_q2() {
  banner 2
  check 2 "User 'jobs' has cluster-admin role" \
    "oc get clusterrolebinding -o json | jq -e '.items[] | select(.roleRef.name==\"cluster-admin\") | .subjects[]? | select(.name==\"jobs\")'"
  check 2 "Self-provisioner removed from system:authenticated:oauth" \
    "! oc get clusterrolebinding self-provisioners -o yaml 2>/dev/null | grep -q 'system:authenticated:oauth'"
  check 2 "User 'wozniak' has self-provisioner role" \
    "oc get clusterrolebinding -o json | jq -e '.items[] | select(.roleRef.name==\"self-provisioner\") | .subjects[]? | select(.name==\"wozniak\")'"
  check 2 "User 'armstrong' cannot create projects" \
    "! oc auth can-i create projectrequests --as=armstrong"
  check 2 "Kubeadmin secret deleted from kube-system" \
    "! oc get secret kubeadmin -n kube-system 2>/dev/null"
}

validate_q3() {
  banner 3
  check 3 "Project 'apollo' exists" \
    "oc get project apollo"
  check 3 "Project 'manhattan' exists" \
    "oc get project manhattan"
  check 3 "Project 'gemini' exists" \
    "oc get project gemini"
  check 3 "Project 'bluebook' exists" \
    "oc get project bluebook"
  check 3 "Project 'titan' exists" \
    "oc get project titan"
  check 3 "armstrong is admin in apollo" \
    "oc get rolebinding -n apollo -o json | jq -e '.items[] | select(.roleRef.name==\"admin\") | .subjects[]? | select(.name==\"armstrong\")'"
  check 3 "armstrong is admin in gemini" \
    "oc get rolebinding -n gemini -o json | jq -e '.items[] | select(.roleRef.name==\"admin\") | .subjects[]? | select(.name==\"armstrong\")'"
  check 3 "wozniak has view in titan" \
    "oc get rolebinding -n titan -o json | jq -e '.items[] | select(.roleRef.name==\"view\") | .subjects[]? | select(.name==\"wozniak\")'"
}

validate_q4() {
  banner 4
  check 4 "Group 'commander' exists" \
    "oc get group commander"
  check 4 "Group 'pilot' exists" \
    "oc get group pilot"
  check 4 "armstrong is in commander group" \
    "oc get group commander -o json | jq -e '.users[] | select(.==\"armstrong\")'"
  check 4 "collins is in pilot group" \
    "oc get group pilot -o json | jq -e '.users[] | select(.==\"collins\")'"
  check 4 "aldrin is in pilot group" \
    "oc get group pilot -o json | jq -e '.users[] | select(.==\"aldrin\")'"
  check 4 "commander group has edit in apollo" \
    "oc get rolebinding -n apollo -o json | jq -e '.items[] | select(.roleRef.name==\"edit\") | .subjects[]? | select(.name==\"commander\" and .kind==\"Group\")'"
  check 4 "pilot group has view in apollo" \
    "oc get rolebinding -n apollo -o json | jq -e '.items[] | select(.roleRef.name==\"view\") | .subjects[]? | select(.name==\"pilot\" and .kind==\"Group\")'"
}

validate_q5() {
  banner 5
  check 5 "ResourceQuota 'ex280-quota' exists in manhattan" \
    "oc get resourcequota ex280-quota -n manhattan"
  check 5 "Quota memory hard limit is 1Gi" \
    "oc get resourcequota ex280-quota -n manhattan -o jsonpath='{.spec.hard.memory}' | grep -qE '1Gi|1073741824'"
  check 5 "Quota CPU hard limit is 2" \
    "oc get resourcequota ex280-quota -n manhattan -o jsonpath='{.spec.hard.cpu}' | grep -q '2'"
  check 5 "Quota pods hard limit is 3" \
    "oc get resourcequota ex280-quota -n manhattan -o jsonpath='{.spec.hard.pods}' | grep -q '3'"
  check 5 "Quota services hard limit is 6" \
    "oc get resourcequota ex280-quota -n manhattan -o jsonpath='{.spec.hard.services}' | grep -q '6'"
  check 5 "Quota replicationcontrollers hard limit is 3" \
    "oc get resourcequota ex280-quota -n manhattan -o jsonpath='{.spec.hard.replicationcontrollers}' | grep -q '3'"
}

validate_q6() {
  banner 6
  check 6 "LimitRange 'ex280-limits' exists in bluebook" \
    "oc get limitrange ex280-limits -n bluebook"
  check 6 "Pod max memory is 300Mi" \
    "oc get limitrange ex280-limits -n bluebook -o json | jq -e '.spec.limits[] | select(.type==\"Pod\") | .max.memory' | grep -qi '300Mi'"
  check 6 "Pod min memory is 5Mi" \
    "oc get limitrange ex280-limits -n bluebook -o json | jq -e '.spec.limits[] | select(.type==\"Pod\") | .min.memory' | grep -qi '5Mi'"
  check 6 "Container max CPU is 500m" \
    "oc get limitrange ex280-limits -n bluebook -o json | jq -e '.spec.limits[] | select(.type==\"Container\") | .max.cpu' | grep -q '500m'"
  check 6 "Container min CPU is 10m" \
    "oc get limitrange ex280-limits -n bluebook -o json | jq -e '.spec.limits[] | select(.type==\"Container\") | .min.cpu' | grep -q '10m'"
  check 6 "Container default request memory is 100Mi" \
    "oc get limitrange ex280-limits -n bluebook -o json | jq -e '.spec.limits[] | select(.type==\"Container\") | .defaultRequest.memory' | grep -qi '100Mi'"
  check 6 "Container default request CPU is 100m" \
    "oc get limitrange ex280-limits -n bluebook -o json | jq -e '.spec.limits[] | select(.type==\"Container\") | .defaultRequest.cpu' | grep -q '100m'"
}

validate_q7() {
  banner 7
  check 7 "Project 'bullwinkle' exists" \
    "oc get project bullwinkle"
  check 7 "Deployment 'rocky' exists in bullwinkle" \
    "oc get deployment rocky -n bullwinkle"
  check 7 "Route 'rocky' exists in bullwinkle" \
    "oc get route rocky -n bullwinkle"
  check 7 "Route hostname is rocky.apps.ocp4.example.com" \
    "oc get route rocky -n bullwinkle -o jsonpath='{.spec.host}' | grep -q 'rocky.apps.ocp4.example.com'"
  check 7 "Rocky pods are running" \
    "oc get pods -n bullwinkle -l app=rocky --field-selector=status.phase=Running 2>/dev/null | grep -q Running"
}

validate_q8() {
  banner 8
  check 8 "Deployment 'minion' exists in gru" \
    "oc get deployment minion -n gru"
  check 8 "Deployment 'minion' has 5 replicas" \
    "[ \$(oc get deployment minion -n gru -o jsonpath='{.spec.replicas}') -eq 5 ]"
  check 8 "5 minion pods are available" \
    "[ \$(oc get deployment minion -n gru -o jsonpath='{.status.availableReplicas}') -ge 5 ] 2>/dev/null"
}

validate_q9() {
  banner 9
  check 9 "Deployment 'hydra' exists in lerna" \
    "oc get deployment hydra -n lerna"
  check 9 "HPA 'hydra' exists in lerna" \
    "oc get hpa hydra -n lerna"
  check 9 "HPA min replicas is 6" \
    "[ \$(oc get hpa hydra -n lerna -o jsonpath='{.spec.minReplicas}') -eq 6 ]"
  check 9 "HPA max replicas is 9" \
    "[ \$(oc get hpa hydra -n lerna -o jsonpath='{.spec.maxReplicas}') -eq 9 ]"
  check 9 "HPA CPU target is 60%" \
    "oc get hpa hydra -n lerna -o jsonpath='{.spec.targetCPUUtilizationPercentage}' | grep -q '60' || oc get hpa hydra -n lerna -o json | jq -e '.spec.metrics[] | select(.resource.name==\"cpu\") | .resource.target.averageUtilization == 60'"
  check 9 "Deployment has CPU requests set" \
    "oc get deployment hydra -n lerna -o json | jq -e '.spec.template.spec.containers[0].resources.requests.cpu'"
  check 9 "Deployment has CPU limits set" \
    "oc get deployment hydra -n lerna -o json | jq -e '.spec.template.spec.containers[0].resources.limits.cpu'"
}

validate_q10() {
  banner 10
  check 10 "Project 'area51' exists" \
    "oc get project area51"
  check 10 "Route 'oxcart' exists in area51" \
    "oc get route oxcart -n area51"
  check 10 "Route uses edge TLS termination" \
    "oc get route oxcart -n area51 -o jsonpath='{.spec.tls.termination}' | grep -qi 'edge'"
  check 10 "Route has TLS certificate configured" \
    "oc get route oxcart -n area51 -o jsonpath='{.spec.tls.certificate}' | grep -q 'BEGIN CERTIFICATE'"
  check 10 "Route hostname is classified.apps.ocp4.example.com" \
    "oc get route oxcart -n area51 -o jsonpath='{.spec.host}' | grep -q 'classified.apps.ocp4.example.com'"
  check 10 "Service 'oxcart' exists in area51" \
    "oc get svc oxcart -n area51"
}

validate_q11() {
  banner 11
  check 11 "Project 'math' exists" \
    "oc get project math"
  check 11 "Secret 'magic' exists in math" \
    "oc get secret magic -n math"
  check 11 "Secret contains MYSQL_ROOT_PASSWORD key" \
    "oc get secret magic -n math -o jsonpath='{.data}' | grep -q 'MYSQL_ROOT_PASSWORD'"
  check 11 "Secret value decodes to 'redhat'" \
    "[ \"\$(oc get secret magic -n math -o jsonpath='{.data.MYSQL_ROOT_PASSWORD}' | base64 -d)\" = 'redhat' ]"
}

validate_q12() {
  banner 12
  check 12 "Deployment 'monday' exists in math" \
    "oc get deployment monday -n math"
  check 12 "Deployment uses secret 'magic' as env source" \
    "oc get deployment monday -n math -o json | jq -e '.spec.template.spec.containers[0].envFrom[]? | select(.secretRef.name==\"magic\")' || oc get deployment monday -n math -o json | jq -e '.spec.template.spec.containers[0].env[]? | select(.valueFrom.secretKeyRef.name==\"magic\")'"
  check 12 "MYSQL_ROOT_PASSWORD env var is set" \
    "oc set env deployment/monday --list -n math 2>/dev/null | grep -q 'MYSQL_ROOT_PASSWORD'"
}

validate_q13() {
  banner 13
  check 13 "Project 'apples' exists" \
    "oc get project apples"
  check 13 "Service account 'ex280sa' exists in apples" \
    "oc get sa ex280sa -n apples"
  check 13 "ex280sa has anyuid SCC" \
    "oc adm policy who-can use scc anyuid 2>/dev/null | grep -q 'ex280sa' || oc get scc anyuid -o json | jq -e '.users[]? | select(contains(\"ex280sa\"))'"
}

validate_q14() {
  banner 14
  check 14 "Deployment 'oranges' exists in apples" \
    "oc get deployment oranges -n apples"
  check 14 "Deployment uses 'ex280sa' service account" \
    "oc get deployment oranges -n apples -o jsonpath='{.spec.template.spec.serviceAccountName}' | grep -q 'ex280sa'"
  check 14 "Oranges pods are running" \
    "oc get pods -n apples -l app=oranges --field-selector=status.phase=Running 2>/dev/null | grep -q Running"
}

validate_q15() {
  banner 15
  check 15 "Helm repo 'do280-repo' is added" \
    "helm repo list 2>/dev/null | grep -q 'do280-repo'"
  check 15 "Helm release 'example-app' is deployed" \
    "helm list --all-namespaces 2>/dev/null | grep -q 'example-app'"
  check 15 "Release status is deployed" \
    "helm status example-app 2>/dev/null | grep -qi 'deployed'"
}

validate_q16() {
  banner 16
  check 16 "Must-gather archive exists (tar.gz)" \
    "ls ~/must-gather*.tar.gz 2>/dev/null | head -1 | grep -q '.tar.gz' || find / -maxdepth 3 -name 'must-gather*.tar.gz' 2>/dev/null | head -1 | grep -q '.tar.gz'"
  check 16 "Archive is not empty" \
    "[ \$(find ~ -maxdepth 1 -name 'must-gather*.tar.gz' -size +1k 2>/dev/null | wc -l) -gt 0 ] || [ \$(find / -maxdepth 3 -name 'must-gather*.tar.gz' -size +1k 2>/dev/null | wc -l) -gt 0 ]"
}

validate_q17() {
  banner 17
  check 17 "Project 'probes' exists" \
    "oc get project probes"
  check 17 "Deployment 'probe-app' exists in probes" \
    "oc get deployment probe-app -n probes"
  check 17 "Liveness probe is configured" \
    "oc get deployment probe-app -n probes -o json | jq -e '.spec.template.spec.containers[0].livenessProbe'"
  check 17 "Liveness probe uses HTTP GET" \
    "oc get deployment probe-app -n probes -o json | jq -e '.spec.template.spec.containers[0].livenessProbe.httpGet'"
  check 17 "Liveness probe port is 8080" \
    "[ \$(oc get deployment probe-app -n probes -o json | jq '.spec.template.spec.containers[0].livenessProbe.httpGet.port') -eq 8080 ]"
  check 17 "Initial delay is 10 seconds" \
    "[ \$(oc get deployment probe-app -n probes -o json | jq '.spec.template.spec.containers[0].livenessProbe.initialDelaySeconds') -eq 10 ]"
}

validate_q18() {
  banner 18
  check 18 "Project 'scheduled' exists" \
    "oc get project scheduled"
  check 18 "Service account 'jupiter' exists" \
    "oc get sa jupiter -n scheduled"
  check 18 "jupiter has anyuid SCC" \
    "oc adm policy who-can use scc anyuid 2>/dev/null | grep -q 'jupiter' || oc get scc anyuid -o json | jq -e '.users[]? | select(contains(\"jupiter\"))'"
  check 18 "jupiter has cluster-admin role" \
    "oc get clusterrolebinding -o json | jq -e '.items[] | select(.roleRef.name==\"cluster-admin\") | .subjects[]? | select(.name | contains(\"jupiter\"))'"
  check 18 "CronJob 'cron-test' uses jupiter SA" \
    "oc get cronjob cron-test -n scheduled -o jsonpath='{.spec.jobTemplate.spec.template.spec.serviceAccountName}' | grep -q 'jupiter'"
}

validate_q19() {
  banner 19
  check 19 "NetworkPolicy 'mysql-db-conn' exists" \
    "oc get networkpolicy mysql-db-conn -n database"
  check 19 "Policy targets pods with deployment=mysql" \
    "oc get networkpolicy mysql-db-conn -n database -o json | jq -e '.spec.podSelector.matchLabels.deployment' | grep -q 'mysql'"
  check 19 "Policy type includes Ingress" \
    "oc get networkpolicy mysql-db-conn -n database -o json | jq -e '.spec.policyTypes[]' | grep -q 'Ingress'"
  check 19 "Ingress allows from namespace team=devsecops" \
    "oc get networkpolicy mysql-db-conn -n database -o json | jq -e '.spec.ingress[0].from[] | select(.namespaceSelector) | .namespaceSelector.matchLabels.team' | grep -q 'devsecops'"
  check 19 "Ingress allows from pods deployment=my-web-mysql" \
    "oc get networkpolicy mysql-db-conn -n database -o json | jq -e '.spec.ingress[0].from[] | select(.podSelector) | .podSelector.matchLabels.deployment' | grep -q 'my-web-mysql'"
  check 19 "Ingress port is TCP 3306" \
    "oc get networkpolicy mysql-db-conn -n database -o json | jq -e '.spec.ingress[0].ports[] | select(.port==3306 and .protocol==\"TCP\")'"
}

validate_q20() {
  banner 20
  check 20 "PV 'landing-pv' exists" \
    "oc get pv landing-pv"
  check 20 "PV capacity is 1Gi" \
    "oc get pv landing-pv -o jsonpath='{.spec.capacity.storage}' | grep -q '1Gi'"
  check 20 "PV access mode is ReadOnlyMany" \
    "oc get pv landing-pv -o json | jq -e '.spec.accessModes[] | select(.==\"ReadOnlyMany\")'"
  check 20 "PV uses NFS backend" \
    "oc get pv landing-pv -o json | jq -e '.spec.nfs'"
  check 20 "PV NFS server is utility.lab.example.com" \
    "oc get pv landing-pv -o jsonpath='{.spec.nfs.server}' | grep -q 'utility.lab.example.com'"
  check 20 "PV NFS path is /open001" \
    "oc get pv landing-pv -o jsonpath='{.spec.nfs.path}' | grep -q '/open001'"
  check 20 "PV reclaim policy is Retain" \
    "oc get pv landing-pv -o jsonpath='{.spec.persistentVolumeReclaimPolicy}' | grep -q 'Retain'"
  check 20 "PVC 'landing-pvc' exists" \
    "oc get pvc landing-pvc"
  check 20 "PVC requests 1Gi" \
    "oc get pvc landing-pvc -o jsonpath='{.spec.resources.requests.storage}' | grep -q '1Gi'"
  check 20 "PVC storage class is nfs2" \
    "oc get pvc landing-pvc -o jsonpath='{.spec.storageClassName}' | grep -q 'nfs2'"
}

validate_q21() {
  banner 21
  check 21 "Template 'project-request' exists in openshift-config" \
    "oc get template project-request -n openshift-config"
  check 21 "Cluster project config references the template" \
    "oc get project.config.openshift.io/cluster -o json | jq -e '.spec.projectRequestTemplate.name' | grep -q 'project-request'"
}

# ─── MAIN ────────────────────────────────────────────────────────────────────

echo ""
echo "  ╔═══════════════════════════════════════════════════════════════════╗"
echo "  ║   EX280 — Red Hat OpenShift Administration 4.18 Validator        ║"
echo "  ║   Passing Score: 70%  |  21 Questions  |  Weighted Scoring       ║"
echo "  ╚═══════════════════════════════════════════════════════════════════╝"
echo ""
echo "  Starting validation at $(date '+%Y-%m-%d %H:%M:%S')"

# Determine which questions to validate
QUESTIONS_TO_RUN=()
if [ $# -eq 0 ]; then
  for i in $(seq 1 21); do QUESTIONS_TO_RUN+=($i); done
else
  for arg in "$@"; do
    if [[ "$arg" =~ ^[0-9]+$ ]] && [ "$arg" -ge 1 ] && [ "$arg" -le 21 ]; then
      QUESTIONS_TO_RUN+=($arg)
    fi
  done
fi

echo "  Questions selected: ${QUESTIONS_TO_RUN[*]}"
echo ""

# Check oc connectivity
if ! oc whoami &>/dev/null; then
  echo -e "  ${RED}ERROR: Not logged in to OpenShift cluster.${NC}"
  echo "  Please run: oc login -u admin -p redhatocp https://api.ocp4.example.com:6443"
  exit 1
fi

# Run validations
for q in "${QUESTIONS_TO_RUN[@]}"; do
  validate_q${q} 2>/dev/null
done

# ─── Score Report ────────────────────────────────────────────────────────────
echo ""
echo "  ═══════════════════════════════════════════════════════════════════"
echo -e "  ${BOLD}EXAM RESULTS${NC}"
echo "  ═══════════════════════════════════════════════════════════════════"
printf "  ${BOLD}%-6s %-42s %7s %7s %8s${NC}\n" "Q#" "Topic" "Checks" "Passed" "Score"
printf "  %-6s %-42s %7s %7s %8s\n" "------" "------------------------------------------" "-------" "-------" "--------"

WEIGHTED_SCORE=0
TOTAL_WEIGHT=0

for q in "${QUESTIONS_TO_RUN[@]}"; do
  total=${Q_TOTAL[$q]:-0}
  passed=${Q_PASS[$q]:-0}
  weight=${Q_WEIGHT[$q]}
  TOTAL_WEIGHT=$((TOTAL_WEIGHT + weight))

  if [ $total -gt 0 ]; then
    pct=$(echo "scale=1; $passed * 100 / $total" | bc)
    q_weighted=$(echo "scale=2; $passed * $weight / $total" | bc)
  else
    pct="0.0"
    q_weighted=0
  fi
  WEIGHTED_SCORE=$(echo "$WEIGHTED_SCORE + $q_weighted" | bc)

  if [ "$passed" -eq "$total" ] && [ "$total" -gt 0 ]; then
    color=$GREEN
  elif [ "$passed" -gt 0 ]; then
    color=$YELLOW
  else
    color=$RED
  fi
  printf "  ${color}Q%-5d %-42s %5d   %5d   %6s%%${NC}\n" "$q" "${Q_NAME[$q]}" "$total" "$passed" "$pct"
done

printf "  %-6s %-42s %7s %7s\n" "------" "------------------------------------------" "-------" "-------"
printf "  ${BOLD}%-6s %-42s %5d   %5d${NC}\n" "TOTAL" "All Checks" "$TOTAL_CHECKS" "$TOTAL_PASSED"

# Calculate final weighted percentage
if [ "$TOTAL_WEIGHT" -gt 0 ]; then
  FINAL_SCORE=$(echo "scale=1; $WEIGHTED_SCORE * 100 / $TOTAL_WEIGHT" | bc)
else
  FINAL_SCORE="0.0"
fi

echo ""
echo "  EX280 Exam Domain Mapping:"
echo "    Q1  HTPasswd IDP ........ Authentication & Authorization"
echo "    Q2  Cluster Perms ....... Authorization & RBAC"
echo "    Q3  Project Perms ....... Authorization & RBAC"
echo "    Q4  Groups .............. Authorization & RBAC"
echo "    Q5  Resource Quota ...... Resource Management"
echo "    Q6  LimitRange .......... Resource Management"
echo "    Q7  Deploy App+Route .... Application Deployment"
echo "    Q8  Manual Scale ........ Application Management"
echo "    Q9  Autoscale HPA ....... Application Management"
echo "    Q10 Secure Route ........ Networking & Routes"
echo "    Q11 Create Secret ....... Configuration & Secrets"
echo "    Q12 Use Secret .......... Configuration & Secrets"
echo "    Q13 Service Account ..... Security"
echo "    Q14 Deploy with SA ...... Application Deployment & Security"
echo "    Q15 Helm Chart .......... Application Deployment"
echo "    Q16 Must-Gather ......... Cluster Maintenance"
echo "    Q17 Liveness Probe ...... Application Health"
echo "    Q18 CronJob SA .......... Workload Management"
echo "    Q19 NetworkPolicy ....... Networking & Security"
echo "    Q20 PV and PVC .......... Storage"
echo "    Q21 Project Template .... Cluster Configuration"
echo ""

# Final verdict
SCORE_INT=$(echo "$FINAL_SCORE" | cut -d'.' -f1)
if [ "${SCORE_INT:-0}" -ge $PASS_THRESHOLD ]; then
  echo "  ╔═══════════════════════════════════════════════════╗"
  printf "  ║  FINAL SCORE:  ${GREEN}${BOLD}%5s%%${NC}   ✅  PASSED!            ║\n" "$FINAL_SCORE"
  echo "  ║  Passing Score:  ${PASS_THRESHOLD}%                          ║"
  echo "  ╚═══════════════════════════════════════════════════╝"
  EXIT_CODE=0
else
  echo "  ╔═══════════════════════════════════════════════════╗"
  printf "  ║  FINAL SCORE:  ${RED}${BOLD}%5s%%${NC}   ❌  FAILED             ║\n" "$FINAL_SCORE"
  echo "  ║  Passing Score:  ${PASS_THRESHOLD}%                          ║"
  echo "  ╚═══════════════════════════════════════════════════╝"
  EXIT_CODE=1
fi

echo ""
echo "  Validation completed at $(date '+%Y-%m-%d %H:%M:%S')"
echo ""
exit $EXIT_CODE
