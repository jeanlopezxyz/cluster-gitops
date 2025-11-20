# Repository Guidelines

## Project Structure & Module Organization
- `playbooks/`: Entry playbooks (e.g., `bootstrap-gitops.yaml`).
- `roles/`: Ansible roles (e.g., `gitops-bootstrap/` tasks, defaults, meta).
- `inventories/`: Environment inventories (default: `production/hosts.yaml`).
- `group_vars/`: Global vars (e.g., GitOps and display settings).
- `ansible.cfg`: Defaults (inventory, roles path, logging).
- `requirements.yaml`: Galaxy collections to install.
- `Makefile`: Common developer commands.

## Build, Test, and Development Commands
- `ansible-galaxy install -r requirements.yaml`: Install required collections.
- `make bootstrap CLUSTER=<name>`: Installs GitOps operator and App of Apps.
- `make status`: Prints cluster, GitOps, and Day‑2 status via `oc`.
- `make clean`: Removes logs and temp files.
- Direct run example: `ansible-playbook playbooks/bootstrap-gitops.yaml -e cluster_name=telefonica-prod -v`.

## Coding Style & Naming Conventions
- YAML: 2‑space indent; lists with `-`; no tabs.
- Filenames: lowercase, hyphen‑separated (e.g., `app-of-apps.yaml`).
- Variables: `snake_case`; group long structures under a key (e.g., `app_of_apps`).
- Roles: keep idempotent; split into small task files; prefer `kubernetes.core.*` modules over shell.
- Logging: rely on `ansible.cfg` `log_path=./ansible.log` for troubleshooting.

## Testing Guidelines
- Dry run: `ansible-playbook ... --check --diff` before applying.
- Scope with tags (e.g., `--tags app_of_apps` or `--tags debug`).
- Validate cluster context: `oc whoami`; inspect outcomes with `make status`.
- Add assertions where possible; avoid destructive changes without guards.

## Commit & Pull Request Guidelines
- Commits: imperative mood, concise subject (≤72 chars), include context in body.
  Examples: `feat(role): add argocd sync options`, `fix(playbook): correct default cluster_name`.
- PRs: describe intent, scope, and rollout plan; link issues; include sample command lines and expected outcomes; attach screenshots of ArgoCD when relevant.

## Security & Configuration Tips
- Do not commit secrets; use Ansible Vault or cluster secrets.
- Keep inventories environment‑specific; default inventory is set in `ansible.cfg`.
- Require `oc login` before running Make targets; verify access with `make status`.
