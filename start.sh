#!/bin/bash

# 启动aria2c后台进程
aria2c --conf-path="/home/aria2/aria2.conf" --daemon=true

# 验证启动是否成功
sleep 3  # 短暂延迟确保进程状态更新
if ! pgrep -x "aria2c" >/dev/null; then
    echo "aria2c启动失败！请检查配置文件路径和权限" >&2
    exit 1  # 退出容器并返回错误码
else
    echo "aria2c成功启动 (PID: $(pgrep -x "aria2c"))"
fi

# 捕获退出信号
trap 'shutdown' SIGTERM SIGINT

# 定义清理函数
shutdown() {
    echo "接收到终止信号，正在停止aria2c..."
    pkill aria2c  # 发送终止信号给aria2c
    wait $pid 2>/dev/null  # 等待进程结束
    echo "容器已停止"
    exit 0
}

# 保持容器运行
echo "aria2c已在后台启动，容器保持运行中..."
echo "按CTRL+C或发送停止命令可退出容器"

# 获取aria2c的PID
pid=$(pgrep aria2c)

# 持续检查进程状态
while sleep 3600 & wait $!; do
    if ! pgrep aria2c >/dev/null; then
        echo "aria2c进程已停止，容器将退出"
        exit 1
    fi
done
