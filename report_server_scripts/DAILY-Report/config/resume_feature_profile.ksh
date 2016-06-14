#!/bin/bash


HOME=/ndata-archive/DAILY-REPORT
export email=$HOME/generic_etl/ksh_scripts/email.pl
export cur_proc_name="Resume Feature Profile"
export cur_proc=RESUME_ZAPPER_FEATURE_PROFILE
export curr_dir=`date +%d%b%y`

cd $HOME/generic_etl/wip

if [ -r ${cur_proc}_${curr_dir}.csv ]
then
     echo "File -Found :${cur_proc}_${curr_dir}.csv"
else
     export ip=192.168.206.201
     export user=datareq
     export pswd=tjdatareq
     export ftp_dir=/home/datareq/generic_etl/data_archive

     ftp_file=$HOME/generic_etl/wip/scp_file.ftp
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
     echo "get ${cur_proc}_${curr_dir}.csv" >> $ftp_file
     echo "quit" >> $ftp_file
     echo "EOF" >> $ftp_file
#execute FTP script
chmod 755 ${ftp_file}
${ftp_file}
fi

if [ -r ${cur_proc}_${curr_dir}.csv ]
then

echo "FROM_EMAIL,SUBJECT,MSG_CONTENT,SEND_DATE,COUNT" > feature_header.txt

cat feature_header.txt ${cur_proc}_${curr_dir}.csv > ${cur_proc}_${curr_dir}_H.csv
mv ${cur_proc}_${curr_dir}_H.csv ${cur_proc}${curr_dir}.csv

zip ${cur_proc}${curr_dir}.zip ${cur_proc}${curr_dir}.csv

txt_body="Hi All,


Please find attached file

${cur_proc}${curr_dir}.zip


Thanks,
dbteam
"

$email ${cur_proc}${curr_dir} "sweta.mittal@timesgroup.com, ashutosh.kumar2@timesgroup.com, Surabhi.Shrivastava@timesgroup.com" "gaurav.kumar2@timesgroup.com, sanjay.biswas@timesgroup.com" "$cur_proc_name" "$txt_body"
rm -f feature_header.txt ${cur_proc}${curr_dir}.csv
mv ${cur_proc}${curr_dir}.zip $HOME/generic_etl/data_archive

else
	touch ${cur_proc}_${curr_dir}.csv
        zip ${cur_proc}${curr_dir}.zip ${cur_proc}_${curr_dir}.csv
	txt_body="Hi Team,


File is not found 

${cur_proc}_${curr_dir}.zip


Thanks,
dbteam
"

$email ${cur_proc}${curr_dir} "sanjay.biswas@timesgroup.com" "sanjay.biswas@timesgroup.com,gaurav.kumar2@timesgroup.com" "$cur_proc_name" "$txt_body"
fi

exit

