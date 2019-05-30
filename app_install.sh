#!/bin/bash
# app自动部署安装脚本

authorized="unauthorized"
basepath=$(cd `dirname $0`; pwd)
app=$basepath"/"app-meituan-9.15.201.apk
adb devices >devices.txt
Echo “开始读取手机devices_number”
sed '1d' devices.txt|grep -v ^$|while read line
do
  devices_info=`echo $line|awk '{print $1}'`
  connection=`echo $line|awk '{print $2}'`
  echo $devices_info
  if [ "$connection"x = "$authorized"x ];then
    echo "vysor连接失败"
  else
    adb -s $devices_info install $app
  fi
  #adb -s $devices_info install -r  $app
  if [ $? -eq 0 ];then
    echo "$devices_info anzhang完成"
  else
    echo "$devices_info anzhang失败"
  fi
done

rm -f devices.txt
