#!/bin/bash
# Uninstall Netdata and cleanup

curl https://get.netdata.cloud/kickstart.sh > /tmp/netdata-kickstart.sh && sh /tmp/netdata-kickstart.sh --uninstall --non-interactive
