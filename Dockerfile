FROM nginx:alpine

COPY ariang/ /usr/share/nginx/html/ariang/
COPY ar.conf /etc/nginx/conf.d/

#RUN chmod -R 755 /usr/share/nginx/html/ariang

EXPOSE 8089
