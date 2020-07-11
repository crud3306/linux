#!/bin/sh

BACK_DIR=/data/backup/`date +%Y%m%d`
MYSQL_DB=discuz
MYSQL_USR=backup
MYSQL_PW=123456
MYSQL_CMD=/usr/local/mysql/bin/mysqldump


if [ $UID -ne 0 ];then
	echo "must to use root for exec shell"
	exit
fi

if [ ! -d $BACK_DIR ]; then
	mkdir -p $BACK_DIR
	echo -e "\033[32mthe $BACK_DIR create successfully\033[0m"
else 
	echo -e "\033[32mthis $BACK_DIR is exists ...\033[0m"
fi

#mysql backup command
#mysqldump -uxxx -pxxxx -d db_name > /xxxx/xxx.sql
$MYSQL_CMD -u$MYSQL_USR -p$MYSQL_PW -d $MYSQL_DB > $BACK_DIR/${MYSQL_DB}.sql

if [ $? -eq 0 ];then
	echo -e "\033[32mthe mysql backup $MYSQL_DB successfully \033[0m"
else
	echo -e "\033[32mthe mysql backup $MYSQL_DB failed please check.\033[0m"
fi














































