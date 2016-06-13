#!/usr/bin/ksh

set +x
export today=`date +%Y-%m-%d`
export pth=`date +%d%b%y`

echo "Date: $today"
cd ${LOAD_DIR}
currfile=LOGIN_USAGE_HISTORY.txt
echo "Search for File LOGIN_USAGE_HISTORY.txt"
echo "File Found"
echo "FTP file processing....."
time=$(date +"%T")
i=0
if [ -r /home/datareq/generic_etl/data_files/$currfile ]
   then
       echo " $currfile has been found" >> ${LOG_DIR}/${LOG_FILE}
   else
       printf "$currfile not found.\n"  >> ${LOG_DIR}/${cur_proc}.cron
       echo " $currfile not found."  >> ${LOG_DIR}/${LOG_FILE}
       printf "Process timed out before completion!\n" >> ${LOG_DIR}/${cur_proc}.cron
       echo " Process timed out before completion!" >> ${LOG_DIR}/${LOG_FILE}
       printf "Data file has not been transfered!\n" >> ${LOG_DIR}/${cur_proc}.cron
       echo "Data file has not been transfered!" >>  ${LOG_DIR}/${LOG_FILE}
       ${KSH_SCRIPTS_DIR}/mail $email "CAUTION: $cur_proc_name not created: $currfile"  ${LOG_DIR}/${LOG_FILE} 
       exit 1
fi
touch ${LOAD_DIR}/login_usage_history_${pth}.done
ftp_file=${LOAD_DIR}/${cur_proc}.ftp
echo "#!/bin/ksh" > $ftp_file
echo "HOST=$ip" >> $ftp_file
echo "USER=$user" >> $ftp_file
echo "PASSWD=$pswd" >> $ftp_file
echo "ftp -in \$HOST <<EOF" >> $ftp_file
echo "quote USER \$USER" >> $ftp_file
echo "quote PASS \$PASSWD" >> $ftp_file
echo "binary" >> $ftp_file
echo "cd /home/dwhuser/generic_etl/wip" >> $ftp_file
echo "pwd" >> $ftp_file
echo "del LOGIN_USAGE_HISTORY.txt" >> $ftp_file
echo "put LOGIN_USAGE_HISTORY.txt" >> $ftp_file
echo "put login_usage_history_\${pth}.done" >> $ftp_file
echo "quit" >> $ftp_file
echo "EOF" >> $ftp_file
ftp_file=${LOAD_DIR}/${cur_proc}.ftp
#execute FTP script
chmod 755 ${ftp_file}
${ftp_file}

perl -pi -e 's/172.16.84.220/115.112.206.220/g' ${ftp_file}
${ftp_file}

perl -pi -e 's/172.16.84.220/115.112.206.220/g' /home/datareq/generic_etl/data_files/ftp_login_usage_history.ftp
/home/datareq/generic_etl/data_files/ftp_login_usage_history.ftp > /home/datareq/generic_etl/logs/ftp_login_usage_history.ftp
rm -f ${LOAD_DIR}/LOGIN_USAGE_HISTORY.txt

echo "FTP completed"
exit

