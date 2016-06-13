#!/usr/bin/ksh

set +x

cd $HOME/generic_etl/wip/
rm -f $HOME/generic_etl/wip/scp_file.ftp

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
echo "get chennai_native_jobs_211014.csv" >> $ftp_file
echo "get coimbatore_native_jobs_211014.csv" >> $ftp_file
echo "quit" >> $ftp_file
echo "EOF" >> $ftp_file
#execute FTP script
chmod 755 ${ftp_file}
${ftp_file}

time=$(date +"%T")
while [[ $time < $cutoff ]]; do
    if [ -a ${filename} ]
    then
      printf "Data Files Found "
      echo "Data Files Found "
      printf "\n"
      break
    else
        printf "File Not Found"
        sleep 300   #wait 5 min before checking again
        echo "File Not Found"
        time=$(date +"%T")
        printf "time is "$time
        ${ftp_file}
    fi
done

if [[ $time > $cutoff ]]; then
   printf "FILE_READY not found.\n"  >> ${LOG_DIR}/${LOG_FILE}
   printf "Process timed out before completion!\n" >> ${LOG_DIR}/${LOG_FILE}
   printf "Data file has not been transfered!\n" >> ${LOG_DIR}/${LOG_FILE}
   mail -s "$cur_proc - WARNING " $email < ${LOG_DIR}/${LOG_FILE}
   exit 1
fi

echo "Title,Experience,CTC,Email,FA" > native_jobs_H.txt
cat native_jobs_H.txt chennai_native_jobs_211014.csv > chennai_native_jobs_${f_date}.csv
cat native_jobs_H.txt coimbatore_native_jobs_211014.csv > coimbatore_native_jobs_${f_date}.csv

zip native_jobs_${f_date}.zip chennai_native_jobs_${f_date}.csv coimbatore_native_jobs_${f_date}.csv

txt_body="Hi ,

Please find attached ZIP file for Chennai Job Listings Report


Thanks,
dbteam
"

$mutt native_jobs_${f_date} "$tmail" "$cmail" "$cur_proc_name" "$txt_body"

mv native_jobs_${f_date}.zip ../data_archive/chennai_jobs_${today}.zip
rm -f native_jobs_H.txt


