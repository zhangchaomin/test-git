#!/bin/sh
###
 # @Author: ZhangChaoMin
 # @Date: 2023-08-25 18:03:05
 # @LastEditors: ZhangChaoMin
 # @LastEditTime: 2023-09-14 20:08:03
 # @FilePath: \camxd:\Users\Desktop\reboot_hal.sh
 # @Description: 
 # 
### 

# 指定部分进程名称（关键字）
partial_process_name="android.hardware.camera.provider"
# partial_process_name="com.hollyland.cameralive"

# 使用 pgrep 命令查找匹配的进程ID
# -f 选项用于在整个命令行中搜索匹配字符串
process_ids=$(pgrep -f "$partial_process_name")

# 等待时间（秒）：根据需要调整等待的时间间隔
wait_time=5

# 指定要删除文件的文件夹路径
folder_path="/data/vendor/camera"

# 检查是否找到进程ID
if [ -n "$process_ids" ]; then
    echo "Found processes with partial name: $partial_process_name"
    
    # 遍历匹配的进程ID并终止它们
    for process_id in $process_ids; do
        echo "Terminating process with PID: $process_id"
        kill "$process_id"
        process_ids=""
    done

    # 循环检查进程是否还在运行
    while [ -n "$process_ids" ]; do
        echo "Waiting for processes to restart..."
        sleep "$wait_time"
        process_ids=$(pgrep -f "$partial_process_name")
    done

    sleep 8

    # 使用 find 命令查找文件夹下的所有文件，并使用 -delete 选项删除它们
    find "$folder_path" -type f -delete
    sleep 1

    # dump 出图
    setprop persist.vendor.camera.dynamicImageDumpTrigger 1
    sleep 1
    setprop persist.vendor.camera.dynamicImageDumpTrigger 0
    
    echo "Processes terminated."
else
    echo "No processes found with partial name: $partial_process_name"
fi



