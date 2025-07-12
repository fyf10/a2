FROM debian：stable-slim

RUN apk add --no-cache \
    ca-certificates \
    nginx && \
    rm -rf /var/cache/apk/* /etc/nginx/nginx.conf

COPY ariang/ /var/www/html/ariang/
COPY ariang.conf /etc/nginx/conf.d/
COPY nginx.conf /etc/nginx/

RUN chmod -R 755 /var/www/html/ariang

EXPOSE 8089

CMD ["nginx", "-g", "daemon off;"]
