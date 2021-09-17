#!/bin/bash
# 0. 安装服务器
install() {
    chmod u+x installdst.sh # 添加运行权限
   ./installdst.sh 
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
# 3. 启动服务器
start_server() {
    cd /home/dst/server_dst/bin/
    nohup ./start.sh  >/dev/null 2>&1 &
    nohup ./start2.sh  >/dev/null 2>&1 &
}
# 3. 停止服务器
stop_server(){
    htop -u dst
}
# 4.重启服务器(默认重启洞穴和主世界)
restart_server(){
    sh /home/dst/server_dst/bin/restart.sh
    sh /home/dst/server_dst/bin/restart2.sh
}
# 5.卸载饥荒服务器
uninstall() {
    stop_server
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
            "运行服务器") start_server;;
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