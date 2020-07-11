#!/bin/sh

SOURCE_DIR=(
	$*
)

TARGET_DIR=/data/backup/
YEAR=`date +%Y`
MONTH=`date +%m`
DAY=`date +%d`
WEEK=`date +%u`
A_NAME=`date +%H%M`
FILES=system_backup.tar.gz
CODE=$?

if [ -z "$*" ];then
	echo -e "\033[32musage:\nplease enter your backup files or directories\n--------------------\n\nusage: { $0 /boot /etc}\033[0m"
	exit
fi

if [ !-d $TARGET_DIR/$YEAR/$MONTH/$DAY ];then
	mkdir -p $TARGET_DIR/$YEAR/$MONTH/$DAY
	echo -e "\033[32mthe $TARGET_DIR created successfully!\033[0m"
fi

full_backup()
{
	if [ "$WEEK" -eq "7" ];then
		rm -rf $TARGET_DIR/snapshot
		cd $TARGET_DIR/$YEAR/$MONTH/$DAY;tar -g $TARGET_DIR/snapshot -zcvf $FILES ${SOURCE_DIR[@]}
		[ "$CODE" == "0" ] && echo -e "-------------\n\033[32mthese full_backup system files backup successfully.\033[0m"
	fi
}

add_backup()
{
	if [ "$WEEK" -ne "7" ];then
		cd $TARGET_DIR/$YEAR/$MONTH/$DAY;tar -g $TARGET_DIR/snapshot -zcvf $A_NAME$FILES ${SOURCE_DIR[@]}
		[ "$CODE" == "0" ] && echo -e "-------------\n\033[32mthese full_backup system files $TARGET_DIR/$YEAR/$MONTH/$DAY/$A_NAME$FILES backup successfully.\033[0m"
	fi
}

sleep 3
full_backup;add_backup




























