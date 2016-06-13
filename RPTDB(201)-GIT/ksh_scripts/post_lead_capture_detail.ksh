#!/usr/bin/ksh

set +x

if [ -r $LOAD_DIR lead_capture_detail.txt ]
    then
    printf "\nFile $LOAD_DIR/lead_capture_detail.txt ...\n"
    printf "\nFile $LOAD_DIR/lead_capture_detail.txt ...\n" >> ${LOG_DIR}/${LOG_FILE}
else
       printf "File $LOAD_DIR/lead_capture_detail.txt do not found.\n" >> ${LOG_DIR}/${LOG_FILE}
       printf "Error: Error in POST KSH Script Execution. EXIT Code = $exit_code \n" >> ${LOG_DIR}/${LOG_FILE}
       ${KSH_SCRIPTS_DIR}/mail $email   "$cur_proc_name - FAILED with POST KSH Script"  ${LOG_DIR}/${LOG_FILE}
       exit 1
fi

mv $LOAD_DIR/lead_capture_detail.txt $LOAD_DIR/lead_capture_detail_${todate}.txt

cd ${LOAD_DIR}
ftp_file=${LOAD_DIR}/${cur_proc}.ftp
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
echo "put lead_capture_detail_${todate}.txt" >> $ftp_file
echo "put lead_capture_detail_${todate}.done" >> $ftp_file
echo "quit" >> $ftp_file
echo "EOF" >> $ftp_file

touch $LOAD_DIR/lead_capture_detail_${todate}.done
#ftp_file=${LOAD_DIR}/${cur_proc}.ftp
#execute FTP script
chmod 755 ${ftp_file}
${ftp_file}

perl -pi -e 's/172.16.84.220/115.112.206.220/g' ${ftp_file}
${ftp_file}

echo "All Files are created successfully"

