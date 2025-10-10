#!/bin/bash
set -e
source scripts/utils.sh

MODE=${1:-remote}  # default mode = remote

echo "=================================================="
echo "🛑 Stopping Besu network in [$MODE] mode"
echo "=================================================="

if [ "$MODE" = "local" ]; then
  echo "🖥️ Stopping local Besu validators..."
  echo "--------------------------------------------------"

  if [ -f "docker-compose-local.yml" ]; then
    docker compose -f docker-compose-local.yml down -v
    echo "✅ Local Besu network stopped and volumes removed."
  else
    echo "❌ Error: docker-compose-local.yml not found!"
    exit 1
  fi

else
  echo "🌐 Stopping remote Besu validators on all VMs..."
  echo "--------------------------------------------------"

  for i in {1..4}; do
    echo "➡️ Stopping Validator $i..."
    sshpass_exec $i "cd ~/besu-node && docker compose --env-file validator.env down -v || true"
  done

  echo "✅ All remote validators stopped successfully."
fi

echo "=================================================="
echo "🧹 Cleanup complete for [$MODE] mode"
echo "=================================================="
