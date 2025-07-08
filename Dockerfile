FROM alpine:3.22.0

RUN apk add --no-cache \
    ca-certificates \
    nginx && \
    rm -rf /var/cache/apk/* /etc/nginx/conf.d/nginx.conf

COPY ariang/ /usr/share/nginx/html/ariang/
COPY ariang.conf /etc/nginx/conf.d/
COPY nginx.conf /etc/nginx/

#RUN chmod -R 755 /usr/share/nginx/html/ariang

#EXPOSE 8089

#CMD ["nginx", "-g", "daemon off;"]
