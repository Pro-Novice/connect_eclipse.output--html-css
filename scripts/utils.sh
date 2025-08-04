#!/bin/bash
source ../.env

# Get IP and password for a given validator number (1-4)
get_vm_ip() {
  local num=$1
  echo "${!VM_IP_VAR:-$(eval echo \${VALIDATOR${num}_IP})}"
}

get_vm_pass() {
  local num=$1
  echo "${!VM_PASS_VAR:-$(eval echo \${VALIDATOR${num}_PASS})}"
}

# SSH run
sshpass_exec() {
  local num=$1
  shift
  local ip=$(get_vm_ip $num)
  local pass=$(get_vm_pass $num)

  sshpass -p "$pass" ssh -o StrictHostKeyChecking=no $VALIDATOR_USER@$ip "$@"
}

# SCP copy
sshpass_copy() {
  local num=$1
  local src=$2
  local dest=$3
  local ip=$(get_vm_ip $num)
  local pass=$(get_vm_pass $num)

  sshpass -p "$pass" scp -o StrictHostKeyChecking=no $src $VALIDATOR_USER@$ip:$dest
}
