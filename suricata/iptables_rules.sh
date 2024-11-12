#!/bin/bash

# Set up iptables rules for Suricata inline mode
iptables -I FORWARD -j NFQUEUE
iptables -I INPUT -j NFQUEUE
iptables -I OUTPUT -j NFQUEUE

# Start Suricata with the config file
suricata -c /etc/suricata/suricata.yaml -i eth0 > /var/log/suricata/suricata.log 2>&1 &

# Keep the container running
tail -f /var/log/suricata/fast.log