#!/bin/bash
set -e

# Load helper functions
source scripts/utils.sh

# Determine mode (default = remote)
MODE=${1:-remote}

echo "=================================================="
echo "🚀 Starting Besu Network in [$MODE] mode"
echo "=================================================="

if [ "$MODE" = "local" ]; then
  echo "🖥️ Starting local Besu QBFT network..."
  echo "--------------------------------------------------"

  # Ensure docker-compose-local.yml exists
  if [ ! -f "docker-compose-local.yml" ]; then
    echo "❌ Error: docker-compose-local.yml not found!"
    echo "Please make sure it exists in the project root."
    exit 1
  fi

  # Create data directories if not exist
  for i in {1..4}; do
    mkdir -p data/validator$i keys/validator$i
  done

  # Start network
  echo "🐳 Launching local Besu containers..."
  docker compose -f docker-compose-local.yml up -d

  echo "✅ Local Besu validators are now running."
  echo "--------------------------------------------------"
  docker ps --filter "name=validator" --format "table {{.Names}}\t{{.Status}}"

else
  echo "🌐 Starting remote Besu network on all validators..."
  echo "--------------------------------------------------"

  for i in {1..4}; do
    echo "▶️ Starting Validator $i..."
    sshpass_exec $i "cd ~/besu-node && docker compose up -d"
  done

  echo "✅ Remote Besu validators started successfully."
fi

echo "=================================================="
echo "🎉 Besu network started successfully in [$MODE] mode!"
echo "=================================================="
