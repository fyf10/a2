FROM debian:stable-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        xz-utils \
        procps \
        nginx && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/* && \
    mkdir -p /home/aria2

COPY aria2.tar.xz /tmp/
RUN tar -xvf /tmp/aria2.tar.xz -C /usr/local/bin/ && \
    rm -f /tmp/aria2.tar.xz && \
    chmod +x /usr/local/bin/aria2c

COPY aria2.conf aria2.session /home/aria2/
COPY ariang/ /var/www/html/ariang/
COPY ariang.conf /etc/nginx/conf.d/
COPY starthb.sh /home/

RUN chmod -R 755 /var/www/html/ariang && \
    chmod +x /home/start.sh

EXPOSE 6800 8089

CMD ["/home/start.sh"]
