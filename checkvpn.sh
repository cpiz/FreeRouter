#!/bin/bash


DATE="["`date`"]"
LOCKFILE="/tmp/checkvpn.lock"
LOGFILE="/tmp/checkvpn.log"
ADDROUTESHELL=$(dirname $(readlink -f $0))/addvpnroute.sh


if [ -f "$LOCKFILE" ]
then
    echo $DATE "another checker instance is running, exit"
    echo $DATE "another checker instance is running, exit" >> $LOGFILE
    exit 0
fi


ping -s 1024 -c 5 twitter.com


VPN_CONN=`ifconfig | grep pptp-vpn`
if [ -z "$VPN_CONN" ]
then
    touch $LOCKFILE
    echo $DATE "WAN_VPN_RECONNECT"
    echo $DATE "WAN_VPN_RECONNECT" >> $LOGFILE

    ifdown vpn
    sleep 10
    ifup vpn
    sleep 40
    sh $ADDROUTESHELL

    rm $LOCKFILE
else
    echo $DATE "vpn is connected"
    echo $DATE "vpn is connected" >> $LOGFILE
fi

