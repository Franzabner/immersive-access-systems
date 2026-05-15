#!/usr/bin/env bash
set -u

missing=0

required_files=(
  "AGENTS.md"
  "README.md"
  "STATUS.md"
  "PUBLIC_BOUNDARY.md"
  "CLAIMS.md"
  "VALIDATION.md"
  "ARTIFACT_REGISTER.md"
  "REVIEW_LOG.md"
  "package.json"
  "tsconfig.json"
  "operator-portals/README.md"
  "operator-portals/synthetic-operator-portal-boundary.md"
  "immersive-access/README.md"
  "immersive-access/public-safe-immersive-access-pattern.md"
  "spatial-infrastructure-interfaces/README.md"
  "spatial-infrastructure-interfaces/spatial-interface-template.md"
  "walkthrough-patterns/README.md"
  "walkthrough-patterns/vr-ar-walkthrough-boundary.md"
  "digital-twin-interactions/README.md"
  "digital-twin-interactions/digital-twin-interaction-policy.md"
  "human-machine-access-surfaces/README.md"
  "human-machine-access-surfaces/hmi-access-boundary.md"
  "cad-to-usd-pipeline/README.md"
  "cad-to-usd-pipeline/synthetic-cad-to-usd-pipeline-note.md"
  "public-safe-scenes/README.md"
  "public-safe-scenes/scene-publication-policy.md"
  "dashboard-patterns/README.md"
  "dashboard-patterns/dashboard-scaffold-template.md"
  "diagrams/README.md"
  "diagrams/immersive-access-boundary-flow.mmd"
  "validation/README.md"
  "validation/scene-dashboard-review-checklist.md"
  "scripts/validate-public-boundary.sh"
  "templates/spatial-interface-review-template.md"
  "templates/scene-boundary-template.md"
)

for file in "${required_files[@]}"; do
  if [ -f "$file" ]; then
    printf "PASS %s\n" "$file"
  else
    printf "FAIL %s\n" "$file"
    missing=$((missing + 1))
  fi
done

required_terms=(
  "planned"
  "scaffolded"
  "published"
  "released"
  "private/not-public"
  "deployed portals"
  "production dashboards"
  "live telemetry"
  "production USD"
  "private CAD"
  "real facility"
  "private topology"
  "credentials"
  "customer assets"
  "live access"
  "private telemetry"
  "sealed geometry"
  "validation"
  "review"
)

for term in "${required_terms[@]}"; do
  if rg -q "$term" .; then
    printf "PASS term: %s\n" "$term"
  else
    printf "FAIL term: %s\n" "$term"
    missing=$((missing + 1))
  fi
done

blocked_files="$(find . -path ./.git -prune -o \( -iname '*.usd' -o -iname '*.usda' -o -iname '*.usdc' -o -iname '*.f3d' -o -iname '*.step' -o -iname '*.stp' -o -iname '*.key' -o -iname '*.pem' -o -iname '*.env' -o -iname '*.log' \) -print)"
if [ -z "$blocked_files" ]; then
  printf "PASS blocked artifact scan\n"
else
  printf "FAIL blocked artifact scan\n%s\n" "$blocked_files"
  missing=$((missing + 1))
fi

if [ "$missing" -eq 0 ]; then
  printf "Result: PASS - immersive access public boundary scaffold is complete.\n"
else
  printf "Result: FAIL - %s required checks failed.\n" "$missing"
fi

exit "$missing"

