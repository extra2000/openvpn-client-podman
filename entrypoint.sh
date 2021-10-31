#!/bin/sh
set -e

if [ ! -e /dev/net/tun ]; then
    mkdir -pv /dev/net
    mknod /dev/net/tun c 10 200
fi

iptables -t nat -A POSTROUTING -s "0/0" -j MASQUERADE

exec "$@"
