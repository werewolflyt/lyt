#mkdir /tmp/cpuused
#touch /tmp/cpuused/cpu.txt
#vim cpujiankong.sh
#! /bin/bash
#取系统当前时间（每次重新写入文件>）  
date > /tmp/cpuused/cpu.txt     
#抓取当前cpu的值（以追加的方式写入文件>>）  
top -n 1 | grep Cpu  >> /tmp/cpuused/cpu.txt


  
#取当前空闲cpu百份比值（只取整数部分）  
cpu_kong=`top -b -n 1 | grep Cpu | awk '{print $5}' | cut -f 1 -d "."`   
#设置空闲cpu的告警值为20%，如果当前cpu使用超过80%（即剩余小于20%），立即发邮件告警  
if (($cpu_kong < 20)); then  
	  #提取本服务器的IP地址信息  
      IP=`ifconfig eth0 | grep "inet addr" | cut -f 2 -d ":" | cut -f 1 -d " "` 
      echo "$IP服务器cpu剩余$cpu_kong%，使用率已经超过80%，请及时处理。" | mutt -s "$IP 服务器CPU告警"  -a /tmp/cpuused/cpu.txt werewolf_lyt@163.com

fi  
