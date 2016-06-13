#!/bin/ksh

set +x


#ADD LEADS

cd $HOME/generic_etl/wip/lead

export ip=172.16.84.221
export user=datareq
export pswd=datareq
#export ftp_dir=/databackup/DAILY-REPORT/lead_files/adhoc_mails
export ftp_dir=/ndata-archive/DAILY-REPORT/lead_files/adhoc_mails
rm -f $HOME/generic_etl/wip/lead/*

ftp_file=$HOME/generic_etl/wip/lead/scp_file.ftp
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
echo "mget *.txt" >> $ftp_file
echo "mdel *.txt" >> $ftp_file
echo "quit" >> $ftp_file
echo "EOF" >> $ftp_file
#execute FTP script
chmod 755 ${ftp_file}
${ftp_file}

rm -f $HOME/generic_etl/sql_scripts/crm_lead_capture_email_dedupe.sql
rm -f $HOME/generic_etl/ctl/crm_lead_capture_email_dedupe.sql
cat $HOME/generic_etl/wip/lead/*.txt > $HOME/generic_etl/wip/tmp_adhoc_mail.txt
dos2unix $HOME/generic_etl/wip/tmp_adhoc_mail.txt

mv $HOME/generic_etl/wip/tmp_adhoc_mail.txt $HOME/generic_etl/wip/lead/tmp_adhoc_mail.txt 

file_exist=`cat $HOME/generic_etl/wip/lead/tmp_adhoc_mail.txt | wc -l `

if [ ${file_exist} -gt 0 ]
then
   perl -pi -e "s/^/adhoc_mail,/g" $HOME/generic_etl/wip/lead/tmp_adhoc_mail.txt
   cat $HOME/generic_etl/wip/lead/tmp_adhoc_mail.txt | grep '@' > $HOME/generic_etl/wip/lead/tmp_adhoc_mail1.txt
   mv $HOME/generic_etl/wip/lead/tmp_adhoc_mail1.txt $HOME/generic_etl/wip/lead/tmp_adhoc_mail.txt
#EXECUTE CTL FILE
################
   echo "truncate table crm_lead_de_dupe_data_load;"  > $HOME/generic_etl/ctl/crm_lead_capture_email_dedupe.sql
   echo "load data local infile '$HOME/generic_etl/wip/lead/tmp_adhoc_mail.txt' into table crm_lead_de_dupe_data_load fields terminated by ',' enclosed by '\"' lines terminated by '\n';" >> $HOME/generic_etl/ctl/crm_lead_capture_email_dedupe.sql
   echo "insert into crm_lead_de_dupe_data_fact (select replace(convert(email_id using utf8) ,'\r',''),source_desc,date(now()),'A','A' from crm_lead_de_dupe_data_load);"  >> $HOME/generic_etl/ctl/crm_lead_capture_email_dedupe.sql

cd $LOAD_DIR
${CONFIG_DIR}/_run_sqlldr.ksh ${MYSQL_USER} ${MYSQL_DB} ${CTL_FILE} ${LOG_DIR}/${LOG_FILE} MYSQL

cp $HOME/generic_etl/wip/lead/tmp_adhoc_mail.txt $HOME/generic_etl/data_archive/tmp_adhoc_mail_${today}.txt
else
   echo "Data is not available for new Leads"
   rm $HOME/generic_etl/wip/lead/tmp_adhoc_mail.txt
fi

