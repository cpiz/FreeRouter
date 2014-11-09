#!/bin/sh

LOGFILE="/tmp/autoconnvpn.log"
DATE="["`date`"]"

if [ -f "/tmp/vpn_status_check.lock" ]
then
    echo $DATE "another checker instance is running, exit" >> $LOGFILE
    exit 0
fi

ping -s 1024 -c 5 twitter.com

VPN_CONN=`ifconfig | grep pptp-vpn`

if [ -z "$VPN_CONN" ]
then
    touch /tmp/vpn_status_check.lock
    echo $DATE "WAN_VPN_RECONNECT" >> $LOGFILE

#   ifdown vpn
#   ifdown wan
#   sleep 10
#   ifup wan
#   sleep 30

    ifdown vpn
    sleep 10
    ifup vpn
    sleep 40

    sh /root/autogracevpn.sh

    rm /tmp/vpn_status_check.lock
else
    echo $DATE "vpn is connected" >> $LOGFILE
fi

