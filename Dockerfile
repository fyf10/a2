FROM debian:stable-slim

# 一次性安装所有依赖并清理缓存
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        procps && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


RUN mkdir -p /home/aria2


COPY aria2.conf aria2.session /home/aria2/
COPY start.sh /home/
COPY aria2.tar.xz /usr/local/bin/

RUN tar -xvf /usr/local/bin/aria2.tar.xz && \
    rm -rf /usr/local/bin/aria2.tar.xz

RUN chmod +x /usr/local/bin/aria2c /home/start.sh


EXPOSE 6800


#ENTRYPOINT ["/home/start.sh"]
