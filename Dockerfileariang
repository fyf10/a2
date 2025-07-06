
FROM nginx:alpine

COPY ariang/ /usr/share/nginx/html/ariang/
COPY nginx.conf /etc/nginx/conf.d/

RUN chmod -R 644 /usr/share/nginx/html/ariang

EXPOSE 8089
