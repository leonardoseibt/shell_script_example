#! /bin/sh

website[0]='zufang.hfhouse.com/chuzu/'����#��վ1
mobile[0]='15955159890'�������������������� #��Ӧ��վ1 �ֻ�����

website[1]='oldhouse.hfhouse.com/chushou/' #ͬ��2
mobile[1]='15955159890'                    #ͬ��2

#�Դ����ƣ�����վ���� ��ɽ����ļ��������ݿ��ȡ��ʽ

length=${#website[@]}   #��ȡ��վ������
for ((i=0; i<$length; i++)) #ѭ��ִ��
do
   status=$(curl -I -m 10 -o /dev/null -s -w %{http_code} ${website[$i]})   #CURL ��ȡhttp״̬��
   if [ "$status"x != "200"x ]; then      #����Ƿ�Ϊ 200(����)
    echo ${website[$i]} '=>' $status  
    #php /htdoc/jk/shell_monitor.php ${mobile[$i]} ${website[$i]}'=>AccessError!'  #ִ��PHP�ļ�(ʹ��PHP��ҪΪ�˲��õ�����������⣬�˴�Ҳ�ɽ���Mail����)
   fi #����if
done #���� do

#ִ�У�crontab -e
#д�����ݣ�5 * * * * /shell path
#(������5����ִ��һ��

