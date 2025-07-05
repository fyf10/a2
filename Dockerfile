FROM debian:stable

# 安装依赖并清理
RUN apt-get update && \
    apt-get install -y --no-install-recommends nginx ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


RUN mkdir -p /var/www/html/ariang
RUN rm -rf /etc/nginx/nginx.conf


COPY nginx.conf /etc/nginx/nginx.conf
COPY ariang/ /var/www/html/ariang/

EXPOSE 80 16800
