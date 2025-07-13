#!/bin/bash

# 启动Aria2 RPC服务
aria2c --conf-path=/home/aria2/aria2.conf --daemon=true

# 启动Nginx (前台运行保持容器存活)
nginx -g "daemon off;"
