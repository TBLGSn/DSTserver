#!/bin/bash
###
 # @Author: tblgsn
 # @Date: 2022-03-02 13:20:04
 # @Description: 
 # @FilePath: \DSTserver\bin\menu.sh
### 
source functions.sh
# 0. 安装服务器
install() {
    chmod u+x installdst.sh # 添加运行权限
    bash installdst.sh 
}
# 1. 当前服务器状态（测试 所有服务器）
verity_status(){
    Master_status=$(ps -ef | grep "sh start_Master.sh" | grep -v grep | awk '{print $2}')
    Caves_status=$(ps -ef  | grep "sh start_Caves.sh"  | grep -v grep | awk '{print $2}')
    if [ -n "$Master_status" ]; then
        Printf_Green "饥荒地面世界正在运行"
    else
        Printf_RED "饥荒地面世界已停止"

    fi
    if [ -n "$Caves_status" ]; then
        Printf_Green "饥荒地下世界正在运行"
    else 
        Printf_RED "饥荒地下世界已停止"
    fi 
}
# 2. 更新任务等
# TODO每天6点准时更新 设置定时
update() {
    cd "$SERVER_DST_BIN" || Printf_RED "设置定时任务出错"
}

# 3. 启动服务器
start_server() {
    # cd $SERVER_DST_BIN || Printf_RED "错误"
    # nohup ./start_Master.sh  >/dev/null 2>&1 &
    # nohup ./start_Caves.sh  >/dev/null 2>&1 &
    restart_server
    # Printf_Green "启动成功,3s 后返回主菜单"
    sleep 3
}
# 3. 停止服务器
stop_server(){
    Master_id=$(ps -ef | grep "sh start_Master.sh" | grep -v grep | awk '{print $2}')
    Caves_id=$(ps -ef  | grep "sh start_Caves.sh"  | grep -v grep | awk '{print $2}')
    
    if [ -n "$Master_id" ];then
          kill -9 $Master_id
    fi
    
    if [ -n "$Caves_id" ];then
        kill -9 $Caves_id
    fi
    # htop -u dst
    Printf_Green "服务器停止成功，5s后返回主菜单"
    sleep 5
}
# 4.重启服务器(默认重启洞穴和主世界)
restart_server(){
    bash "$SERVER_DST_BIN/restart_Master.sh"
    bash "$SERVER_DST_BIN/restart_Caves.sh"
    Printf_Green "启动成功,5s 后返回主菜单"
    sleep 5
}
# 5.卸载饥荒服务器
uninstall() {
    stop_server
    userdel -rf dst
    rm -rf /home/Steam
    Printf_Green "卸载成功,5s 后退出脚本"
    sleep 10
}
# 5.查看世界访客

# 6.blocklist.txt (重启生效)
# 7.添加mods
addmods(){
    echo '请输入需要的 modid（ 各id间使用,分隔 eg. 374550642,378160973,375850593,458587300,375859599 ） :'
    read  modid_list
    echo ' return {' > "$DONOTSTARVE_DIR_CLUSTER_MASTER/modoverrides.lua"
    echo ' return {' > "$DONOTSTARVE_DIR_CLUSTER_CAVES/modoverrides.lua"
    if [[ $modid_list != '' ]]; then
        IFS=',' mod_list=($modid_list)
        for mod_id in ${mod_list[@]}; do
            echo "ServerModSetup(\"$mod_id\")" >> "$SERVER_DST/mods/dedicated_server_mods_setup.lua"
            echo "[\"workshop-$mod_id\"] = { enabled = true }," >> "$DONOTSTARVE_DIR_CLUSTER_MASTER/modoverrides.lua"
            echo "[\"workshop-$mod_id\"] = { enabled = true }," >> "$DONOTSTARVE_DIR_CLUSTER_CAVES/modoverrides.lua"
        done
    fi
    echo ' }' >> "$DONOTSTARVE_DIR_CLUSTER_MASTER/modoverrides.lua"
    echo ' }' >> "$DONOTSTARVE_DIR_CLUSTER_CAVES/modoverrides.lua"
}


deletemods(){
    echo  "输入删除的mods号"
    read -r delete_name
    cat "$SERVER_DST/mods/dedicated_server_mods_setup.lua" | grep -v "ServerModSetup(\"$delete_name\")" > temp.lua
    touch temp.lua
    cat temp.lua > a.lua
    rm -rf temp.lua
}
showmods(){
    cat "$SERVER_DST/mods/dedicated_server_mods_setup.lua" | while read line
    do
        id=$(echo "$line" | grep  "^ServerModSetup(\"[0-9]*\")" | awk -F '\)' '{print $1}'  | tr -cd [0-9])
        if [  -n "$id" ];then
            echo "$id"
        fi
    done
}
mods(){
    while true

    do    
        echo   "Mods 管理模块"
        echo -en "1)添加mods"
        echo -e "\t2)删除mods"
        echo -en  "3)显示所有mod"
        echo -e  "\t4)退出mods管理模块"
        echo -en "请输入你的选项:"
        read -r  option    
        case $option in
        1) addmods;; 
        2) deletemods;;
        3) showmods;;
        4) break;;
        *) ;;
        esac
    done
}
# 0. 主菜单

function main_menu() {
    while  true 
    do
        clear
        PS3="输入选项(其他任意键退出):"
        select option in  "安装服务器" "运行服务器" "重启服务器" "停止服务器" "管理存档" "管理mod" "检查服务器状态"
        do
            case $option in
            "安装服务器") install ;;
            "运行服务器") start_server ;;
            "重启服务器") restart_server;;
            "停止服务器") stop_server;;
            "管理存档") echo "管理存档";;
            "管理mod") mods;;
            "检查服务器状态") verity_status;;
            *) exit;;
            esac
        done
    done
}


main_menu