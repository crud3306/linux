#!/bin/sh

#作用：自动部署

flush()
{
	if [ ! -f rsync.list ];then
		echo -e "\033[31mplease create rsync.list file, the rsync.list contains as follows:\033[Om"
cat <<EOF
192.168.145.126 src_dir des_dir
192.168.145.127 src_dir des_dir
EOF
		exit
	fi

	rm -rf rsync.list.swp
	cat rsync.list |grep -v "#" > rsync.list.swp
	COUNT=`cat rsync.list.swp |wc -l`
	NUM=0

	while ((${NUM} < $COUNT))
	do
		NUM=`expr $NUM + 1`
		line=`sed -n "${NUM}p" rsync.list.swp`
		SRC=`echo $Line |awk '{print $2}'`
		DES=`echo $Line |awk '{print $3}'`
		IP=`echo $Line |awk '{print $1}'`
		rsync -av ${SRC}/ root@${IP}:${DES}/
		#下面的命令，是强制同步。即保证目录一模一样。如果目标机上的文件有增加，会在同步时被删除掉
		#rsync -aP --delete ${SRC}/ root@${IP}:${DES}/
	done
}

restart()
{
	rm -rf rsync.list.swp
	cat rsync.list |grep -v "#" >> rsync.list.swp
	COUNT=`cat rsync.list.swp |wc -l`
	NUM=0

	while ((${NUM} < $COUNT))
	do
		NUM=`expr $NUM + 1`
		line=`sed -n "${NUM}p" rsync.list.swp`
		Command=`echo $Line |awk '{print $2}'`
		IP=`echo $Line |awk '{print $1}'`
		ssh -l root $IP "sh $Command;echo -e '----------\nthe $IP exec command : sh $Command success!'"
	done
}

case $i in
	flush )
	flush
	;;
	restart )
	restart
	;;
	* )
	echo -e "\033[31musage: $0 command, example{flush | restart} \033[Om"
	;;
esac
































