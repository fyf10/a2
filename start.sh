#!/bin/bash
# start.sh

# 启动 aria2c
aria2c --conf-path=/etc/aria2/aria2.conf &

# 启动简易 HTTP 服务器 (Python3)
cd /usr/share/nginx/html
python3 -m http.server 8080
