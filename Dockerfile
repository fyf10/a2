FROM debian:stable

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        procps && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/* && \
    mkdir -p /home/aria2

COPY aria2.tar.xz /tmp/

RUN tar -xvf /tmp/aria2.tar.xz -C /usr/local/bin/ \
    && rm -f /tmp/aria2.tar.xz \
    && chmod +x /usr/local/bin/aria2c
    
COPY aria2.conf aria2.session /home/aria2/
COPY start.sh /home/
RUN chmod +x /home/start.sh

EXPOSE 6800
# ENTRYPOINT ["/home/start.sh"]
