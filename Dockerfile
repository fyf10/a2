FROM debian:stable-slim

# 一次性安装所有依赖并清理缓存
RUN apt-get update && \
    apt-get install -y --no-install-recommends aria2 ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# 复制应用程序文件（保持层级结构）
#COPY aria2c /usr/local/bin/
COPY aria2.conf /home/aria2/
COPY aria2.session /home/aria2/
COPY dht*.dat /home/aria2/
COPY aria2c.service /etc/systemd/system/

RUN systemctl enable aria2c && \
    systemctl start aria2c
# 暴露端口
EXPOSE 80 6800 8089 16800

