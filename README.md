# OpenShift Day-2 Operations GitOps

This repository contains GitOps-based automation for OpenShift Day-2 operations using the App of Apps pattern.

## Repository Structure

This repository is organized using multiple branches for different components:

- **main**: Documentation and overview
- **charts**: Helm charts for Day-2 operations
- **apps**: App of Apps configurations for different clusters
- **ansible**: Ansible automation for GitOps bootstrap

## Branches

### Charts Branch
Contains reusable Helm charts for OpenShift Day-2 operations:
- `cluster-oauth`: OAuth authentication configuration
- `cluster-monitoring`: Monitoring configuration (Prometheus, Grafana, Alertmanager)
- `etcd-backup`: ETCD backup automation
- `network-nmstate`: Network configuration with NMState
- `node-timezone`: Node timezone configuration
- `node-tuning`: Node performance tuning
- `helper-argocd`: Helper chart for App of Apps pattern
- `helper-operator`: Helper chart for operator installation

### Apps Branch
Contains App of Apps configurations for different clusters:
- `cluster1/`: Production cluster configuration
- `cluster2/`: Development cluster configuration
- `cluster3/`: Testing cluster configuration
- `cluster4/`: Staging cluster configuration

### Ansible Branch
Contains Ansible automation for GitOps bootstrap:
- Bootstrap GitOps operator installation
- Deploy App of Apps pattern
- Initial cluster configuration

## Usage

### 1. Bootstrap GitOps (One-time setup)
```bash
# Clone the ansible branch
git clone -b ansible https://github.com/jeanlopezxyz/cluster-gitops.git
cd cluster-gitops

# Configure your cluster in inventories/production/hosts.yaml
# Run the bootstrap playbook
ansible-playbook playbooks/bootstrap-gitops.yaml
```

### 2. Customize for Your Environment
```bash
# Clone the apps branch
git clone -b apps https://github.com/jeanlopezxyz/cluster-gitops.git apps
cd apps

# Modify cluster configurations in cluster1/values.yaml
# Commit and push changes
git add .
git commit -m "Configure cluster1 for production"
git push origin apps
```

## Features

- **GitOps-based**: Declarative configuration management
- **App of Apps Pattern**: Scalable application deployment
- **Helper Charts**: Reusable components for common tasks
- **Multi-cluster Support**: Separate configurations for different environments
- **Sync Waves**: Ordered deployment of resources
- **Security-focused**: Proper RBAC and security contexts

## Day-2 Operations Covered

1. **Authentication**: HTPasswd and LDAP provider configuration
2. **Monitoring**: Cluster and user workload monitoring setup
3. **Backup**: Automated ETCD backup with retention policies
4. **Networking**: Advanced network configuration with NMState
5. **Node Configuration**: Timezone and performance tuning
6. **Security**: RBAC and security context configuration

## Contributing

1. Create feature branch from appropriate base branch
2. Make changes and test in development environment
3. Submit pull request with detailed description
4. Ensure all sync waves and dependencies are correct

## Red Hat Consulting
Developed by Red Hat Consulting for enterprise OpenShift deployments.