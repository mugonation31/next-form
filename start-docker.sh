#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}===========================================${NC}"
echo -e "${GREEN}Starting Application (Docker)${NC}"
echo -e "${GREEN}===========================================${NC}"

# Cleanup function
cleanup() {
    echo ""
    echo -e "${YELLOW}Shutting down...${NC}"
    docker compose down
    echo -e "${GREEN}Docker containers stopped.${NC}"

    read -p "Stop Supabase? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        cd backend && npx supabase stop
        echo -e "${GREEN}Supabase stopped.${NC}"
    fi
    exit 0
}

trap cleanup SIGINT

# Check Supabase
echo -e "${YELLOW}Checking Supabase...${NC}"
if curl -s http://127.0.0.1:54321/rest/v1/ > /dev/null 2>&1; then
    echo -e "${GREEN}✓ Supabase is running${NC}"
else
    echo -e "${YELLOW}Starting Supabase...${NC}"
    cd backend && npx supabase start &
    cd ..

    # Wait for Supabase
    for i in {1..30}; do
        if curl -s http://127.0.0.1:54321/rest/v1/ > /dev/null 2>&1; then
            echo -e "${GREEN}✓ Supabase ready!${NC}"
            break
        fi
        sleep 2
    done
fi

# Load environment variables
export $(grep -v '^#' backend/.env | xargs)

# Start Docker Compose
echo -e "${GREEN}Starting Docker Compose...${NC}"
docker compose up

cleanup