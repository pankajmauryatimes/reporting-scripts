#!/bin/bash

set +x

cd $HOME/generic_etl/wip
rm -f $HOME/generic_etl/wip/promotional_data_F5.txt
cp /tmp/promotional_data_F5_${ddate}.txt $HOME/generic_etl/wip/promotional_data_F5.txt


ftp_dir=/home/datareq/generic_etl/wip

ftp_file=$HOME/generic_etl/wip/promotional_data_F5.ftp
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
echo "put promotional_data_F5.txt" >> $ftp_file
echo "quit" >> $ftp_file
echo "EOF" >> $ftp_file
#execute FTP script
chmod 755 ${ftp_file}
${ftp_file}

printf "StepAhead mailer data requirement has been refreshed" > $HOME/generic_etl/logs/dummy.txt
printf "for F5 " >> $HOME/generic_etl/logs/dummy.txt
${KSH_SCRIPTS_DIR}/mail $demail   "$cur_proc - Data has been Refreshed " $HOME/generic_etl/logs/dummy.txt

rm -f $ftp_file
rm -f $FILE_READY
