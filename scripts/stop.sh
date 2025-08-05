#!/bin/bash
source scripts/utils.sh

echo "🛑 Stopping all Besu validator containers..."

for i in 1 2 3 4; do
  echo "➡️ Stopping validator $i..."
  sshpass_exec $i "cd ~/besu-node && docker-compose --env-file validator.env down"
done

echo "✅ All validators stopped."
