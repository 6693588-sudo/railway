#!/bin/bash

# 检查是否配置了 Cloudflare Tunnel Token
if [ -z "$TUNNEL_TOKEN" ]; then
  echo "Error: TUNNEL_TOKEN environment variable is not set."
  echo "Starting local service only..."
else
  echo "Starting Cloudflare Tunnel..."
  # 以后台方式启动 Cloudflare Tunnel，并使用传入的 Token
  cloudflared tunnel --no-autoupdate run --token "$TUNNEL_TOKEN" &
fi

# 启动 Xray 核心服务
echo "Starting Xray service..."
exec /usr/local/bin/xray run -c /app/config.json
