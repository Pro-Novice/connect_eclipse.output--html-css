#!/bin/bash
set -e
source scripts/utils.sh

MODE=${1:-remote}  # default = remote

GREEN='\033[0;32m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo "=================================================="
echo -e "${CYAN}📡 Checking container status of all Besu validators...${NC}"
echo "=================================================="

if [ "$MODE" = "local" ]; then
  echo -e "🖥️  ${CYAN}Local Mode:${NC} Checking Docker containers running locally..."
  echo "--------------------------------------------------"

  docker ps --filter "name=validator" --format "table {{.Names}}\t{{.Status}}" || {
    echo -e "${RED}❌ Error checking local containers${NC}"
    exit 1
  }

  echo "--------------------------------------------------"
  echo -e "${GREEN}✅ Local Besu network status check complete.${NC}"

else
  echo -e "🌐 ${CYAN}Remote Mode:${NC} Checking validator containers across all VMs..."
  echo "--------------------------------------------------"

  for i in {1..4}; do
    VM_IP=$(get_vm_ip $i)
    echo -n "🔍 Validator $i ($VM_IP): "

    STATUS=$(sshpass_exec $i "docker ps --filter 'name=validator$i' --format '{{.Status}}' 2>/dev/null" || echo "error")

    if [[ "$STATUS" == *"Up"* ]]; then
      echo -e "${GREEN}✅ RUNNING${NC}"
    elif [[ "$STATUS" == "error" ]]; then
      echo -e "${RED}⚠️  SSH/Connection Error${NC}"
    else
      echo -e "${RED}❌ NOT RUNNING${NC}"
    fi
  done

  echo "--------------------------------------------------"
  echo -e "${GREEN}✅ Remote Besu network status check complete.${NC}"
fi

echo "=================================================="
echo -e "${CYAN}Status check finished for mode [$MODE].${NC}"
echo "=================================================="
