#!/bin/bash

# Path to site folder and config
SITE_DIR="$HOME/thetriedstone"
CONFIG_FILE="$HOME/.cloudflared/config.yml"
CERT_FILE="$HOME/.cloudflared/cert-thetriedstone.pem"
TUNNEL_NAME="thetriedstone"

# Export certificate for Cloudflare
export TUNNEL_ORIGIN_CERT="$CERT_FILE"

# Infinite loop to keep both server and tunnel alive
while true; do
    echo "Starting local HTTP server..."
    cd "$SITE_DIR"
    # Start HTTP server in background
    nohup python3 -m http.server 8080 > server.log 2>&1 &

    SERVER_PID=$!
    echo "HTTP server running with PID $SERVER_PID"

    echo "Starting Cloudflare tunnel..."
    cloudflared tunnel --config "$CONFIG_FILE" run $TUNNEL_NAME

    # If tunnel stops, kill the HTTP server
    echo "Tunnel stopped, restarting both server and tunnel..."
    kill $SERVER_PID

    # Wait 5 seconds before restarting
    sleep 5
done
