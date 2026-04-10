#!/bin/bash

# Set environment variable to use the correct certificate
export TUNNEL_ORIGIN_CERT="$HOME/.cloudflared/cert-thetriedstone.pem"

# Navigate to site folder
cd "$HOME/thetriedstone"

# Start the local HTTP server in background
nohup python3 -m http.server 8080 > server.log 2>&1 &

# Run Cloudflare tunnel with config
cloudflared tunnel --config "$HOME/.cloudflared/config.yml" run thetriedstone
