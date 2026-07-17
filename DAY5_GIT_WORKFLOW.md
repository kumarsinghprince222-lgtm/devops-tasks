# Enterprise Git Branching & Azure Repos Workflow

## Branching Model
- `main`: Production-ready code. Protected branch; no direct commits allowed.
- `feature/*`: Short-lived branches for new deliverables or infrastructure tasks.
- `bugfix/*`: Emergency fixes for deployment scripts.

## Pull Request Guidelines
1. All feature branches must be tested locally before submitting a PR.
2. At least 1 peer review / sign-off required for merging into `main`.
3. Commits must follow conventional syntax (e.g., `feat:`, `fix:`, `docs:`).
