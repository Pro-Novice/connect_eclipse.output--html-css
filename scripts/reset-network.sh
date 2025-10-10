#!/bin/bash
source scripts/utils.sh

echo "⚠️  WARNING: This will stop all validator containers and delete chain data!"
read -p "Proceed? (yes/no): " confirm

if [ "$confirm" != "yes" ]; then
  echo "❌ Aborted."
  exit 1
fi

for i in 1 2 3 4; do
  echo "🔄 Resetting validator $i..."

  sshpass_exec $i "
    cd ~/besu-node &&
    docker-compose --env-file validator.env down &&
    rm -rf ~/besu-node/data/*
  "

  echo "✅ Validator $i reset."
done

echo ""
echo "🧹 All validator data directories wiped. You can now re-run: ./scripts/setup.sh"
