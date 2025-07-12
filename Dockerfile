FROM debian:stable-slim

# 一次性安装所有依赖并清理缓存
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        xz-utils \
        procps \
        nginx && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/* && \
    mkdir -p /home/aria2

# 复制并安装 Aria2（合并解压和清理步骤）
COPY aria2.tar.xz /tmp/
RUN tar -xvf /tmp/aria2.tar.xz -C /usr/local/bin/ && \
    rm -f /tmp/aria2.tar.xz && \
    chmod +x /usr/local/bin/aria2c

# 复制配置文件（按变动频率排序）
COPY aria2.conf aria2.session /home/aria2/
COPY ariang/ /var/www/html/ariang/
COPY ariang.conf /etc/nginx/conf.d/
COPY nginx.conf /etc/nginx/
COPY start.sh /home/

# 统一设置权限
RUN chmod -R 755 /var/www/html/ariang && \
    chmod +x /home/start.sh

# 暴露端口
EXPOSE 6800 8089

# 启动服务
ENTRYPOINT ["/home/start.sh"]
