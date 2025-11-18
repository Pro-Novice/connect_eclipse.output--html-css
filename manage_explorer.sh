#!/bin/bash
set -e

COMPOSE="blockscout-docker-compose.yml"

echo "Using compose file: $COMPOSE"

case "$1" in
    start)
        echo "Starting explorer..."
        docker compose -f $COMPOSE up -d
        ;;
    stop)
        echo "Stopping explorer..."
        docker compose -f $COMPOSE stop
        ;;
    down)
        echo "Stopping & removing containers (DB safe)..."
        docker compose -f $COMPOSE down
        ;;
    cleanup)
        echo "⚠️ THIS WILL DELETE DATABASE ALSO ⚠️"
        read -p "Type 'yes' to delete all data: " confirm
        if [ "$confirm" = "yes" ]; then
            docker compose -f $COMPOSE down -v --remove-orphans
        else
            echo "Cancelled."
        fi
        ;;
    status)
        docker compose -f $COMPOSE ps
        ;;
    logs)
        docker compose -f $COMPOSE logs -f --tail 50
        ;;
    *)
        echo "Usage:"
        echo "  ./manage_explorer.sh start        # Start explorer"
        echo "  ./manage_explorer.sh stop         # Stop containers"
        echo "  ./manage_explorer.sh down         # Stop & delete containers (DB safe)"
        echo "  ./manage_explorer.sh status       # Show running status"
        echo "  ./manage_explorer.sh logs         # Show logs"
        echo "  ./manage_explorer.sh cleanup      # Delete EVERYTHING (DB too!)"
        ;;
esac
