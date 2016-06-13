#!/bin/ksh

set +x

ftp_file=$HOME/generic_etl/wip/${cur_proc}.ftp
cd $HOME/generic_etl/wip
export FILE_READY=$HOME/generic_etl/wip/${cur_proc}.txt

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
echo "get ${cur_proc}.txt" >> $ftp_file
echo "quit" >> $ftp_file
echo "EOF" >> $ftp_file
#execute FTP script
chmod 755 ${ftp_file}

while [[ $time < $cutoff ]]; do
   ${ftp_file}
   if [ -a ${FILE_READY} ] 
   then
       printf "File found."
       printf "\nFILE_READY found.\n"  >> ${LOG_DIR}/${LOG_FILE}
       break
   else
       	if [ $time > $remind ]
	then
	     if [ $remindsent -eq 0 ]
	     then
                 printf "\nReminder Time is: $time \n"
                 printf "$cur_proc_name - CAUTION: process is still waiting for the file: ${FILE_READY}\n" >> ${LOG_DIR}/${LOG_FILE}
                 printf "\nTAKE CORRECTIVE ACTION IMMEDIATELY!!!\n" >> ${LOG_DIR}/${LOG_FILE}
                 ${KSH_SCRIPTS_DIR}/mail $email   "$cur_proc_name - WARNING"  ${LOG_DIR}/${LOG_FILE}
		 remindsent=1
	     fi
	fi
        sleep 300   #wait 5 min before checking again
        time=$(date +"%T")
        printf "time is "$time
   fi
done

# Exit out from the script whenever time > cutoff
if [[ $time > $cutoff ]]; then
   printf "FILE_READY :${FILE_READY} not found.\n"  > ${LOG_DIR}/${LOG_FILE}
   printf "Process timed out before completion!\n" >> ${LOG_DIR}/${LOG_FILE}
   printf "Data file has not been transfered!\n" >> ${LOG_DIR}/${LOG_FILE}
   ${KSH_SCRIPTS_DIR}/mail $email   "${cur_proc_name} - WARNING "  ${LOG_DIR}/${LOG_FILE}
   exit 1
fi

rm $ftp_file
exit
