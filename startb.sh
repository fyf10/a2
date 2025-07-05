#!/bin/bash

# 启动aria2c后台进程
aria2c --conf-path="/home/aria2/aria2.conf" --daemon=true

# 保持容器运行的简单方法
echo "aria2c已在后台启动，容器保持运行中..."
echo "按CTRL+C退出容器"

# 使用无限sleep保持容器运行
while true; do
    sleep 3600  # 每小时唤醒一次检查进程
    # 可选：检查aria2c是否仍在运行
    if ! pgrep aria2c > /dev/null; then
        echo "aria2c进程已停止，容器将退出"
        exit 1
    fi
done
