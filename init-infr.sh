#!/bin/bash

echo "Initializing infrastructure..."

./start_suricata.sh


echo "Infrastructure initialized."
echo "Starting services..."

# Start services
docker-compose down
docker-compose up -d