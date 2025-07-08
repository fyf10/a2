#!/bin/bash

# 配置参数
MAX_RESTARTS=3        # 最大重启次数
RESTART_COUNT=0        # 当前重启次数
HEALTH_CHECK_INTERVAL=60  # 健康检查间隔(秒)
RESTART_DELAY=5        # 重启前等待时间(秒)

# 启动aria2c后台进程
start_aria2c() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') - 正在启动aria2c..."
  aria2c --conf-path="/home/aria2/aria2.conf" &
  ARIA_PID=$!
  
  # 等待进程初始化
  local wait_count=0
  while [ $wait_count -lt 5 ]; do
    if ps -p $ARIA_PID > /dev/null; then
      echo "$(date '+%Y-%m-%d %H:%M:%S') - aria2c 启动成功 (PID: $ARIA_PID)"
      return 0
    fi
    sleep 1
    ((wait_count++))
  done
  
  echo "$(date '+%Y-%m-%d %H:%M:%S') - 错误：aria2c启动失败，请检查配置！"
  return 1
}

# 停止aria2c进程
stop_aria2c() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') - 正在停止aria2c (PID: $ARIA_PID)..."
  kill -TERM $ARIA_PID 2>/dev/null
  wait $ARIA_PID 2>/dev/null
  echo "$(date '+%Y-%m-%d %H:%M:%S') - aria2c 已停止"
}

# 信号处理函数
handle_signal() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') - 接收到终止信号，停止容器..."
  stop_aria2c
  exit 0
}

# 健康检查函数
check_health() {
  if ! ps -p $ARIA_PID > /dev/null; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - 健康检查失败: aria2c进程不存在"
    return 1
  fi
  
  # 这里可以添加更复杂的健康检查逻辑
  # 例如: 检查aria2c是否响应RPC请求等
  
  return 0
}

# 主函数
main() {
  # 首次启动
  if ! start_aria2c; then
    exit 1
  fi

  # 设置信号捕获
  trap handle_signal SIGTERM SIGINT

  echo "=============================================="
  echo "$(date '+%Y-%m-%d %H:%M:%S') - 容器已启动"
  echo "• aria2c PID: $ARIA_PID"
  echo "• 最大重启次数: $MAX_RESTARTS"
  echo "• 健康检查间隔: ${HEALTH_CHECK_INTERVAL}秒"
  echo "提示：按 CTRL+C 可退出容器"
  echo "=============================================="

  # 保活与监控循环
  while true; do
    # 执行健康检查
    if ! check_health; then
      # 健康检查失败
      if [ $RESTART_COUNT -ge $MAX_RESTARTS ]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') - 错误：已达到最大重启次数 ($MAX_RESTARTS)，容器将退出！"
        exit 1
      fi
      
      # 增加重启计数
      RESTART_COUNT=$((RESTART_COUNT + 1))
      echo "$(date '+%Y-%m-%d %H:%M:%S') - 警告：尝试重启 ($RESTART_COUNT/$MAX_RESTARTS)..."

      # 等待后重启
      sleep $RESTART_DELAY
      
      if start_aria2c; then
        # 重启成功后重置计数器
        RESTART_COUNT=0
      else
        # 重启失败
        echo "$(date '+%Y-%m-%d %H:%M:%S') - 重启失败 ($RESTART_COUNT/$MAX_RESTARTS)"
      fi
    fi

    # 等待进程结束或健康检查间隔
    wait $ARIA_PID
    EXIT_STATUS=$?
    
    # 检查是否正常退出
    if [ $EXIT_STATUS -eq 0 ] || [ $EXIT_STATUS -eq 143 ]; then
      echo "$(date '+%Y-%m-%d %H:%M:%S') - aria2c 已正常退出"
      exit 0
    fi
    
    # 进程异常退出
    echo "$(date '+%Y-%m-%d %H:%M:%S') - 警告：aria2c 进程异常退出 (状态码: $EXIT_STATUS)"
    
    # 检查重启次数限制
    if [ $RESTART_COUNT -ge $MAX_RESTARTS ]; then
      echo "$(date '+%Y-%m-%d %H:%M:%S') - 错误：已达到最大重启次数 ($MAX_RESTARTS)，容器将退出！"
      exit 1
    fi
    
    # 增加重启计数并尝试重启
    RESTART_COUNT=$((RESTART_COUNT + 1))
    echo "$(date '+%Y-%m-%d %H:%M:%S') - 尝试重启 ($RESTART_COUNT/$MAX_RESTARTS)..."
    sleep $RESTART_DELAY
    
    if start_aria2c; then
      RESTART_COUNT=0
    else
      echo "$(date '+%Y-%m-%d %H:%M:%S') - 重启失败 ($RESTART_COUNT/$MAX_RESTARTS)"
    fi
  done
}

# 执行主函数
main
