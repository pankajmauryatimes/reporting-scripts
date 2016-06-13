#!/usr/bin/ksh

set +x

#mv $LOAD_DIR/lead_capture_detail.txt $LOAD_DIR/lead_capture_detail_${todate}.txt

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
echo "cd \"$ftp_dir\"" >> $ftp_file
echo "pwd" >> $ftp_file
echo "get ${cur_proc}_${today}.csv" >> $ftp_file
#echo "get "HOTSPOT DATA_RPC_Jan & Feb\'14.csv"" >> $ftp_file
echo "quit" >> $ftp_file
echo "EOF" >> $ftp_file

touch $LOAD_DIR/${cur_proc}_${todate}.done
#ftp_file=${LOAD_DIR}/${cur_proc}.ftp
#execute FTP script
chmod 755 ${ftp_file}
${ftp_file}

echo "All Files are created successfully"

