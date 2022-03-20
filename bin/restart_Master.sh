#!/bin/sh
# launch of server Overworld

source /home/dst/server_dst/bin/functions.sh

#Path Directory
name_folder="$SERVER_DST_BIN"

#Command line
start_overworld="sh start_Master.sh"

#Start or Restart the server
screen -dr dst_server1 -X -S quit
cd ${name_folder}
screen -dmS dst_server1 ${start_overworld}
