# OpenShift Day-2 Operations - Ansible Automation

Red Hat Consulting automation for OpenShift Day-2 operations using GitOps.

## Quick Start

```bash
# 1. Connect to OpenShift cluster
oc login --token=your-token --server=https://your-cluster:6443

# 2. Bootstrap GitOps
make bootstrap CLUSTER=your-cluster

# 3. Check status (ArgoCD automatically deploys Day-2 apps)
make status
```

## Available Commands

| Command | Description |
|---------|-------------|
| `make bootstrap` | Install GitOps operator + App of Apps (ArgoCD handles rest) |
| `make status` | Check cluster and applications status |
| `make clean` | Clean temporary files |

**Note**: Following tjungbauer pattern - Ansible only bootstraps GitOps, ArgoCD manages all applications.

## Configuration

Edit variables in:
- `group_vars/all.yaml` - Global Day-2 configuration
- `inventories/production/hosts.yaml` - Cluster-specific settings

## Day-2 Applications

- **node-timezone**: Configure timezone (America/Santiago)
- **node-tuning**: Max pods and system resources  
- **cluster-oauth**: HTPasswd identity provider
- **network-nmstate**: Network operator and VLANs

## Requirements

```bash
# Install dependencies
ansible-galaxy collection install kubernetes.core
pip3 install kubernetes openshift PyYAML
```

## Structure

```
ansible/
├── playbooks/
│   └── bootstrap-gitops.yaml    # GitOps operator + App of Apps
├── group_vars/all.yaml          # Global variables
├── inventories/production/      # Cluster inventory
└── Makefile                     # Simple command interface
```

## GitOps Pattern

This follows the **tjungbauer pattern**:

1. **Ansible**: Only installs GitOps operator + App of Apps
2. **ArgoCD**: Automatically manages all Day-2 applications
3. **Git Repository**: Contains all application definitions

Once bootstrap completes, ArgoCD monitors the Git repository and automatically deploys/updates applications.