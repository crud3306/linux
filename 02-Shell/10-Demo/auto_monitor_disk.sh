#!/usr/sh
# 作用：自动监测磁盘状态，超过多少时报警发邮件

echo -e "\033[31m \033[1m"
rm -rf list.txt

LIST=`df -h |grep "^/dev/" >>list.txt`

cat <<EOF
+++++++++++++++++++++++++++++++++++++++++++++++++++++
++++++++ welcome to use auto monitor system +++++++++
+++++++++++++++++++++++++++++++++++++++++++++++++++++
EOF

echo -e "\033[32m------------------------\033[0m"
echo 
sleep 2

while read line
do
	IP_ADDR=`ifconfig eth1 |grep "Bcast" |awk '{print $2}' |cut -d: -f 2`
	D_Name=`echo $line |awk '{print $1,$NF"分区"}'`
	D_Total=`echo $line|awk '{print $2}'`
	D_Avail=`echo $line|awk '{print $4}'`
	D_Percent=`echo $line|awk '{print $5}' |sed 's/%//g'`

	if [ "$D_Percent" -ge 50 ];then

cat >email.txt <<EOF
******************** Email *********************
通知类型：故障

服务：disk monitor
主机：$IP_ADDR
状态：警告

日期/时间：周二 2017年09月11日 15时:15分:15秒 CST

额外信息：

CRITICAL - DISK Monitor: $D_Name used more than ${D_Percent}%
EOF

		echo -e "\033[32mthe $D_Name has been used for more than ${D_Percent}%, please check.\033[0m"
		mail -s "$D_Name warning" crud3306@163.com <email.txt
		#echo "the $D_Name has been used for more than ${D_Percent}%, please check."|mail -s "$D_Name warning" crud3306@163.com
	fi

done <list.txt

echo -e "\n\033[32m------------------------\033[1m"
echo "done"





























