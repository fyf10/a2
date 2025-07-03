FROM debian:stable

# 安装依赖
RUN apt-get update && apt-get install -y \
    nginx \
    && rm -rf /var/lib/apt/lists/*

# 复制文件
COPY aria2c /usr/local/bin/aria2c
COPY aria2.conf /root/.config/aria2/aria2.conf
COPY aria2.session /root/.config/aria2/aria2.session
COPY dht.dat /root/.config/aria2/dht.dat
COPY dht6.dat /root/.config/aria2/dht6.dat
COPY ariang.conf /etc/nginx/conf.d/ariang.conf
COPY ariang /var/www/html/
COPY start.sh /start.sh

# 创建下载目录和日志
RUN chmod +x /usr/local/bin/aria2c
RUN chmod +x /start.sh

# 暴露端口
EXPOSE 8089

# 使用启动脚本
CMD ["/start.sh"]
