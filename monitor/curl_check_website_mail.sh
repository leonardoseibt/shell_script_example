#curl������curl��һ���������µ�http���ع��ߣ�����wget����wget���ƣ���Ҳ����ͨ������ָ����http header�����������жϷ����״̬��
# �������һ��ʹ��curl���ҳ������Եķ�����
# ����ʹ�������������ɼ�ҳ���״̬�롣�����������ؽ��Ϊ200��˵������������������ص����������룬˵���쳣��
#curl -o /dev/null -s -w %{http_code} http://www.btschina.com/
#-o �������ǰ����ص��������ݶ��ض���/dev/null��-s�����������curl������������-w�������Ǹ��������Լ�����Ҫ���Զ�����curl�������ʽ��
#curlֻ���ط�������Ӧ״̬�����������ݣ�����200�������ģ������Ĳ��������򵥵��������£�
#echo ��curl -o /dev/null -s -m 10 �Cconnect-timeout 10 -w %{http_code} http://www.btschina.com/��
#200

#����Ϊ����ʵ���ű���
#!/bin/bash
 #CHECK SLB

while :;do

sleep 10

URL=��http://www.btschina.com/SA_Test_Page.html��
HTTPOKID=`curl -o /dev/null -s -m 10 �Cconnect-timeout 10 -w %{http_code} $URL`

if [ $HTTPOKID -eq 200 ];then

echo ��OK!��

else

/bin/echo -e ������,$URL�޷�����,$HTTPOKID,����������!�� | sendEmail -f monitor@btschina.com -t test@btschina.com -u ����,$URL�޷�����,����������! -s smtp.exmail.qq.com -xu monitor@btschina.com -xp one168 >> /tmp/err.txt 2>&1

fi

done

#�����վ���ʵ����
#!/bin/bash
 #CHECK URL STATUS

while :;do

URL1=��http://www.btschina.com/SA_Test_Page.html��
URL2=��http://bbs.btschina.com/SA_Test_Page.html��

for i in $URL{1..2}

do

HTTPOKID=`curl -o /dev/null -s -m 10 �Cconnect-timeout 10 -w %{http_code} $i`

if [ $HTTPOKID -eq "200" ];then

echo ����

else

/bin/echo -e ��$i �޷�����,$HTTPOKID,����������!�� | sendEmail -f
 monitor@btschina.com -t test@btschina.com -u $i -s
 smtp.exmail.qq.com -xu monitor@btschina.com -xp one168 >> /tmp/err.txt 2>&1

fi

done

