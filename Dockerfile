FROM debian:stable

# 安装依赖并清理
RUN apt-get update && \
    apt-get install -y --no-install-recommends nginx ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


RUN mkdir -p /var/www/html/ariang

COPY nginx.conf /etc/nginx/conf.d/
COPY ariang/ /var/www/html/ariang/

EXPOSE 80 16800
