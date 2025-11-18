# 🧱 Besu QBFT Modular Network Setup

This repository provides a **modular, script-driven Docker Compose setup** for deploying and managing a **Hyperledger Besu network** running the **QBFT consensus algorithm**.  
It supports both:
- 🖥️ **Local multi-validator setups** (using Docker Compose)
- 🌐 **Remote VM deployments** (via SSH + environment variables)

---

## 📁 Repository Structure

.
├── docker-compose.yml # Remote compose file
├── docker-compose-local.yml # Local 4-validator compose
├── genesis.json # Genesis configuration
├── common-config.toml # Shared node config
├── keys/validator{1..4}/key # Node private keys
├── data/validator{1..4}/ # Data directories
├── env/validator{1..4}.env # Per-node environment configs
├── scripts/
│ ├── deploy.sh # Copy config to remote VMs
│ ├── start.sh # Start network (local/remote)
│ ├── stop.sh # Stop network (local/remote)
│ ├── status.sh # Check validator status
│ ├── utils.sh # Common SSH helper functions
│ └── reset-network.sh # Reset data to genesis
└── .env # Global environment (IPs, user, passwords)

---

## ⚙️ Prerequisites

### 🧰 Required Tools

| Tool | Purpose | Install Command |
|------|----------|----------------|
| **Docker** | Run Besu containers | [Install Docker](https://docs.docker.com/get-docker/) |
| **Docker Compose** | Orchestrate multiple containers | Comes with Docker Desktop |
| **sshpass** | Required for remote SSH deployments | `brew install hudochenkov/sshpass/sshpass` (macOS) or `sudo apt install sshpass -y` (Linux) |

---


##  Explorer

# Blockscout Explorer Setup

Blockchain explorer for Rajasthan Agriculture Besu network.

## Prerequisites

- Docker & Docker Compose installed
- Besu blockchain validators running (RPC on port 8548)


## Quick Start

1. Start explorer
./manage_explorer.sh start

2. Access UI
Open browser: http://localhost:3001
3. Access API
http://localhost:4000/api/v2/stats


## Management Commands

./manage_explorer.sh start # Start all services
./manage_explorer.sh stop # Stop services (data persists)
./manage_explorer.sh down # Remove containers (data persists)
./manage_explorer.sh restart # Restart services
./manage_explorer.sh status # Show container status
./manage_explorer.sh logs # Stream all logs
./manage_explorer.sh cleanup # Remove ALL data (dangerous!)


## Services

| Service | Port | Description |
|---------|------|-------------|
| Frontend | 3001 | Web UI |
| Backend API | 4000 | REST API |
| PostgreSQL | 5432 | Database (internal) |
| Redis | 6379 | Cache (internal) |

## Configuration

Edit `blockscout-docker-compose.yml` to customize:

---


## 🚀 Running the Network

### 🖥️ Local Mode (Single System)

Runs 4 Besu validator nodes locally using `docker-compose-local.yml`.

#### ➕ Start Network
```bash
./scripts/start.sh local
./scripts/stop.sh local
./scripts/status.sh local
./scripts/stop.sh local && ./scripts/start.sh local
🌐 Remote Mode (Multi-VM Deployment)

Ensure your .env file includes valid SSH credentials and IPs:
# .env
VALIDATOR_USER=ubuntu
VALIDATOR1_IP=10.70.233.247
VALIDATOR2_IP=10.70.233.248
VALIDATOR3_IP=10.70.233.249
VALIDATOR4_IP=10.70.233.250
VALIDATOR1_PASS=myPass1
VALIDATOR2_PASS=myPass2
VALIDATOR3_PASS=myPass3
VALIDATOR4_PASS=myPass4
⚙️ Deploy Configurations
./scripts/deploy.sh remote
➕ Start Validators

./scripts/start.sh remote
📡 Check Status
./scripts/status.sh remote

💾 Data Persistence

Each validator stores blockchain data in data/validator{1..4}.
These directories are volume-mounted so data persists across restarts.

To reset the network from genesis:
rm -rf ./data/validator{1,2,3,4}/*

or simply run:
./scripts/reset-network.sh local

🧪 Stress Testing the Network

You can benchmark your network using the Pandoras-Box
 tool.
 Installation
 npm install -g pandoras-box

ETH Transfers
pandoras-box -url http://127.0.0.1:8545 \
  -m "exit warm sadness vault clip rent educate pluck gentle vehicle news verb" \
  -t 10000 -b 500 -s 100 -o ./myOutput.json

ERC20 Transfers
pandoras-box -url http://127.0.0.1:8545 \
  -m "exit warm sadness vault clip rent educate pluck gentle vehicle news verb" \
  -t 10000 -b 500 -s 10 --mode ERC20 -o ./myOutput.json

🧱 Build a Custom Besu Docker Image

You can build a local image for testing code changes to Besu itself.

From your Besu source directory:
./gradlew -Prelease.releaseVersion=24.3.3-local distDocker

Then update the image tag in your Compose file:
image: hyperledger/besu:24.3.3-local

Start with:
docker compose -f docker-compose-local.yml up -d


