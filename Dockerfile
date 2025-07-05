FROM debian:stable-slim

# 一次性安装所有依赖并清理缓存
RUN apt-get update && \
    apt-get install -y --no-install-recommends aria2 ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


#COPY aria2c /usr/local/bin/
COPY aria2.conf /home/aria2/
COPY aria2.session /home/aria2/
COPY dht*.dat /home/aria2/
COPY aria2c.service /etc/systemd/system/

RUN systemctl enable aria2c && \
    systemctl start aria2c



EXPOSE 80 6800

