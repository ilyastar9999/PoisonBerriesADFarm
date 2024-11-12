#!/bin/bash

# Create necessary directories
mkdir -p suricata/logs
mkdir -p suricata/rules
mkdir -p modsecurity/rules
mkdir -p nginx/logs

# Set proper permissions
chmod 755 suricata/logs nginx/logs
chmod 644 suricata/rules/* modsecurity/rules/*

# Configure network routing
iptables -F
iptables -A FORWARD -j NFQUEUE --queue-num 0
iptables -A INPUT -j NFQUEUE --queue-num 0
iptables -A OUTPUT -j NFQUEUE --queue-num 0

# Start the security chain
docker-compose up -d