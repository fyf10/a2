
FROM nginx:alpine

RUN apk add --no-cache wqy-zenhei

COPY ariang/ /usr/share/nginx/html/ariang/

# 复制自定义配置（如果存在）
COPY nginx.conf /etc/nginx/conf.d/

EXPOSE 16800
