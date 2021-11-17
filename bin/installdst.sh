#!/bin/bash
#############################################################################
############################饥荒服务器安装脚本##########################################
#############################################################################
Printf_RED(){
    echo -e "\033[41;37m $* \033[0m"
}
Printf_Green(){
    echo -e "\033[42;37m $* \033[0m"
}
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
echo y | apt-get install lib32gcc1
echo y | dpkg --add-architecture i386 
echo y | apt-get install lib32gcc1 
echo y | apt-get install lib32stdc++6  
echo y | apt-get install libgcc1  
echo y | apt-get install libcurl4-gnutls-dev:i386 
echo y | apt-get install screen 
echo y | apt-get install htop  # 停止服务器时使用
echo y | apt-get install git
# 4. 添加用户(/home/dst 密码为123456)
useradd -p -123456 -s /bin/bash -ou 0 -g 0 -d /home/dst -m dst 
su - dst
Printf_Green "添加用户成功"
# 5.登陆用户，并下载SteamCMD
Printf_Green "下载SteamCMD"
cd /home/dst || Printf_RED "发生错误"#默认安装在/home/dst目录下
if  test mkdir DSTserver ;then 
    cd DSTserver ||  Printf_RED "进入DSTserver发生错误"
fi
wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
tar -xvzf steamcmd_linux.tar.gz
mkdir server_dst
./steamcmd.sh +login anonymous +force_install_dir /home/dst/server_dst +app_update 343050 validate +quit

sleep 10
# 7.在 server_dst 目录下新建脚本
Printf_Green "在server_dst目录下新建脚本"
cd server_dst/bin || Printf_RED "进入server_dst/bin发生错误"
git clone git://github.com/TBLGSn/DSTserver.git

mv DSTserver/bin/* .
chmod u+x restart2.sh restart.sh start.sh start2.sh update.sh real_start.sh menu.sh
# 8.运行脚本,这会这 /home/dst/Klei/DoNotStarveTogether 下生成名为“Cluster_1”的存档
./real_start.sh
#6. 移动令牌，这里用的是我的令牌
mv -f DSTserver/Cluster_1/cluster_token.txt /home/dst/Klei/DoNotStarveTogether/Cluster_1/
# 7.世界配置文件
mv -f DSTserver/Cluster_1/Master/* /home/dst/Klei/DoNotStarveTogether/Cluster_1/Master/
mv -f DSTserver/Cluster_1/Caves/* /home/dst/Klei/DoNotStarveTogether/Cluster_1/Caves/
mv -f DSTserver/Cluster_1/cluster.ini /home/dst/Klei/DoNotStarveTogether/Cluster_1/
# 8.配置文件只包括设置中的某些设置
Printf_Green "删除多余文件"
rm -rf DSTserver/ # 删除库
Printf_Green "安装成功，请启动服务器"
sleep 10

