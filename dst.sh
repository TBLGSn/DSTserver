#!/bin/bash
###
 # @Author: tblgsn
 # @Date: 2022-03-02 13:20:04
 # @Description: 饥荒服务器安装脚本
 # @FilePath: \DSTserver\bin\installdst.sh
### 

mkdir -p /home/dst/server_dst/bin

# 5.在 server_dst 目录下新建脚本,并添加权限
Printf_Green "在server_dst目录下新建脚本"
cd /home/dst/server_dst

git clone https://gitee.com/TBLGSn/DSTserver.git

# 移动脚本文件 至规定的地点
mv DSTserver/bin/* /home/dst/server_dst/bin
chmod 777 /home/dst/server_dst/bin/*
bash /home/dst/server_dst/bin/install.sh