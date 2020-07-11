#!/bin/sh

# 作用：批量同步文件到多台远程服务器

if [ ! -f ip.txt ];then
	echo -e "\033[31mplease create ip.txt file, the ip.txt contains as follows:\033[Om"
cat <<EOF
192.168.145.126
192.168.145.127
EOF
	exit
fi

if [ -z "$1"];then
	echo -e "\033[31musage：$0 command，example{src_files|src_dir des_dir}\033[Om"
	exit
fi

count=`cat ip.txt |wc -l`
rm -rf ip.txt.swp
i=0
while ((i< $count))
do 
	i=`expr $i+1`
	sed "${i}s/^/&${i} /g" ip.txt >>ip.txt.swp
	IP=`awk -v I="$i" '{if(I==$1) print $2}' ip.txt.swp`

	#$1 是执行该脚本时传递的每1个参数，$2 是第2个参数
	scp -r $1 root@${IP}:$2
	#也可以用rsync，如下
	#rsync -aP --delete $1 root@${IP}:$2
done
































