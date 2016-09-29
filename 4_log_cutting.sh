#!/bin/bash
#日志切割
#缺点：文件的大小需要通过手动设置一个值，当多个文件需要分时分段扫描时，有缺陷

mkdir log_big_bak 2>sh_err_log #建立备份目录
echo "please input any key to start and input 'e' to end" 
read INPUT
if [ $INPUT = "e" 2>sh_err_log ]
then
	break;
fi
echo "running..."
while :
do
	#当access.log文件大于一个值：如 500M
	LOCK_FILE=`find . -maxdepth 1 -size +500000000c 2>sh_err_log`
	if [ -z $LOCK_FILE ]
	then
		LOCK_FILE=`find . -maxdepth 1 -size +500000000c 2>sh_err_log`
		sleep 30  #每隔30s对文件进行判断，大于设定值时将其备份	
		continue; 
	fi
	echo $LOCK_FILE" is beyond 500000000c"
	DATEF=`date +%y%m%d%H%M%S`
	mv $LOCK_FILE $LOCK_FILE"_bak_"$DATEF 2>sh_err_log
	mv $LOCK_FILE"_bak_"$DATEF log_big_bak 2>sh_err_log
done