#!/bin/ksh

HOME=/ndata-archive/DAILY-REPORT
export email=$HOME/generic_etl/ksh_scripts/email.pl
export cur_proc_name="AD_IDs of Bounce Emails "
export last_day=`date --date="1 day ago" +%Y_%m_%d`
export dy_dir=Effort_${last_day}
export ip=192.168.206.201
export user=datareq
export pswd=tjdatareq
export ftp_dir=/rptbackup/BOUNCE_EMAIL

set -A alphabets A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
export alphabets

cd $HOME/generic_etl/wip

zip bounce_ad_id_${last_day}.zip bounce_ad_id_${last_day}.txt

if [ -r  bounce_ad_id_${last_day}.txt ]
then

txt_body="Hi Pravesh,

Please find AD_IDs in attached ZIP file, these all have bounce email..



Thanks,
dbteam
"
echo "$txt_body" > bounce_email_detail.txt

$email bounce_ad_id_${last_day} "pravesh.suyal@timesgroup.com" "sanjay.biswas@timesgroup.com,tjbi@timesgroup.com" "$cur_proc_name" "$txt_body"
else

txt_body="Hi Sanjay,

Bounce AD_ID Script could not be grenerated 
because of missing souce file: bounce_ad_id_${last_day}.txt 
Server : 201
Location :wip




Thanks,
dbteam
"
echo "$txt_body" > bounce_email_detail.txt
zip  bounce_email_detail.zip  bounce_email_detail.txt

$email bounce_email_detail "sanjay.biswas@timesgroup.com" "tjbi@timesgroup.com" "$cur_proc_name" "$txt_body"
fi

rm -f bounce_ad_id_${last_day}.txt 
rm -f bounce_email_detail*

mv  bounce_ad_id_${last_day}.zip  ../data_archive/
exit

