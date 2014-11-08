OpenWrt VPN自动翻墙配置

采用GraceMode，只对GFW认证IP走VPN流量，配置文件gfwiplist.txt，fork自 https://github.com/SteamedFish/gfwiplist

checkvpn.sh 负责检查vpn是否联通，放cron中每分钟检查1次，fork自 http://www.cnblogs.com/fatlyz/p/3843581.html

addvpnroute.sh 脚本用于添加gfwiplist.txt中的IP走VPN路由，在checkvpn.sh启动VPN后被自动添加
