# OpenShift Day-2 Operations - GitOps

Red Hat Consulting automation for OpenShift Day-2 operations using GitOps pattern.

## Structure

```
.
├── ansible/          # Ansible playbooks and roles
│   ├── playbooks/    # Bootstrap GitOps, deploy Helm repo
│   ├── roles/        # gitops-bootstrap, helm-repository
│   └── inventories/  # Production inventory
├── apps/             # ArgoCD applications configuration
│   └── cluster1/     # Cluster-specific values
├── charts/           # Helm charts
│   ├── helper-argocd/
│   ├── helper-operator/
│   ├── cluster-monitoring/
│   ├── cluster-oauth/
│   ├── etcd-backup/
│   ├── network-nmstate/
│   ├── node-timezone/
│   └── node-tuning/
└── Makefile          # Main commands
```

## Quick Start

```bash
# 1. Install Ansible dependencies
ansible-galaxy collection install -r ansible/requirements.yaml

# 2. Deploy Helm repository on bastion
make helm-repo -e "bastion_ip=<BASTION_IP>"

# 3. Connect to OpenShift and bootstrap GitOps
oc login --token=<TOKEN> --server=https://<API_SERVER>:6443
make bootstrap

# 4. Check status
make status
```

## Available Commands

| Command | Description |
|---------|-------------|
| `make help` | Show available commands |
| `make bootstrap` | Install GitOps operator and deploy App of Apps |
| `make helm-repo` | Deploy Helm repository on bastion |
| `make helm-repo-local` | Deploy Helm repository locally |
| `make package-charts` | Package all Helm charts |
| `make status` | Check GitOps and applications status |
| `make clean` | Remove GitOps components |

## GitOps Pattern

1. **Ansible**: Only bootstraps GitOps operator and App of Apps
2. **ArgoCD**: Manages all Day-2 applications automatically
3. **Helm Repository**: Charts served from bastion via httpd

## Day-2 Applications

- **node-timezone**: Configure node timezone
- **node-tuning**: Max pods and system tuning
- **cluster-monitoring**: Prometheus/Alertmanager configuration
- **cluster-oauth**: HTPasswd identity provider
- **network-nmstate**: Network operator and VLAN policies
- **etcd-backup**: Automated etcd backups
