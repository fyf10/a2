FROM debian:stable

# 一次性安装所有依赖并清理缓存
RUN apt-get update && \
    apt-get install -y --no-install-recommends nginx nano aria2 ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 创建目录结构（避免COPY自动创建目录的权限问题）
RUN mkdir -p /home/aria2 /var/www/html/ariang

# 复制应用程序文件（保持层级结构）
#COPY aria2c /usr/local/bin/
COPY aria2.conf /home/aria2/
COPY aria2.session /home/aria2/
COPY dht*.dat /home/aria2/
COPY ariang.conf /etc/nginx/conf.d/
COPY ariang/ /var/www/html/ariang/

# 暴露端口
EXPOSE 80 6800 8089

# 启动脚本
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
