#!/bin/bash
source "$(dirname "$0")/../.env"

get_vm_ip() {
  local num=$1
  eval echo "\$VALIDATOR${num}_IP"
}

get_vm_pass() {
  local num=$1
  eval echo "\$VALIDATOR${num}_PASS"
}

sshpass_exec() {
  local num=$1
  shift
  local ip=$(get_vm_ip $num)
  local pass=$(get_vm_pass $num)

  sshpass -p "$pass" ssh -o StrictHostKeyChecking=no $VALIDATOR_USER@$ip "$@"
}

sshpass_copy() {
  local num=$1
  local src=$2
  local dest=$3
  local ip=$(get_vm_ip $num)
  local pass=$(get_vm_pass $num)

  sshpass -p "$pass" scp -o StrictHostKeyChecking=no $src $VALIDATOR_USER@$ip:$dest
}
