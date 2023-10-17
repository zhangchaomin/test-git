#!/bin/bash
###
 # @Author: ZhangChaoMin
 # @Date: 2023-10-10 19:22:20
 # @LastEditors: ZhangChaoMin
 # @LastEditTime: 2023-10-11 17:19:42
 # @FilePath: \undefinedd:\Users\Desktop\auto-click.sh
 # @Description: 
 # 
### 

# 设置要点击的坐标数组
points=( "128 1536" "408 1536" "667 1536" "970 1536" )
# points=( "106 1132" "364 1132" "651 1132" "902 1132" )

while true
do
    for point in "${points[@]}"
    do
        #点击
        input tap $point
        # 打印点击的信息
        echo "Clicked at $point"
        # 等待0.01秒
        sleep 0.001
    done
done