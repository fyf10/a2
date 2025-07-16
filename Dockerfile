FROM debian:stable-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        nginx && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY ariang/ /var/www/html/ariang/
COPY ariang.conf /etc/nginx/conf.d/
#COPY nginx.conf /etc/nginx/

#RUN chmod -R 755 /var/www/html/ariang

EXPOSE 8089

#CMD ["nginx", "-g", "daemon off;"]
