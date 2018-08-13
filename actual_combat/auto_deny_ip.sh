#!/bin/sh

#作用：自动禁止ssh登录错误次数过多的ip

#定义目标文件
SEC_FILE=/var/log/secure

#截取secure文件恶意ip，远程登录22端口，大于等于4次就写入防火墙。以达到禁止以后再登录服务器的22端口
#egrep -o "([0-9]{1,3}\.){3}[0-9]{1,3}" 是匹配ip的意思
IP_ADDR=`tail -n 1000 $SEC_FILE |grep "Failed password" |egrep -o "([0-9]{1,3}\.){3}[0-9]{1,3}" |sort -nr |uniq -c |awk '$1>=4 {print $2}'`
#防火墙文件
IPTABLE_CONF=/etc/sysconfig/iptables


echo
cat <<EOF
++++++++++++++ welcome to use ssh login drop failed ip ++++++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
++++++++++++++-----------------------------------------++++++++++++
EOF

for i in `echo $IP_ADDR`
do
	#查看iptables配置文件是否已含有要禁止的ip 
	cat $IPTABLE_CONF |grep $i > /dev/null
	#如果已存在要禁止的ip，则添加
	if [ $? -ne 0 ];then
		sed -i "/lo/a -A INPUT -s $i -m state --state NEW -m tcp -p tcp --dport 22 -j DROP" $IPTABLE_CONF
	else
		echo "$i is exists in iptabeles, please exit ...."
	fi
done

#最的重启iptables生效
/etc/init.d/iptables restart




























