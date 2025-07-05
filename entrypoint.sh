#!/bin/bash

# 启动Aria2后台服务
aria2c --conf-path=/home/aria2/aria2.conf --daemon=true

# 启动Nginx前台进程（保持容器运行）
#exec nginx -g 'daemon off;'
