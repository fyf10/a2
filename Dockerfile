FROM debian:stable-slim

# 一次性安装所有依赖并清理缓存
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        procps && \  # 添加 procps 用于 pgrep 命令
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 创建专用目录
RUN mkdir -p /home/aria2

# 复制配置文件
COPY aria2.conf aria2.session /home/aria2/
COPY start.sh /home/
COPY aria2c /usr/local/bin/

# 设置权限
RUN chmod +x /usr/local/bin/aria2c /home/start.sh

# 暴露必要端口
EXPOSE 6800

# 使用 ENTRYPOINT 指定容器主进程
ENTRYPOINT ["/home/start.sh"]
