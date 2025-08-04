#!/bin/bash
source scripts/utils.sh

if [ -z "$1" ]; then
  echo "❌ Usage: ./scripts/logs.sh <validator_number (1–4)>"
  exit 1
fi

i=$1
if ! [[ "$i" =~ ^[1-4]$ ]]; then
  echo "❌ Invalid validator number. Use 1, 2, 3, or 4."
  exit 1
fi

echo "📄 Fetching logs for validator$i..."
sshpass_exec $i "docker logs -f validator$i"
