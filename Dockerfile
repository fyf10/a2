FROM debian:stable

# 安装依赖
RUN apt-get update && apt-get install -y \
    nginx \
    libssl-dev \
    libc-ares-dev \
    procps \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制文件
COPY aria2c /usr/local/bin/aria2c
COPY aria2.conf /etc/aria2.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY ariang /usr/share/nginx/html
COPY start.sh /start.sh

# 创建下载目录和日志
RUN mkdir -p /downloads && \
    touch /var/log/aria2.log && \
    chmod 777 /var/log/aria2.log /downloads && \
    chmod +x /start.sh

# 暴露端口
EXPOSE 80 6800

# 使用启动脚本
CMD ["/start.sh"]
