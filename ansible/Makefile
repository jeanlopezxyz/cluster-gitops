# OpenShift Day-2 Operations - Simple Makefile
# Red Hat Consulting

.PHONY: help bootstrap status clean

# Variables
CLUSTER ?= telefonica-prod
ANSIBLE_OPTS ?= -v

# Default target
help:
	@echo "OpenShift Day-2 Operations - Red Hat Consulting"
	@echo "GitOps Pattern: Ansible only installs GitOps, ArgoCD manages everything else"
	@echo ""
	@echo "Available targets:"
	@echo "  help           - Show this help message"
	@echo "  bootstrap      - Install GitOps operator + App of Apps (GitOps handles rest)"
	@echo "  status         - Check cluster and applications status"
	@echo "  clean          - Clean temporary files"
	@echo ""
	@echo "Examples:"
	@echo "  make bootstrap CLUSTER=cluster-bqkh8"
	@echo ""
	@echo "After bootstrap, ArgoCD automatically deploys Day-2 applications"

# Bootstrap GitOps
bootstrap:
	@echo "🚀 Bootstrapping GitOps for cluster: $(CLUSTER)"
	@oc whoami || (echo "❌ Not connected to OpenShift. Run 'oc login' first." && exit 1)
	ansible-playbook playbooks/bootstrap-gitops.yaml $(ANSIBLE_OPTS) \
		-e cluster_name=$(CLUSTER)

# Note: No deploy target - ArgoCD handles all application deployment

# Check status
status:
	@echo "📊 Cluster Status:"
	@echo "User: $$(oc whoami 2>/dev/null || echo 'Not connected')"
	@echo "Version: $$(oc get clusterversion -o jsonpath='{.items[0].status.desired.version}' 2>/dev/null || echo 'Unknown')"
	@echo ""
	@echo "📊 GitOps Status:"
	@echo "ArgoCD URL: https://$$(oc get route openshift-gitops-server -n openshift-gitops -o jsonpath='{.spec.host}' 2>/dev/null || echo 'Not available')"
	@echo "Applications: $$(oc get applications -n openshift-gitops --no-headers 2>/dev/null | wc -l || echo '0')"
	@echo ""
	@echo "📊 Day-2 Status:"
	@echo "MachineConfigs:" 
	@oc get machineconfigs 2>/dev/null | grep -E "(timezone|tuning)" || echo "None found"

# Clean temporary files
clean:
	@echo "🧹 Cleaning temporary files..."
	@rm -f ansible.log *.retry
	@find . -name "*.pyc" -delete
	@find . -name "__pycache__" -delete