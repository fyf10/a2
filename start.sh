#!/bin/sh
aria2c --conf-path=/etc/aria2/aria2.conf --daemon
nginx -g "daemon off;"
