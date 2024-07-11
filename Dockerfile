FROM arm64v8/ubuntu:20.04
SHELL ["/bin/bash", "-c"]
# Install necessary packages and NordVPN

# Copy entrypoint and health check scripts into the container
COPY nordvpn_entrypoint.sh /usr/local/bin/nordvpn_entrypoint.sh
COPY check_nordvpn_status.sh /usr/local/bin/check_nordvpn_status.sh
COPY setup_vpn.sh /usr/local/bin/setup_vpn.sh


# Make the scripts executable
RUN chmod +x /usr/local/bin/setup_vpn.sh /usr/local/bin/nordvpn_entrypoint.sh /usr/local/bin/check_nordvpn_status.sh

RUN /usr/local/bin/setup_vpn.sh 
# Use the entry point script

ENTRYPOINT ["/usr/local/bin/nordvpn_entrypoint.sh"]


# Define the health check
HEALTHCHECK --interval=10s --timeout=6s --start-period=7s --retries=3 CMD /usr/local/bin/check_nordvpn_status.sh

