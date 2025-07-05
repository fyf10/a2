#!/bin/sh
#aria2c --enable-rpc --rpc-listen-all=false --rpc-allow-origin-all -c -D
aria2c --conf-path=/home/.config/aria2/aria2.conf -D
#nginx -g "daemon off;"
