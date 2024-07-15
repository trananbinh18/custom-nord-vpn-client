#!/bin/bash
set -x 
# Check NordVPN connection status
if ! nordvpn status | grep -q "Connected"; then
  echo "NordVPN is not connected. Attempting to reconnect..."
  nordvpn connect --group "${VPN_GROUP:-P2P}" "${VPN_COUNTRY:-SG}"
  
  # Wait and check again
  sleep 10
  if ! nordvpn status | grep -q "Connected"; then
    echo "Failed to reconnect to NordVPN."
    exit 1
  fi
fi

echo "NordVPN is connected."
exit 0