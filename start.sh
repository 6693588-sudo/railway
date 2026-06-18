#!/bin/bash

# 1. 启动 Cloudflare Tunnel
if [ -z "$TUNNEL_TOKEN" ]; then
  echo "Error: TUNNEL_TOKEN environment variable is not set."
  echo "Starting local services only..."
else
  echo "Starting Cloudflare Tunnel..."
  cloudflared tunnel --no-autoupdate run --token "$TUNNEL_TOKEN" &
fi

# 2. 启动 Xray 核心服务
echo "Starting Xray service..."
exec /usr/local/bin/xray run -c /app/config.json
