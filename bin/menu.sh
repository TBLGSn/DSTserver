#!/bin/bash
# 0. 安装服务器
install() {
    chmod u+x installdst.sh # 添加运行权限
    bash installdst.sh 
}
# 1. 当前服务器状态（测试 所有服务器）
verity_status(){
    tail -f /home/dst/Klei/DoNotStarveTogether/Cluster_1/Master/server_log.txt
    tail -f /home/dst/Klei/DoNotStarveTogether/Cluster_1/Caves/server_log.txt
}
# 2. 更新任务等
# TODO每天6点准时更新 设置定时
update() {
    cd /home/dst/server_dst/bin || Printf_RED "设置定时任务出错"
}
Printf_Green(){
    echo -e "\033[42;37m $* \033[0m"
}
# 3. 启动服务器
start_server() {
    cd /home/dst/server_dst/bin/
    nohup ./start.sh  >/dev/null 2>&1 &
    nohup ./start2.sh  >/dev/null 2>&1 &
    Printf_Green "启动成功,5s 后返回主菜单"
    sleep 5
}
# 3. 停止服务器
stop_server(){
    htop -u dst
    Printf_Green "服务器停止成功，5s后返回主菜单"
    sleep 5
}
# 4.重启服务器(默认重启洞穴和主世界)
restart_server(){
    bash /home/dst/server_dst/bin/restart.sh
    bash /home/dst/server_dst/bin/restart2.sh
    Printf_Green "重启成功,5s 后返回主菜单"
    sleep 10
}
# 5.卸载饥荒服务器
uninstall() {
    stop_server
    userdel -rf dst
    rm -rf /home/Steam
    Printf_Green "卸载成功,5s 后推出脚本"
    sleep 10
}
# 5.查看世界访客

# 6.blocklist.txt (重启生效)
# 7.添加mods
addmods(){
    mkdir "Don't Starve Together"
    cd  Don\'t\ Starve\ Together/ || Printf_RED "进入Don\'t\ Starve\ Together错误"
    mkdir mods && touch dedicated_server_mods_setup.lua
    echo 'ServerModSetup("1378549454")' >> dedicated_server_mods_setup.lua
}
# 0. 主菜单

function main_menu() {
    while  'true' 
    do
        clear
        PS3="输入选项(其他任意键退出):"
        select option in  "安装服务器" "运行服务器" "重启服务器" "停止服务器" "管理存档" "管理mod" "任意键退出"
        do
            case $option in
            "安装服务器") install clear;; 
            "运行服务器") start_server clear;;
            "重启服务器") restart_server;;
            "停止服务器") stop_server;;
            "管理存档") break;;
            *)
                clear
                exit
            esac
        done
    done
}
main_menu