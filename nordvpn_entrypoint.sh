#!/bin/bash

# Start NordVPN service
/etc/init.d/nordvpn start
echo "Init nord VPN."
sleep 5

# Check if already logged in
if nordvpn account | grep -q "You are not logged in"; then
  echo "Not logged in. Please log in."
  /bin/bash -c "nordvpn login"
fi

# Connect to NordVPN
nordvpn connect

# Keep the container running
if [ $# -eq 0 ]; then
  exec /bin/bash
else
  exec "$@"
fi