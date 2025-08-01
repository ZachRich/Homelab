#!/bin/bash
set -euo pipefail

echo "🗑️  Destroying infrastructure..."

cd "$(dirname "$0")/../terraform"

terraform destroy -auto-approve

echo "✅ Infrastructure destroyed!"