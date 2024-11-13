#!/bin/bash

# Create necessary directories
mkdir -p suricata/logs
mkdir -p suricata/rules
mkdir -p modsecurity/rules
mkdir -p nginx/logs

# Set proper permissions
chmod 755 suricata/logs nginx/logs
chmod 644 suricata/rules/* modsecurity/rules/*
chmod 666 suricata/logs/*

# Create log files with proper permissions
mv suricata/logs/fast.log suricata/logs/fast.log.old
echo "" > suricata/logs/fast.log
mv suricata/logs/eve.json suricata/logs/eve.json.old
echo "" > suricata/logs/eve.json
mv suricata/logs/http.log suricata/logs/http.log.old
echo "" > suricata/logs/http.log
mv suricata/logs/suricata.log suricata/logs/suricata.log.old
echo "" > suricata/logs/suricata.log
chmod 666 suricata/logs/*

# Configure network monitoring
iptables -F
# Mirror all traffic to NFQUEUE
iptables -A INPUT -j NFQUEUE --queue-num 0
iptables -A OUTPUT -j NFQUEUE --queue-num 0
iptables -A FORWARD -j NFQUEUE --queue-num 0

# Mirror HTTP traffic specifically
iptables -t mangle -A PREROUTING -p tcp --dport 80 -j NFQUEUE --queue-num 0
iptables -t mangle -A PREROUTING -p tcp --dport 443 -j NFQUEUE --queue-num 0

# Start services
docker-compose down
docker-compose up -d