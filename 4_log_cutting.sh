#!/bin/bash
#日志切割

mkdir log_big_bak #建立备份目录
echo "please input any key to start and input 'e' to end" 
read INPUT
if [ $INPUT = "e" ]
then
	break;
fi
echo "running..."
while :
do
	#当access.log文件大于一个值：如 500M
	sleep 30 
	LOCK_FILE=access.log
	i=`du -k access.log | awk '{print $1}'` 
	if [ $i -gt 500000000 ]
	then
		echo $LOCK_FILE" is beyond 500000000c"
		DATEF=`date +%y%m%d%H%M%S`
		mv $LOCK_FILE $LOCK_FILE"_bak_"$DATEF 
		mv $LOCK_FILE"_bak_"$DATEF log_big_bak
		cat /dev/null > access.log
	fi
done