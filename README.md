# 🚦 Simple Monitoring Project for [roadmap.sh](https://roadmap.sh/)

This is my solution to the [Simmple Monitoring project](https://roadmap.sh/projects/simple-monitoring-dashboard) in the [DevOps roadmap](https://roadmap.sh/devops) from [roadmap.sh](https://roadmap.sh/)

**Table of Contents**
- [References](#references)
- [Project Requirements](#project-requirements)
- [Prerequisites](#prerequisites)
- [Step-By-Step](#step-by-step)
  - [Install Netdata](#install-netdata)
  - [Create Alarm](#create-alarm)
  - [Apply load to the system](#apply-load-to-the-system)
  - [Uninstall Netdata](#uninstall-netdata)
- [Author](#author)

## References

- [Netdata Agent Installation](https://learn.netdata.cloud/docs/netdata-agent/installation)
- [Linux Server Performance Monitoring with Netdata (2022)](https://www.linuxbabe.com/monitoring/linux-server-performance-monitoring-with-netdata)
- [stress man](https://linux.die.net/man/1/stress)

## Project Requirements

- [x] Install Netdata on a Linux system.
- [x] Configure Netdata to monitor basic system metrics such as CPU, memory usage, and disk I/O.
- [x] Access the Netdata dashboard through a web browser.
- [x] Customize at least one aspect of the dashboard (e.g., add a new chart or modify an existing one).
- [x] Set up an alert for a specific metric (e.g., CPU usage above 80%).
- [x] `setup.sh`: A shell script to install Netdata on a new system.
- [x] `test_dashboard.sh`: Script to put some load on the system and test the monitoring dashboard.
- [x] `cleanup.sh`: Script to clean up the system and remove the Netdata agent.

## Prerequisites

- Linux OS (AlamLinux 9.5 Minimal)
- `stress` package installed

## Step-By-Step

### Install Netdata

- Verify script integrity
```bash
[ "cefd628b28aa4bf637a6388041133677" = "$(curl -Ss https://get.netdata.cloud/kickstart.sh | md5sum | cut -d ' ' -f 1)" ] && echo "OK, VALID" || echo "FAILED, INVALID"
```
- One-line install with `kickstart.sh` script
```bash
curl https://get.netdata.cloud/kickstart.sh > /tmp/netdata-kickstart.sh && sh /tmp/netdata-kickstart.sh --no-updates --stable-channel --disable-telemetry
```
- Start netdata service
```bash
sudo systemctl start netdata
```
- Setup firewall if needed
```bash
sudo firewall-cmd --permanent --add-port=19999/tcp
sudo systemctl reload firewalld
```
- Access Netdata dashboard through web browser `http://NODEIP:19999`

### Create Alarm

- Use `/etc/netdata/edit-config.` or `nano`/`vi` to create custom alert `/etc/netdata/health.d/cpu_usage.conf`
```
# high_cpu_usage.conf

alarm: high_cpu_usage
on: system.cpu.utilization
lookup: average -1m percentage of utilization
units: "%"
every: 10s
warn: $this > 80
crit: $this > 90
delay: up 1m down 15s
info: CPU usage over the last minute is above 80%
```
- Reload `netdata`
```bash
sudo systemctl restart netdata
```

### Apply load to the system

- Install `stress` package
```bash
sudo dnf install stress
```
- Apply load
```bash
stress --cpu 2 --timeout 60s
```

### Uninstall Netdata

- Use recommended by Netdata script to uninstall
```bash
curl https://get.netdata.cloud/kickstart.sh > /tmp/netdata-kickstart.sh && sh /tmp/netdata-kickstart.sh --uninstall
```

## Author

Sergey Torshin [@torshin5ergey](https://github.com/torshin5ergey)
