FROM debian:stable

# 合并所有操作到单个RUN指令减少层数
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        procps && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/* && \
    mkdir -p /home/aria2

# 先复制变化频率较低的大文件（利用Docker缓存）
COPY aria2.tar.xz /tmp/

# 解压安装并清理
RUN tar -xvf /tmp/aria2.tar.xz -C /usr/local/bin/ \
    && rm -f /tmp/aria2.tar.xz \
    && chmod +x /usr/local/bin/aria2c

# 后复制可能频繁变化的配置文件
COPY aria2.conf aria2.session /home/aria2/
COPY start.sh /home/
RUN chmod +x /home/start.sh

EXPOSE 6800
# ENTRYPOINT ["/home/start.sh"]
