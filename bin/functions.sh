#!/bin/bash

Printf_RED(){
    echo -e "\033[41;37m $* \033[0m"
}
Printf_Green(){
    echo -e "\033[42;37m $* \033[0m"
}

INSTALL_DIR="/home/dst" # 安装目录
DONOTSTARVE_DIR="$INSTALL_DIR/Klei/DoNotStarveTogether" # 存档位置
DONOTSTARVE_DIR_CLUSTER="$DONOTSTARVE_DIR/Cluster_1" # 存档实际位置
DONOTSTARVE_DIR_CLUSTER_MASTER="$DONOTSTARVE_DIR_CLUSTER/Master" # 存档实际位置  
DONOTSTARVE_DIR_CLUSTER_CAVES="$DONOTSTARVE_DIR_CLUSTER/Caves" # 存档实际位置  
SERVER_DST="$INSTALL_DIR/server_dst" # 脚本位置
SERVER_DST_BIN="$SERVER_DST/bin" # 脚本位置
