#!/bin/bash
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'

echo -e "${RED}Start container${NC}"
docker compose up -d

echo -e "${RED}Start Installing${NC}"
docker compose exec server install-wordpress.sh

# Done
echo -e "${GREEN}Done${NC}"