#!/bin/bash
# Stress load on system
# Requires "stress" package
# Create load on:
# - 2 CPU cores
# - 2 processes stressing the memory
# - 2 processes stressing the I/O
# Duration of the load is 60 seconds

stress --cpu 2 --vm 2 --io 2 --timeout 60
