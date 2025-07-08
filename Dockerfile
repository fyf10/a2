FROM alpine:3.22.0

RUN apk add --no-cache \
    ca-certificates \
    nginx && \
    rm -rf /var/cache/apk/*

COPY ariang/ /usr/share/nginx/html/ariang/
COPY nginx.conf /etc/nginx/conf.d/

#RUN chmod -R 755 /usr/share/nginx/html/ariang

EXPOSE 8089
