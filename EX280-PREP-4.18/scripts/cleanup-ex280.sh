#!/bin/bash
###############################################################################
#  EX280 OpenShift Administration 4.18 — Environment Cleanup Script
#  Reverts all changes made during exercises
###############################################################################

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BOLD='\033[1m'; NC='\033[0m'

DRY_RUN=false
FORCE=false
QUESTIONS_TO_CLEAN=()

# Parse arguments
for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=true ;;
    --force)   FORCE=true ;;
    --help|-h)
      echo "Usage: bash scripts/cleanup-ex280.sh [OPTIONS] [QUESTION_NUMBERS...]"
      echo ""
      echo "Options:"
      echo "  --dry-run    Show what would be cleaned without making changes"
      echo "  --force      Skip confirmation prompt"
      echo "  --help       Show this help"
      echo ""
      echo "Examples:"
      echo "  bash scripts/cleanup-ex280.sh              # Clean all"
      echo "  bash scripts/cleanup-ex280.sh --dry-run    # Preview cleanup"
      echo "  bash scripts/cleanup-ex280.sh 5 6 7        # Clean Q5, Q6, Q7 only"
      exit 0
      ;;
    [0-9]*)
      QUESTIONS_TO_CLEAN+=($arg)
      ;;
  esac
done

if [ ${#QUESTIONS_TO_CLEAN[@]} -eq 0 ]; then
  for i in $(seq 1 21); do QUESTIONS_TO_CLEAN+=($i); done
fi

run_cmd() {
  local desc="$1" cmd="$2"
  if $DRY_RUN; then
    printf "  ${YELLOW}[DRY-RUN]${NC} %s\n" "$desc"
  else
    printf "  ${CYAN}→${NC} %s ... " "$desc"
    if eval "$cmd" &>/dev/null; then
      printf "${GREEN}done${NC}\n"
    else
      printf "${YELLOW}skipped${NC}\n"
    fi
  fi
}

echo ""
echo "  ╔═══════════════════════════════════════════════════════════════════╗"
echo "  ║   EX280 — Environment Cleanup                                    ║"
echo "  ╚═══════════════════════════════════════════════════════════════════╝"
echo ""

if ! oc whoami &>/dev/null; then
  echo -e "  ${RED}ERROR: Not logged in to OpenShift cluster. Run: oc login -u admin -p redhatocp https://api.ocp4.example.com:6443${NC}"
  exit 1
fi

if ! $FORCE && ! $DRY_RUN; then
  echo "  This will revert changes from questions: ${QUESTIONS_TO_CLEAN[*]}"
  read -p "  Continue? (y/N): " confirm
  [[ "$confirm" != [yY]* ]] && echo "  Aborted." && exit 0
fi

echo ""

for q in "${QUESTIONS_TO_CLEAN[@]}"; do
  echo -e "  ${BOLD}── Q${q} ──${NC}"
  case $q in
    1)
      run_cmd "Remove HTPasswd secret" "oc delete secret ex280-idp-secret -n openshift-config"
      run_cmd "Remove IDP from OAuth (restore default)" "oc patch oauth/cluster --type=json -p='[{\"op\":\"remove\",\"path\":\"/spec/identityProviders\"}]'"
      run_cmd "Delete users" "for u in armstrong collins aldrin jobs wozniak; do oc delete user \$u 2>/dev/null; oc delete identity ex280-htpasswd:\$u 2>/dev/null; done"
      ;;
    2)
      run_cmd "Remove cluster-admin from jobs" "oc adm policy remove-cluster-role-from-user cluster-admin jobs"
      run_cmd "Restore self-provisioner to authenticated" "oc adm policy add-cluster-role-to-group self-provisioner system:authenticated:oauth"
      run_cmd "Remove self-provisioner from wozniak" "oc adm policy remove-cluster-role-from-user self-provisioner wozniak"
      echo -e "  ${YELLOW}⚠  kubeadmin secret cannot be restored (recreate cluster if needed)${NC}"
      ;;
    3)
      run_cmd "Delete project apollo" "oc delete project apollo --wait=false"
      run_cmd "Delete project manhattan" "oc delete project manhattan --wait=false"
      run_cmd "Delete project gemini" "oc delete project gemini --wait=false"
      run_cmd "Delete project bluebook" "oc delete project bluebook --wait=false"
      run_cmd "Delete project titan" "oc delete project titan --wait=false"
      ;;
    4)
      run_cmd "Delete group commander" "oc delete group commander"
      run_cmd "Delete group pilot" "oc delete group pilot"
      ;;
    5)
      run_cmd "Delete quota ex280-quota in manhattan" "oc delete resourcequota ex280-quota -n manhattan"
      ;;
    6)
      run_cmd "Delete limitrange ex280-limits in bluebook" "oc delete limitrange ex280-limits -n bluebook"
      ;;
    7)
      run_cmd "Delete project bullwinkle" "oc delete project bullwinkle --wait=false"
      ;;
    8)
      run_cmd "Delete project gru" "oc delete project gru --wait=false"
      ;;
    9)
      run_cmd "Delete HPA hydra in lerna" "oc delete hpa hydra -n lerna"
      run_cmd "Delete project lerna" "oc delete project lerna --wait=false"
      ;;
    10)
      run_cmd "Delete project area51" "oc delete project area51 --wait=false"
      run_cmd "Remove generated cert files" "rm -f ex280.key ex280.csr ex280.crt"
      ;;
    11)
      run_cmd "Delete secret magic in math" "oc delete secret magic -n math"
      ;;
    12)
      run_cmd "Remove env from deployment monday" "oc set env deployment/monday --from=secret/magic --remove -n math 2>/dev/null || true"
      run_cmd "Delete project math" "oc delete project math --wait=false"
      ;;
    13)
      run_cmd "Remove SCC from ex280sa" "oc adm policy remove-scc-from-user anyuid -z ex280sa -n apples"
      run_cmd "Delete SA ex280sa" "oc delete sa ex280sa -n apples"
      ;;
    14)
      run_cmd "Delete project apples" "oc delete project apples --wait=false"
      ;;
    15)
      run_cmd "Uninstall helm release example-app" "helm uninstall example-app 2>/dev/null"
      run_cmd "Remove helm repo do280-repo" "helm repo remove do280-repo 2>/dev/null"
      ;;
    16)
      run_cmd "Remove must-gather archives" "rm -rf ~/must-gather*.tar.gz ~/must-gather.local.*"
      ;;
    17)
      run_cmd "Delete project probes" "oc delete project probes --wait=false"
      ;;
    18)
      run_cmd "Remove cluster-admin from jupiter" "oc adm policy remove-cluster-role-from-user cluster-admin system:serviceaccount:scheduled:jupiter"
      run_cmd "Delete project scheduled" "oc delete project scheduled --wait=false"
      ;;
    19)
      run_cmd "Delete NetworkPolicy mysql-db-conn" "oc delete networkpolicy mysql-db-conn -n database"
      run_cmd "Delete project database" "oc delete project database --wait=false"
      ;;
    20)
      run_cmd "Delete PVC landing-pvc" "oc delete pvc landing-pvc"
      run_cmd "Delete PV landing-pv" "oc delete pv landing-pv"
      ;;
    21)
      run_cmd "Delete template from openshift-config" "oc delete template project-request -n openshift-config"
      run_cmd "Remove projectRequestTemplate from cluster config" "oc patch project.config.openshift.io/cluster --type=json -p='[{\"op\":\"remove\",\"path\":\"/spec/projectRequestTemplate\"}]'"
      run_cmd "Delete test project" "oc delete project test-template --wait=false"
      ;;
  esac
  echo ""
done

echo -e "  ${GREEN}✅ Cleanup complete.${NC}"
echo ""
