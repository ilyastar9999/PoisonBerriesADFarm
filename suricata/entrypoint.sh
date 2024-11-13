#!/bin/bash

# Enable IP forwarding
sysctl -w net.ipv4.ip_forward=1

# Set up iptables rules to intercept traffic
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A FORWARD -i eth0 -o eth0 -j ACCEPT

# Create monitoring interface
ip link add name mon0 type dummy
ip link set mon0 up

# Start Suricata with monitoring
exec suricata -c /etc/suricata/suricata.yaml --af-packet > /var/log/suricata/suricata.log 2>&1
