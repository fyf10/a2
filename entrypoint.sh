#!/bin/bash

# 启动aria2c后台进程
aria2c --conf-path="/home/aria2/aria2.conf" --daemon=true

# 验证启动是否成功
sleep 2  # 等待进程初始化
if ! pgrep -x "aria2c" > /dev/null; then
  echo "错误：aria2c启动失败，请检查配置！"
  exit 1
fi

# 设置信号捕获
trap 'echo "接收到终止信号，停止容器..."; kill $(jobs -p); exit 0' SIGTERM SIGINT

# 保活与监控循环
echo "aria2c 已启动，容器运行中..."
echo "提示：按 CTRL+C 可退出容器"

while true; do
  sleep 60
  if ! pgrep -x "aria2c" > /dev/null; then
    echo "警告：aria2c 进程异常退出！"
    exit 1
  fi
done
