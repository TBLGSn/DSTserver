#!/bin/bash
cd /home/dst/server_dst/bin/
nohup ./restart_Master.sh  >/dev/null 2>&1 &
nohup ./restart_Caves.sh  >/dev/null 2>&1 &