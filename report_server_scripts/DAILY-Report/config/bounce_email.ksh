#!/bin/ksh


export HOME=/ndata-archive/DAILY-REPORT

export email=$HOME/generic_etl/ksh_scripts/email.pl
export cur_proc_name="Add Bounce Email in Fake List"
export last_day=`date --date="1 day ago" +%Y_%m_%d`
export dy_dir=Effort_${last_day}
export ip=192.168.206.201
export user=datareq
export pswd=tjdatareq
export ftp_dir=/rptbackup/BOUNCE_EMAIL

set -A alphabets A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
export alphabets

cd $HOME/generic_etl/wip

rm -f bounce_email_${last_day}*
rm -f ${last_day}_toemail.txt
rm -f bounce_email_detail*

if [ $1 == "" ]
then
    ./scp_file_162.sh
    mv $1 ${last_day}_2email.txt
    export ftp_dir=/rptbackup/ADHOC_BOUNCE_EMAIL
    export cur_proc_name="Add ADHOC Bounce Email in Fake List"


else

    if [ -r /opt/IronLogParser/${last_day}.txt ]
    then
        cat /opt/IronLogParser/${last_day}.txt | cut -d, -f2,3 | grep ',5.' > ${last_day}_2email.txt
    else
        txt_body="Hi Team,

Bounce email File (${last_day}.txt) did not found on Server : 221
File Location :/opt/IronLogParser
File Name     :${last_day}.txt



Thanks,
dbteam
"
echo "$txt_body" > bounce_email_detail.txt
zip  bounce_email_detail.zip  bounce_email_detail.txt

$email bounce_email_detail "saints@timesgroup.com" "tjbi@timesgroup.com" "Bounce email log file\"${last_day}.txt\" is missing" "$txt_body"
exit

    fi
fi

if [ -r ${last_day}_2email.txt ]
then

sort ${last_day}_2email.txt | uniq > ${last_day}_toemail.txt
echo "count(`wc -l ${last_day}_toemail.txt`)"

rm -f ${last_day}_2email.txt

   echo ${last_day}_toemail.txt
   for i in `cat ${last_day}_toemail.txt`
   do 
       emailid=$(echo ${i} | cut -d, -f1)
       sourcecode=$(echo ${i} | cut -d, -f2 | sed 's/\.//g')
       echo "insert into tcuser.FAKE_EMAIL (EMAILID,SOURCE_CODE,STATUS,CREATE_DATETIME,MODIFIED_DATETIME) values('${emailid}',${sourcecode},'N',current timestamp,current timestamp)" >> bounce_email_${last_day}.txt

       echo "update tcuser.FAKE_EMAIL set SOURCE_CODE = ${sourcecode} ,STATUS = 'N',MODIFIED_DATETIME =current timestamp where EMAILID ='${emailid}' " >> bounce_email_upd_${last_day}.txt
   done
 perl -pi -e "s/''/'/g" bounce_email_${last_day}.txt
 perl -pi -e "s/''/'/g" bounce_email_upd_${last_day}.txt
echo "count(`wc -l bounce_email_${last_day}.txt`)"

zip bounce_email_${last_day}.zip bounce_email_${last_day}.txt
zip bounce_email_upd_${last_day}.zip bounce_email_upd_${last_day}.txt

ftp_file=$HOME/generic_etl/wip/bounce_email.ftp
echo "#!/bin/ksh" > $ftp_file
echo "HOST=$ip" >> $ftp_file
echo "USER=$user" >> $ftp_file
echo "PASSWD=$pswd" >> $ftp_file
echo "ftp -in \$HOST <<EOF" >> $ftp_file
echo "quote USER \$USER" >> $ftp_file
echo "quote PASS \$PASSWD" >> $ftp_file
echo "binary" >> $ftp_file
echo "cd $ftp_dir" >> $ftp_file
echo "pwd" >> $ftp_file
echo "put bounce_email_${last_day}.zip" >> $ftp_file
echo "put ${last_day}_toemail.txt" >> $ftp_file
echo "put bounce_email_upd_${last_day}.zip" >> $ftp_file
echo "quit" >> $ftp_file
echo "EOF" >> $ftp_file
#execute FTP script
chmod 755 ${ftp_file}
${ftp_file}

txt_body="Hi Team,

Please find Bounce Email Script on server 201,

Location :/rptbackup/BOUNCE_EMAIL 

File Name :bounce_email_${last_day}.zip and bounce_email_upd_${last_day}.zip 


Execute script on both TJ LIVE CAND and LIVE HIRE DB.



Thanks,
dbteam
"
echo "$txt_body" > bounce_email_detail.txt
zip  bounce_email_detail.zip  bounce_email_detail.txt

$email bounce_email_detail "saints@timesgroup.com" "tjbi@timesgroup.com" "$cur_proc_name" "$txt_body"
else

txt_body="Hi Sanjay,

Bounce email Script could not be grenerated 
because of missing source file:${last_day}.txt 
Server : 201
Location :/opt/IronLogParser




Thanks,
dbteam
"
echo "$txt_body" > bounce_email_detail.txt
zip  bounce_email_detail.zip  bounce_email_detail.txt

$email bounce_email_detail "sanjay.biswas@timesgroup.com" "tjbi@timesgroup.com" "$cur_proc_name" "$txt_body"
fi

rm -f bounce_email_${last_day}* 
rm -f bounce_email_upd_${last_day}.zip
rm -f bounce_email_detail*
exit

