#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}Stopping Application${NC}"

# Stop Docker containers
if docker ps --format '{{.Names}}' | grep -q 'my-app'; then
    docker compose down
    echo -e "${GREEN}✓ Docker containers stopped${NC}"
else
    echo -e "${YELLOW}No containers running${NC}"
fi

# Ask about Supabase
if curl -s http://127.0.0.1:54321/rest/v1/ > /dev/null 2>&1; then
    read -p "Stop Supabase? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        cd backend && npx supabase stop
        echo -e "${GREEN}✓ Supabase stopped${NC}"
    fi
fi

echo -e "${GREEN}Done!${NC}"
```