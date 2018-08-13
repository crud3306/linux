#!/bin/sh

echo -e "\033[34m \033[1m"
cat <<EOF
++++++++++++++++++++++++++++++++++++++++++++++++
++++++++++ welcome to use system collect +++++++
++++++++++++++++++++++++++++++++++++++++++++++++
EOF

ip_info=`ifconfig |grep "Bcast" |tail -1 |awk '{print $2}' |cut -d: -f 2`
cpu_info1=`cat /proc/cpu_info |grep 'model name' |tail -1 |awk -F: '{print $2}' |sed 's/^ //g' awk '{print $1,$3,$4,$NF}'`
cpu_info2=`cat /proc/cpu_info |grep "physical id" |sort |uniq -c |wc -l`
serv_info=`hostname |tail -1`
disk_info=`fdisk -l |grep "Disk" |grep -v "identifier" |awk '{print $2,$3,$4}' |sed 's/,//g'`
mem_info=`free -m |grep "Mem" |awk '{print "Total",$1,$2"M"}'`
load_info=`uptime |awk '{print "current load: "$(NF-2)}' |SED 's/\,//g'`
mark_info=`Beijing_IDC`

echo -e "\033[32m----------------------\033[1m"
echo IPADDR:$ip_info
echo HOSTNAME:$serv_info
echo CPU_INFO:${cpu_info1} X${cpu_info2}
echo DISK_INFO:$disk_info
echo MEM_INFO:$mem_info
echo LOAD_INFO:$load_info
echo -e "\033[32m----------------------\033[0m"

echo -e -n "\033[36mdo you want to write the data to the db?(y/n)\033[0m"
read ensure

if [ "$ensure" == "yes" -o "$ensure" == "y" -o "$ensure" == 'Y' ];then
	# 写入csv文件
	echo "IPADDR,HOSTNAME,CPU_INFO,DISK_INFO,MEM_INFO,LOAD_INFO" > 1.csv
	echo "${ip_info},${serv_info},${cpu_info1} X${cpu_info2},${disk_info},${mem_info},${load_info}" >> 1.csv


	# 写入数据库，暂时没有实际写入
	echo "---------------------------"
	echo -e '\033[31mmysql -uroot -p123456 -D audit -e ''' "insert into audit_audit_system values('', '${ip_info}', '$serv_info', '${cpu_info1} X${cpu_info2}', '$disk_info', '$mem_info', '$load_info', '$mark_info')" ''' \033[0m'
else
	echo "wait exit ......"
	exit
fi






























































