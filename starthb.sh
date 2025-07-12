#!/bin/bash

# 启动aria2c后台进程
aria2c --conf-path="/home/aria2/aria2.conf" --daemon=true

# 验证启动是否成功
sleep 3
if ! pgrep -x "aria2c" >/dev/null; then
    echo "aria2c启动失败！请检查配置文件路径和权限" >&2
    exit 1
else
    echo "aria2c成功启动 (PID: $(pgrep -x "aria2c"))"
fi

# 启动Nginx后台进程
echo "启动Nginx服务..."
nginx

# 捕获退出信号
trap 'shutdown' SIGTERM SIGINT

# 定义清理函数
shutdown() {
    echo "接收到终止信号，正在停止服务..."
    # 停止aria2c
    pkill aria2c
    # 停止Nginx
    nginx -s stop
    echo "所有服务已停止"
    exit 0
}

# 使用无限等待保持前台进程
echo "容器服务已启动，等待终止信号..."
echo "按CTRL+C或发送停止命令可退出容器"

# 无限循环保持前台进程
while true; do
    sleep 86400 &  # 睡眠一天（86400秒）
    wait $!        # 等待睡眠进程结束
done
