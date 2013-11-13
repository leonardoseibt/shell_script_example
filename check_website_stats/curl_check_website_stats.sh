#��ػ����б��ļ���
#server.list
#
#server1
#server2
#server3

 
#
#������ؽű��� webstatus.sh

 

#!/bin/sh
monitor_dir=/home/admin/monitor/
if [ ! -d $monitor_dir ]; then
    mkdir $monitor_dir
fi
cd $monitor_dir
web_stat_log=web.status
if [ ! -f $web_stat_log ]; then
   touch $web_stat_log
fi
server_list_file=server.list
if [ ! -f $server_list_file ]; then
   echo "`date '+%Y-%m-%d %H:%M:%S'` ERROR:$server_list_file NOT exists!" >>$web_stat_log
exit 1
fi
#total=`wc -l $server_list_file|awk '{print $1}'`
for website in `cat $server_list_file`
do
   url="http://$website/app.htm"
   server_status_code=`curl -o /dev/null -s -m 10 --connect-timeout 10 -w %{http_code} "$url"`
   if [ "$server_status_code" = "200" ]; then 
        echo "`date '+%Y-%m-%d %H:%M:%S'` visit $website status code 200 OK" >>$web_stat_log
   else 
        echo "`date '+%Y-%m-%d %H:%M:%S'` visit $website error!!! server can't connect at 10s or stop response at 10 s, send alerm sms ..." >>$web_stat_log
        echo "!app alarm @136xxxxxxxx  server:$website can't connect at 10s or stop response at 10s ..." | nc smsserver port &
   fi
done
exit 0

 

#��Ҫ������ curl -o /dev/null -s -m 10 --connect-timeout 10 -w %{http_code} "$url" ����״̬���Ƿ�200,���10sû�з���200״̬�룬�򷢾���

#�����linux ��ʱִ�нű���

#crontab -e

#*/10 * * * * /home/admin/app/bin/webstatus.sh

#����ÿ��10���Ӿͻ�ִ��һ��
#���������һ�ֽű�д����

#!/bin/bash

while read URL
  do
    echo `date`
    result=`curl -o /dev/null -s -m 10 --connect-timeout 10 -w %{http_code}  $URL`
    test=`echo $result`
    if [[  "$test" = "200"  ]]
      then
        echo "$URL is ok"
    else
      echo "test err"
/usr/sbin/sendmail -t << EOF
From:SD-Detect
To:13918888888@139.com,13800000000@139.com
Subject:Detected $URL
------------------------------
${URL} is err!!
------------------------------
EOF
    fi
  done < /root/jiankong/httplist.txt

