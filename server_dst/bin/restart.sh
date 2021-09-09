#!/bin/sh
# launch of server Overworld

#Path Directory
name_folder="/home/dst/server_dst/bin"

#Command line
start_overworld="sh start.sh"

#Start or Restart the server
screen -dr dst_server1 -X -S quit
cd ${name_folder}
screen -dmS dst_server1 ${start_overworld}
