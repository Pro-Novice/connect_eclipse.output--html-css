#!/bin/bash
set -e
source scripts/utils.sh

echo "🛠️  Besu Validator Network Setup"

# Ask user if they want to reset everything
read -p "Do you want to reset the network before setup? (yes/no): " reset

if [ "$reset" = "yes" ]; then
  echo "🔄 Resetting network..."
  bash scripts/reset-network.sh
  echo ""
fi

echo "📦 Step 1: Deploying configs, keys, and env files..."
bash scripts/deploy.sh

echo ""
echo "🚀 Step 2: Starting all Besu validator containers..."
bash scripts/start.sh

echo ""
echo "📡 Step 3: Verifying node status..."
bash scripts/status.sh

echo ""
echo "✅ Setup complete. Besu validator network is live!"
