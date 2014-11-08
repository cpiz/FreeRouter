#!/bin/bash
export PATH="/bin:/sbin:/usr/sbin:/usr/bin"

WLANGW=`ip route show | grep pppoe-wan | grep link | awk '{print $1}'`
VPNGW='10.8.0.1'
LISTFILE=$(dirname $(readlink -f $0))/gfwiplist.txt

echo "WLAN Gateway:" $WLANGW
echo "VPN Gateway:" $VPNGW

grep -v \# $LISTFILE | grep -v ^$ | grep / | while read LINE
do
    route add -net $LINE gw $VPNGW
done

grep -v \# $LISTFILE | grep -v ^$ | grep -v / | while read LINE
do
    route add -host $LINE gw $VPNGW
done

