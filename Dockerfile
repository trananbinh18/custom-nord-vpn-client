FROM ubuntu:24.04

# Install necessary packages and NordVPN
RUN apt-get update && \
    apt-get install -y --no-install-recommends wget apt-transport-https ca-certificates && \
    wget -qO /etc/apt/trusted.gpg.d/nordvpn_public.asc https://repo.nordvpn.com/gpg/nordvpn_public.asc && \
    echo "deb https://repo.nordvpn.com/deb/nordvpn/debian stable main" > /etc/apt/sources.list.d/nordvpn.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends nordvpn && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy entrypoint and health check scripts into the container
COPY nordvpn_entrypoint.sh /usr/local/bin/nordvpn_entrypoint.sh
COPY check_nordvpn_status.sh /usr/local/bin/check_nordvpn_status.sh

# Make the scripts executable
RUN chmod +x /usr/local/bin/nordvpn_entrypoint.sh /usr/local/bin/check_nordvpn_status.sh

# Use the entry point script

ENTRYPOINT ["/usr/local/bin/nordvpn_entrypoint.sh"]


# Define the health check
HEALTHCHECK --interval=10s --timeout=6s --start-period=7s --retries=3 CMD /usr/local/bin/check_nordvpn_status.sh

