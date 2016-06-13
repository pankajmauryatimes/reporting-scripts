#!/bin/bash

set +x

mv $HOME/generic_etl/wip/apps_status_till_date_daily_load.csv $HOME/generic_etl/data_archive/apps_status_till_date_daily_load_${now}.csv

cd ${LOAD_DIR}
touch apps_status_till_date_daily_${pth}.done
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
echo "del apps_status_till_date_daily1.csv" >> $ftp_file
echo "del apps_status_till_date_daily.csv" >> $ftp_file
echo "put apps_status_till_date_daily1.csv" >> $ftp_file
echo "put apps_status_till_date_daily.csv" >> $ftp_file
echo "put apps_status_till_date_daily_${pth}.done" >> $ftp_file
echo "quit" >> $ftp_file
echo "EOF" >> $ftp_file
ftp_file=${LOAD_DIR}/${cur_proc}.ftp
#execute FTP script
chmod 755 ${ftp_file}
${ftp_file}

rm -f apps_status_till_date_daily_${pth}.done

mv $HOME/generic_etl/wip/apps_status_till_date_daily1.csv $HOME/generic_etl/data_archive/apps_status_till_date_daily1_${now}.csv

