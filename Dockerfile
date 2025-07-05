FROM debian:stable

# 一次性安装所有依赖并清理缓存
RUN apt-get update && \
    apt-get install -y --no-install-recommends nginx nano ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 创建目录结构（避免COPY自动创建目录的权限问题）
RUN mkdir -p /home/.config/aria2 /var/www/html/ariang

# 复制应用程序文件（保持层级结构）
COPY aria2c /usr/local/bin/
COPY aria2.conf /home/.config/aria2/
COPY aria2.session /home/.config/aria2/
COPY dht*.dat /home/.config/aria2/
COPY ariang.conf /etc/nginx/conf.d/
COPY ariang/ /var/www/html/ariang/

# 复制启动脚本并设置工作目录
WORKDIR /app
COPY start.sh ./

# 统一设置权限
RUN chmod +x /usr/local/bin/aria2c start.sh

# 暴露端口
EXPOSE 8089
