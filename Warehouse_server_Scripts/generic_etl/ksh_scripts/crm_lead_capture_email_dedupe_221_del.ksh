#!/bin/ksh

set +x


#ADD LEADS

cd $HOME/generic_etl/wip/lead

export ip=172.16.84.221
export user=datareq
export pswd=datareq
#export ftp_dir=/databackup/DAILY-REPORT/lead_files/de_dupe_lead
export ftp_dir=/ndata-archive/DAILY-REPORT/lead_files/de_dupe_lead
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

rm -f $HOME/generic_etl/ctl/crm_lead_capture_email_dedupe.sql
cat $HOME/generic_etl/wip/lead/*.txt > $HOME/generic_etl/wip/lead/tmp_leadcompdata_del.txt
#mv $HOME/generic_etl/wip/lead/tmp_leadcompdata_del.txt $HOME/generic_etl/wip/tmp_leadcompdata_del.txt
dos2unix $HOME/generic_etl/wip/lead/tmp_leadcompdata_del.txt
#mv $HOME/generic_etl/wip/tmp_leadcompdata_del.txt $HOME/generic_etl/wip/lead/tmp_leadcompdata_del.txt

file_exist=`cat $HOME/generic_etl/wip/lead/tmp_leadcompdata_del.txt | wc -w `

if [ ${file_exist} -gt 0 ]
then
   cat $HOME/generic_etl/wip/lead/tmp_leadcompdata_del.txt | grep '@' > $HOME/generic_etl/wip/lead/tmp_leadcompdata1.txt
   mv $HOME/generic_etl/wip/lead/tmp_leadcompdata1.txt $HOME/generic_etl/wip/lead/tmp_leadcompdata_del.txt
   for i in `cat $HOME/generic_etl/wip/lead/tmp_leadcompdata_del.txt`
   do 
       echo "update crm_lead_de_dupe_data_fact set lead_flg = 'D' where trim(email_id) ='${i}';
             update crm_lead_de_dupe_data_fact set lead_flg ='A' , del_flg ='A' ,modified_date = current_date where source_desc='demo_ids' ;" >> $HOME/generic_etl/ctl/crm_lead_capture_email_dedupe.sql
   done

cd $LOAD_DIR
${CONFIG_DIR}/_run_sqlldr.ksh ${MYSQL_USER} ${MYSQL_DB} ${CTL_FILE} ${LOG_DIR}/${LOG_FILE} MYSQL

cp $HOME/generic_etl/wip/lead/tmp_leadcompdata_del.txt $HOME/generic_etl/data_archive/tmp_leadcompdata_del_${today}.txt
else
   echo "Data is not available for De-Dupe Leads"
   rm -f $HOME/generic_etl/wip/lead/tmp_leadcompdata_del.txt
fi
#mv $HOME/generic_etl/wip/lead/tmp_leadcompdata.ctl $HOME/generic_etl/wip/lead/tmp_leadcompdata.txt

