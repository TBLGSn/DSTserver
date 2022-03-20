#!/bin/bash
###
 # @Author: tblgsn
 # @Date: 2022-03-02 13:20:04
 # @Description: 饥荒服务器安装脚本
 # @FilePath: \DSTserver\bin\installdst.sh
### 

mkdir -p /home/dst/server_dst/bin

# 5.在 server_dst 目录下新建脚本,并添加权限

cd /home/dst && git clone https://gitee.com/TBLGSn/DSTserver.git

# 移动脚本文件 至规定的地点
mv DSTserver/bin/* /home/dst/server_dst/bin
chmod 777 /home/dst/server_dst/bin/*
echo "请运行菜单界面"
