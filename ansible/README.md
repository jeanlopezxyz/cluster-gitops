# OpenShift Day-2 Operations - Ansible Automation

Red Hat Consulting automation for OpenShift Day-2 operations using GitOps.

## Quick Start

```bash
# 1. Install dependencies
ansible-galaxy collection install -r requirements.yaml

# 2. Deploy Helm repository on bastion
make helm-repo -e "bastion_ip=<BASTION_IP>"

# 3. Connect to OpenShift and bootstrap GitOps
oc login --token=your-token --server=https://your-cluster:6443
make bootstrap

# 4. Check status
make status
```

## Structure

```
ansible/
├── playbooks/
│   ├── bootstrap-gitops.yaml   # GitOps operator + App of Apps
│   └── deploy-helm-repo.yaml   # Helm repository on bastion
├── roles/
│   ├── gitops-bootstrap/       # Install OpenShift GitOps
│   └── helm-repository/        # Deploy Helm repo with httpd
├── inventories/production/
│   ├── hosts.yaml              # Hosts configuration
│   └── group_vars/all.yaml     # Global variables
└── requirements.yaml           # Ansible collections
```

## Configuration

Edit `inventories/production/group_vars/all.yaml` for:
- Helm repository URL
- Git repository and branch
- Cluster-specific settings

## GitOps Pattern

1. **Ansible**: Installs GitOps operator + deploys App of Apps
2. **ArgoCD**: Manages all Day-2 applications automatically
3. **Helm Repository**: Charts served from bastion via httpd
