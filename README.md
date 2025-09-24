# Besu QBFT – Docker Compose Setup

This repository contains a **Docker Compose** setup for running a local [Hyperledger Besu](https://besu.hyperledger.org/) network using the **QBFT consensus algorithm**.  
Helper scripts are included for setup, logging, deployment, and reset.

---

## 🚀 Usage

Start the network:

```bash
./scripts/setup.sh
./scripts/logs.sh validator{1,2,3,4}
./scripts/deploy.sh


# Stop the network:
./scripts/stop.sh

# Reset the network (wipe data, re-genesis):
./scripts/reset.sh

# 📂 Data Persistence

# Each validator’s blockchain data is stored in the data/ directory and mounted as a volume in Docker. This ensures data persists across restarts.

# To manually reset data and start fresh:
rm -rf ./data/validator{1,2,3,4}/*
#  Or just run 
./scripts/reset.sh



