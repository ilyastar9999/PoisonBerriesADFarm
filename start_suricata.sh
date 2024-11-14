#!/bin/sh

sudo apt update
sudo apt install -y suricata
sudo suricata -c /suricata/suricata.yaml -i default -S ./suricata/rules/