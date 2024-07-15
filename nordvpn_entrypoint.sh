#!/bin/bash
set -x 
# Start NordVPN service
/etc/init.d/nordvpn start
echo "Init nord VPN."
sleep 5

# Check if already logged in
if nordvpn account | grep -q "You are not logged in"; then
  echo "Not logged in. Please log in."
  /bin/bash -c "nordvpn login"
fi


echo "Great nordvpn had been loggin !!"
# Set dynamic or default P2P group and SG country
VPN_GROUP="${VPN_GROUP:-P2P}"
VPN_COUNTRY="${VPN_COUNTRY:-SG}"

echo "Set VPN with group: '$VPN_GROUP' AND country: '$VPN_COUNTRY'."
nordvpn set lan-discovery on
nordvpn set autoconnect enabled --group "$VPN_GROUP" "$VPN_COUNTRY"

# Connect to NordVPN
echo "Connect to server..."
nordvpn connect --group "$VPN_GROUP" "$VPN_COUNTRY"

# Keep the container running
if [ $# -eq 0 ]; then
  exec /bin/bash
else
  exec "$@"
fi