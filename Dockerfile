FROM alpine:latest

# 仅安装基础运行依赖（无 nginx）
RUN apk add --no-cache curl unzip ca-certificates bash

WORKDIR /app

# 下载并安装 cloudflared
RUN curl -L https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -o /usr/local/bin/cloudflared && \
    chmod +x /usr/local/bin/cloudflared

# 下载并安装 Xray-core
RUN curl -L https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip -o xray.zip && \
    unzip xray.zip && \
    mv xray /usr/local/bin/xray && \
    chmod +x /usr/local/bin/xray && \
    rm -rf xray.zip

# 复制配置文件和启动脚本
COPY config.json /app/config.json
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# 暴露容器主端口
EXPOSE 8080

ENTRYPOINT ["/app/start.sh"]
