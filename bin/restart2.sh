#!/bin/sh
# launch of server Cave

#Path Directory
name_folder="/home/dst/server_dst/bin"

#Command line
start_cave="sh start2.sh"

#Start or Restart the server
screen -dr dst_server2 -X -S quit
cd ${name_folder}
screen -dmS dst_server2 ${start_cave}
