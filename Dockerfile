FROM debian:stable

# 安装依赖并清理
RUN apt-get update && \
    apt-get install -y --no-install-recommends nginx ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 创建必要的目录结构
RUN mkdir -p /var/www/html/ariang
RUN rm -rf /etc/nginx/nginx.conf

# 复制应用程序文件
COPY nginx.conf /etc/nginx/sites-available/default
COPY ariang/ /var/www/html/ariang/

# 测试Nginx配置（关键步骤）
RUN nginx -t

# 暴露端口
EXPOSE 80 16800

# 启动Nginx前台进程
CMD ["nginx", "-g", "daemon off;"]
