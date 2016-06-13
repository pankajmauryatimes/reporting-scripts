#!/usr/bin/ksh

set +x

cd $HOME/generic_etl/wip/
rm -f $HOME/generic_etl/wip/scp_file.ftp
ftp_file=$HOME/generic_etl/wip/scp_file.ftp
export file_type=RPC
export filename=Effort_${file_type}_${last_day}.csv

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
echo "get $filename" >> $ftp_file
echo "quit" >> $ftp_file
echo "EOF" >> $ftp_file
#execute FTP script
chmod 755 ${ftp_file}
${ftp_file}
sleep 5
if [ -r $filename ]
then
    echo "File :$filename is available"
    mv $filename Effort_${file_type}.csv
    sed -i '1d' Effort_${file_type}.csv
    perl -pi -e 's/<feff>//g' Effort_${file_type}.csv
    perl -pi -e 's/﻿//g' Effort_${file_type}.csv
    dos2unix Effort_${file_type}.csv
    sort Effort_${file_type}.csv | uniq > Effort_${file_type}_U.csv    
    mv Effort_${file_type}_U.csv Effort_${file_type}.csv
else
    echo "File :$filename is missing "
    ${KSH_SCRIPTS_DIR}/mail $email   "$cur_proc_name - File :$filename is missing"  ${LOG_DIR}/${LOG_FILE} 
fi

