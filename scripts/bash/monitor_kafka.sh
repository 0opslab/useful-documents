#! /bin/bash

#@func{用于监控kafka的状态检测进程是否存在}
ps -fe|grep processString |grep -v grep
if [ $? -ne 0 ]
  then
  echo "start process....."
  else
  echo "runing....."
fi

