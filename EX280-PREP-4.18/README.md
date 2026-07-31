# EX280-PREP-4.18 — Red Hat OpenShift Administration Practice Lab

Practice lab for the **EX280 Red Hat Certified Specialist in OpenShift Administration** exam (OpenShift 4.18), with automated validation and scoring.

## Classroom Environment

This lab is configured for the **DO280 Red Hat OpenShift Administration** classroom environment.

### Classroom Machines

| Machine | IP | Role |
|---------|-----|------|
| bastion.lab.example.com | 172.25.250.254 | Router that links VMs to central servers |
| classroom.lab.example.com | 172.25.252.254 | Server that hosts classroom materials |
| idm.ocp4.example.com | 192.168.50.40 | Identity management (LDAP/auth) |
| master01.ocp4.example.com | 192.168.50.10 | RHOCP single-node (SNO) cluster |
| registry.ocp4.example.com | 192.168.50.50 | Private Quay registry + GitLab |
| utility.lab.example.com | 192.168.50.254 | DHCP, NFS, routing to cluster network |
| workstation.lab.example.com | 172.25.250.9 | Graphical workstation (student use) |

### RHOCP Access Methods

| Access Method | Endpoint |
|---------------|----------|
| Web Console | https://console-openshift-console.apps.ocp4.example.com |
| API | https://api.ocp4.example.com:6443 |
| Registry | https://registry.ocp4.example.com:8443/ |
| Apps Domain | *.apps.ocp4.example.com |

### Credentials

| Account | Password | Role |
|---------|----------|------|
| developer | developer | Standard user |
| admin | redhatocp | Cluster admin |
| kubeadmin | (from install) | Cluster admin |

### Networks

| Network | Subnet | Purpose |
|---------|--------|---------|
| Student network | 172.25.250.0/24 | Student machines |
| Classroom network | 172.25.252.0/24 | Classroom services |
| Cluster network | 192.168.50.0/24 | RHOCP cluster (isolated) |

## Quick Start

```bash
# Extract and enter the lab
unzip EX280-PREP-4.18.zip && cd EX280-PREP-4.18

# Login to the cluster (from workstation)
oc login -u admin -p redhatocp https://api.ocp4.example.com:6443

# Run a specific question
bash scripts/run-question.sh "Question-1 HTPasswd-IDP"

# Validate your answer
bash scripts/validate-ex280.sh 1

# Validate all questions
bash scripts/validate-ex280.sh

# Clean up after practice
bash scripts/cleanup-ex280.sh
```

## Questions Overview (21 Tasks, 70% to Pass)

| Q# | Topic | Domain | Weight |
|----|-------|--------|--------|
| Q1 | HTPasswd Identity Provider | Authentication & Authorization | 7% |
| Q2 | Cluster Permissions (RBAC) | Authorization & RBAC | 7% |
| Q3 | Project Permissions | Authorization & RBAC | 5% |
| Q4 | Configure Groups | Authorization & RBAC | 5% |
| Q5 | Resource Quota | Resource Management | 5% |
| Q6 | LimitRange | Resource Management | 5% |
| Q7 | Deploy Application with Route | Application Deployment | 5% |
| Q8 | Manual Scale | Application Management | 3% |
| Q9 | Autoscale (HPA) | Application Management | 5% |
| Q10 | Secure Route (Edge TLS) | Networking & Routes | 7% |
| Q11 | Create Secret | Configuration & Secrets | 4% |
| Q12 | Use Secret in Application | Configuration & Secrets | 4% |
| Q13 | Service Account with SCC | Security | 5% |
| Q14 | Deploy with Service Account | Application Deployment & Security | 4% |
| Q15 | Helm Chart Installation | Application Deployment | 5% |
| Q16 | Must-Gather | Cluster Maintenance | 3% |
| Q17 | Liveness Probe | Application Health | 5% |
| Q18 | CronJob with Service Account | Workload Management | 5% |
| Q19 | NetworkPolicy | Networking & Security | 7% |
| Q20 | PV and PVC (NFS) | Storage | 7% |
| Q21 | Project Template | Cluster Configuration | 5% |

## Scripts

| Script | Purpose |
|--------|---------|
| `scripts/run-question.sh` | Setup environment and display question |
| `scripts/validate-ex280.sh` | Validate answers with weighted scoring |
| `scripts/cleanup-ex280.sh` | Revert all changes made during exercises |

## Validation Examples

```bash
# Validate a single question
bash scripts/validate-ex280.sh 5

# Validate multiple questions
bash scripts/validate-ex280.sh 1 2 3 4

# Validate all (full exam simulation)
bash scripts/validate-ex280.sh
```

## Cleanup Examples

```bash
# Preview what would be cleaned (no changes)
bash scripts/cleanup-ex280.sh --dry-run

# Clean specific questions
bash scripts/cleanup-ex280.sh 7 8 9

# Clean everything without confirmation
bash scripts/cleanup-ex280.sh --force
```

## Environment-Specific Notes

- **Container images** are pulled from the private registry at `registry.ocp4.example.com:8443`
- **NFS storage** is provided by `utility.lab.example.com` (192.168.50.254)
- **Helm charts** are served from `http://helm.ocp4.example.com/charts`
- **LDAP/IdM** is available at `idm.ocp4.example.com` for authentication exercises
- The cluster is a **Single-Node OpenShift (SNO)** on `master01.ocp4.example.com`
- All exercises should be run from the **workstation** machine

## Recommended Workflow

1. Login to workstation as `student` (password: `student`)
2. SSH or use the graphical desktop
3. Login to OCP: `oc login -u admin -p redhatocp https://api.ocp4.example.com:6443`
4. Start with Q1 (HTPasswd) as many other questions depend on users existing
5. Complete Q2-Q4 (RBAC/Groups) next for the same reason
6. Q5-Q21 can be done in any order
7. Run the full validator at the end to simulate exam conditions
8. Use cleanup script to reset and practice again

## EX280 Exam Domains Covered

| Domain | Questions |
|--------|-----------|
| Authentication & Authorization | Q1, Q2, Q3, Q4 |
| Resource Management | Q5, Q6 |
| Application Deployment | Q7, Q8, Q9, Q14, Q15 |
| Networking & Routes | Q10, Q19 |
| Configuration & Secrets | Q11, Q12 |
| Security | Q13, Q14, Q18 |
| Storage | Q20 |
| Cluster Configuration & Maintenance | Q16, Q17, Q21 |
