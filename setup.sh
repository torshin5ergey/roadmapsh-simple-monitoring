#!/bin/bash

# Verify script integrity
[ "cefd628b28aa4bf637a6388041133677" = "$(curl -Ss https://get.netdata.cloud/kickstart.sh | md5sum | cut -d ' ' -f 1)" ] && echo "OK, VALID" || echo "FAILED, INVALID"
# One-line install
curl https://get.netdata.cloud/kickstart.sh > /tmp/netdata-kickstart.sh && sh /tmp/netdata-kickstart.sh --no-updates --stable-channel --disable-telemetry --non-interactive

# Create custom CPU usage alarm
tee /etc/netdata/health.d/cpu_usage.conf > /dev/null <<'EOF'
alarm: cpu_usage
template: cpu_usage
on: system.cpu
lookup: average -1m percentage of usage
every: 10s
warn: $this > 80
crit: $this > 90
delay: up 1m down 15s
info: CPU usage over the last minute is above 80%
EOF

# Start service
systemctl start netdata
