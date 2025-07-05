FROM debian:stable-slim

# 一次性安装所有依赖并清理缓存
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 创建专用目录
RUN mkdir -p /home/aria2

# 合并文件复制操作
COPY aria2.conf aria2.session dht*.dat /home/aria2/
COPY start1.sh /home/
COPY aria2c /usr/local/bin
# 修正权限设置命令
RUN chmod +x /home/start1.sh

# 暴露必要端口
EXPOSE 80 6800

# 设置容器启动命令
CMD ["/bin/bash", "/home/start1.sh"]
