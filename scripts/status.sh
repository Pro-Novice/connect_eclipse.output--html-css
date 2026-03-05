#!/bin/bash
source scripts/utils.sh

echo "📡 Checking container status of all Besu validators..."

for i in 1 2 3 4; do
  VM_IP=$(get_vm_ip $i)
  echo -n "🔍 Validator $i ($VM_IP): "

  sshpass_exec $i "docker ps --filter 'name=validator$i' --format '{{.Status}}'" | grep -q 'Up'
  if [ $? -eq 0 ]; then
    echo "✅ RUNNING"
  else
    echo "❌ NOT RUNNING"
  fi
done
