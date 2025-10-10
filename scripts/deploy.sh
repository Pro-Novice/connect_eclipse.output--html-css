#!/bin/bash
source scripts/utils.sh

for i in 1 2 3 4; do
  echo "🚀 Deploying to Validator $i..."

  # Create the base folder and keys directory on remote VM
  sshpass_exec $i "mkdir -p ~/besu-node/keys/validator$i ~/besu-node/data"

  # Copy required config files
  sshpass_copy $i docker-compose.yml ~/besu-node/docker-compose.yml
  sshpass_copy $i common-config.toml ~/besu-node/common-config.toml
  sshpass_copy $i genesis.json ~/besu-node/genesis.json
  sshpass_copy $i keys/validator$i/key ~/besu-node/keys/validator$i/key
  sshpass_copy $i env/validator$i.env ~/besu-node/validator.env
done
