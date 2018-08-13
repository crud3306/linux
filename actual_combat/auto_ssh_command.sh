#!/bin/sh

# 作用：批量在多台远程服务上，远程执行命令

if [ ! -f ip.txt ];then
	echo -e "\033[31mplease create ip.txt file, the ip.txt contains as follows:\033[Om"
cat <<EOF
192.168.145.126
192.168.145.127
EOF
	exit
fi

if [ -z "$*" ];then
	echo -e "\033[31musage:$0 command, example { rm /tmp/test.txt | mkdir /tmp/20170711 } \033[Om"
	exit
fi

count = `cat ip.txt |wc -l`
rm -rf ip.txt.swp
i=0
while ((i < $count))
do
	# expr 算述运算
	i=`expr $i + 1`
	sed "${i}s/^/&${i} /g" ip.txt >> ip.txt.swp

	IP=`awk -v I="$i" '{if(I==$1) print $2}' ip.txt.swp`

	ssh -q -l root $IP "$*;echo -e '--------\nthe $IP exec command: $* success!';sleep 2"
done














































