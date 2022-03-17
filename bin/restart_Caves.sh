#!/bin/sh
# launch of server Cave
source functions.sh

#Path Directory
name_folder="$SERVER_DST_BIN"

#Command line
start_cave="sh start_Caves.sh"

#Start or Restart the server
screen -dr dst_server2 -X -S quit
cd ${name_folder}
screen -dmS dst_server2 ${start_cave}
