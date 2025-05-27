# 🚦 Simple Monitoring Project for [roadmap.sh](https://roadmap.sh/)

This is my solution to the [Simmple Monitoring project](https://roadmap.sh/projects/simple-monitoring-dashboard) in the [DevOps roadmap](https://roadmap.sh/devops) from [roadmap.sh](https://roadmap.sh/)

**Table of Contents**
- [References](#references)
- [Project Requirements](#project-requirements)
- [Prerequisites](#prerequisites)
- [Step-By-Step](#step-by-step)
- [Author](#author)

## References

- [Netdata Agent Installation](https://learn.netdata.cloud/docs/netdata-agent/installation)

## Project Requirements

- [x] Install Netdata on a Linux system.
- [x] Configure Netdata to monitor basic system metrics such as CPU, memory usage, and disk I/O.
- [x] Access the Netdata dashboard through a web browser.
- [x] Customize at least one aspect of the dashboard (e.g., add a new chart or modify an existing one).
- [ ] Set up an alert for a specific metric (e.g., CPU usage above 80%).
- [x] `setup.sh`: A shell script to install Netdata on a new system.
- [ ] `test_dashboard.sh`: Script to put some load on the system and test the monitoring dashboard.
- [ ] `cleanup.sh`: Script to clean up the system and remove the Netdata agent.

## Prerequisites

- Linux OS (AlamLinux 9.5 Minimal)

## Step-By-Step

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

## Author

Sergey Torshin [@torshin5ergey](https://github.com/torshin5ergey)
