# OpenShift Day-2 Operations - GitOps Bootstrap
# Red Hat Consulting

.PHONY: help bootstrap status clean

help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

bootstrap: ## Install GitOps Operator and deploy App of Apps
	@echo "🚀 Starting OpenShift GitOps Bootstrap..."
	cd ansible && ansible-playbook -i inventories/production/hosts.yaml playbooks/bootstrap-gitops.yaml -v

status: ## Check GitOps and applications status
	@echo "📊 Checking GitOps Status..."
	@echo "OpenShift GitOps Operator:"
	@oc get subscription openshift-gitops-operator -n openshift-operators 2>/dev/null || echo "Not installed"
	@echo "\nArgoCD Instance:"
	@oc get argocd -n openshift-gitops 2>/dev/null || echo "Not ready"
	@echo "\nApplications:"
	@oc get applications -n openshift-gitops 2>/dev/null || echo "No applications found"
	@echo "\nDay-2 Application Status:"
	@oc get applications -n openshift-gitops -o custom-columns=NAME:.metadata.name,SYNC:.status.sync.status,HEALTH:.status.health.status 2>/dev/null || echo "No applications found"

clean: ## Remove all GitOps components
	@echo "🧹 Cleaning up GitOps components..."
	@echo "Removing applications..."
	@oc delete applications --all -n openshift-gitops --ignore-not-found=true
	@echo "Removing ArgoCD instance..."
	@oc delete argocd --all -n openshift-gitops --ignore-not-found=true  
	@echo "Removing GitOps operator..."
	@oc delete subscription openshift-gitops-operator -n openshift-operators --ignore-not-found=true
	@oc delete clusterserviceversion -n openshift-operators -l operators.coreos.com/openshift-gitops-operator.openshift-operators --ignore-not-found=true
	@echo "✅ Cleanup complete"

login: ## Login to OpenShift cluster (interactive)
	@echo "🔐 Please login to your OpenShift cluster:"
	@oc login

.DEFAULT_GOAL := help