#!/bin/bash
###############################################################################
#  EX280 OpenShift Administration 4.18 — Question Runner
#  Usage: bash scripts/run-question.sh "Question-1 HTPasswd-IDP"
###############################################################################

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BASE_DIR="$(dirname "$SCRIPT_DIR")"

if [ -z "$1" ]; then
  echo ""
  echo "  Usage: bash scripts/run-question.sh <question-directory>"
  echo ""
  echo "  Available questions:"
  echo "    Question-1  HTPasswd-IDP           — Configure HTPasswd Identity Provider"
  echo "    Question-2  Cluster-Permissions    — Configure Cluster Permissions (RBAC)"
  echo "    Question-3  Project-Permissions    — Configure Project Permissions"
  echo "    Question-4  Configure-Groups       — Configure Groups"
  echo "    Question-5  Resource-Quota         — Configure Resource Quotas"
  echo "    Question-6  LimitRange             — Configure LimitRange"
  echo "    Question-7  Deploy-App-Route       — Deploy Application with Route"
  echo "    Question-8  Manual-Scale           — Scale Application Manually"
  echo "    Question-9  Autoscale-HPA          — Autoscale Application (HPA)"
  echo "    Question-10 Secure-Route           — Configure Secure Route (Edge TLS)"
  echo "    Question-11 Create-Secret          — Create a Secret"
  echo "    Question-12 Use-Secret             — Use Secret in Application"
  echo "    Question-13 Service-Account-SCC    — Service Account with SCC"
  echo "    Question-14 Deploy-With-SA         — Deploy with Service Account"
  echo "    Question-15 Helm-Chart             — Install Helm Chart"
  echo "    Question-16 Must-Gather            — Collect Cluster Information"
  echo "    Question-17 Liveness-Probe         — Configure Liveness Probe"
  echo "    Question-18 CronJob-SA             — CronJob with Service Account"
  echo "    Question-19 NetworkPolicy          — Create NetworkPolicy"
  echo "    Question-20 PV-PVC                 — Create PV and PVC"
  echo "    Question-21 Project-Template       — Configure Project Template"
  echo ""
  echo "  Example: bash scripts/run-question.sh \"Question-7 Deploy-App-Route\""
  echo ""
  exit 0
fi

QUESTION_DIR="$BASE_DIR/$1"

if [ ! -d "$QUESTION_DIR" ]; then
  echo "ERROR: Directory not found: $QUESTION_DIR"
  echo "Run without arguments to see available questions."
  exit 1
fi

echo ""
echo "═══════════════════════════════════════════════════════════════════════"
echo "  Running Lab Setup..."
echo "═══════════════════════════════════════════════════════════════════════"
bash "$QUESTION_DIR/LabSetUp.bash"

echo ""
echo "═══════════════════════════════════════════════════════════════════════"
echo "  Question:"
echo "═══════════════════════════════════════════════════════════════════════"
bash "$QUESTION_DIR/Questions.bash"

echo ""
echo "═══════════════════════════════════════════════════════════════════════"
echo "  When ready, validate with:"
QNUM=$(echo "$1" | grep -oP '^\d+|(?<=Question-)\d+')
echo "    bash scripts/validate-ex280.sh $QNUM"
echo ""
echo "  For solution hints:"
echo "    bash \"$1/SolutionNotes.bash\""
echo "═══════════════════════════════════════════════════════════════════════"
echo ""
