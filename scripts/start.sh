#!/bin/bash
source scripts/utils.sh

echo "🚀 Starting all Besu validator containers..."

for i in 1 2 3 4; do
  echo "➡️ Starting validator $i..."
  sshpass_exec $i "cd ~/besu-node && docker-compose --env-file validator.env up -d"
done

echo "✅ All validators started."
