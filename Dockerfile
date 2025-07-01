FROM debian:stable-slim

# 安装依赖
RUN apt-get update && apt-get install -y \
    nginx \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# 复制文件
COPY aria2c /usr/local/bin/aria2c
COPY ariang /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
COPY aria2.conf /etc/aria2/aria2.conf

# 创建配置和下载目录
RUN mkdir -p /etc/aria2 /data/downloads && \
    chmod +x /usr/local/bin/aria2c && \
    echo -e "enable-rpc=true\nrpc-listen-all=true\nrpc-allow-origin-all=true\n" > /etc/aria2/aria2.conf

# 暴露端口
EXPOSE 80

# 启动脚本
CMD ["/start.sh"]
