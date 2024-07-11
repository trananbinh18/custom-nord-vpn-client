#!/bin/bash

# Check NordVPN connection status
if nordvpn status | grep -q "Connected"; then
  exit 0
else
  exit 1
fi