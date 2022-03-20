#!/bin/bash
###
 # @Author: tblgsn
 # @Date: 2022-03-02 13:20:04
 # @Description: 饥荒服务器安装脚本
 # @FilePath: \DSTserver\bin\installdst.sh
### 

source /home/dst/server_dst/bin/functions.sh

#############################################################################
###############################MAIN##########################################
#############################################################################

# 1. 登陆服务器，验证权限
if [ $EUID -eq 0 ];then
	Printf_Green "root权限验证成功"
else
	Printf_RED "当前用户无root权限，请切换用户"
	exit 1
fi

# 2. 安装运行依赖
Printf_Green "开始安装依赖"
apt-get update
apt-get install -y lib32gcc1 lib32stdc++6 libcurl4-gnutls-dev:i386 screen htop git
dpkg --add-architecture i386  

# 3. 添加用户(/home/dst 密码为123456)
useradd -p -123456 -s /bin/bash -ou 0 -g 0 -d $INSTALL_DIR -m dst 
Printf_Green "添加用户成功"

# 4.登陆用户，并下载SteamCMD
Printf_Green "下载SteamCMD"
cd $INSTALL_DIR || Printf_RED "发生错误"

if [ ! -f steamcmd_linux.tar.gz ]
then
	wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
	tar -xvzf steamcmd_linux.tar.gz
fi

# mkdir -p server_dst
./steamcmd.sh +force_install_dir "$SERVER_DST"  +login anonymous +app_update 343050 validate +quit

# 5.在 server_dst 目录下新建脚本,并添加权限
# Printf_Green "在server_dst目录下新建脚本"
# #git clone https://github.com/TBLGSn/DSTserver.git
# git clone https://gitee.com/TBLGSn/DSTserver.git
# mv DSTserver/bin/* $SERVER_DST_BIN

cd $SERVER_DST_BIN || Printf_RED "进入server_dst/bin发生错误" exit
# chmod u+x *

# 7.运行脚本,这会这 /home/dst/Klei/DoNotStarveTogether 下生成名为“Cluster_1”的存档
#./real_start.sh
mkdir -p  $DONOTSTARVE_DIR/Cluster_1/Caves
mkdir -p  $DONOTSTARVE_DIR/Cluster_1/Master

# 8.添加令牌
echo "请输入你的token( Server Token )："
read -r token
cat > $DONOTSTARVE_DIR/Cluster_1/cluster_token.txt <<EOF
$token
EOF
# 9. 更改创建的存档的权限
cd $DONOTSTARVE_DIR/Cluster_1 || Printf_RED "进入存档错误"
chmod 777 *

# 10.世界配置文件
mv -f $INSTALL_DIR/DSTserver/Cluster_1/Master/* $DONOTSTARVE_DIR/Cluster_1/Master/
mv -f $INSTALL_DIR/DSTserver/Cluster_1/Caves/* $DONOTSTARVE_DIR/Cluster_1/Caves/
mv -f $INSTALL_DIR/DSTserver/Cluster_1/cluster.ini $DONOTSTARVE_DIR/Cluster_1/

# 11.删除多余文件
Printf_Green "删除多余文件"
rm -rf $INSTALL_DIR/DSTserver $INSTALL_DIR/steamcmd_linux.tar.gz # 删除库

Printf_Green "安装成功，请启动服务器"
