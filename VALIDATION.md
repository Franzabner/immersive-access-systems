# Validation

Run:

```bash
test -f README.md
test -f PUBLIC_BOUNDARY.md
test -f scripts/validate-public-boundary.sh
bash scripts/validate-public-boundary.sh
rg -n "planned|scaffolded|published|released|private/not-public|deployed portals|production dashboards|live telemetry|production USD|private CAD|real facility|private topology|credentials|customer assets|live access|private telemetry|sealed geometry|validation|review" .
git diff --check
git status --short
git remote -v
```

