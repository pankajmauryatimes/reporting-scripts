#!/usr/bin/ksh

set +x

cd $HOME/generic_etl/wip/
rm -f $HOME/generic_etl/wip/scp_file.ftp
ftp_file=$HOME/generic_etl/wip/scp_file.ftp
export file_type=RPC
export filename=Ienergizer_${file_type}_${last_day}.csv

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

perl -pi -e 's/\t/,/g' $filename

if [ -r $filename ]
then
    echo "File :$filename is available"
    mv Ienergizer_${file_type}_${last_day}.csv Ienergizer_${file_type}.csv
    sed -i '1d' Ienergizer_${file_type}.csv
    perl -pi -e 's/<feff>//g' Ienergizer_${file_type}.csv
    perl -pi -e 's/﻿//g' Ienergizer_${file_type}.csv
    dos2unix Ienergizer_${file_type}.csv
    sort Ienergizer_${file_type}.csv | uniq >  Ienergizer_${file_type}_U.csv
    mv  Ienergizer_${file_type}_U.csv  Ienergizer_${file_type}.csv
else
    echo "File :$filename is missing "
    ${KSH_SCRIPTS_DIR}/mail $email   "$cur_proc_name - File :$filename is missing"  ${LOG_DIR}/${LOG_FILE}
    exit
fi


