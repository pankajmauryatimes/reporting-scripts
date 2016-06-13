#!/bin/bash

set +x

mv $HOME/generic_etl/wip/Application_Status_Daily_load.csv $HOME/generic_etl/data_archive/Application_Status_Daily_load_${now}.csv

cd ${LOAD_DIR}

mv $HOME/generic_etl/wip/Application_Status_Daily_v2.csv ${LOAD_DIR}/Application_Status_Daily_v2_${today}.csv
touch Application_Status_Daily_v2_${pth}.done
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
echo "put Application_Status_Daily_v2_${today}.csv" >> $ftp_file
echo "put Application_Status_Daily_v2_${pth}.done" >> $ftp_file
echo "quit" >> $ftp_file
echo "EOF" >> $ftp_file
ftp_file=${LOAD_DIR}/${cur_proc}.ftp
#execute FTP script
chmod 755 ${ftp_file}
${ftp_file}

perl -pi -e 's/172.16.84.220/115.112.206.220/g' ${ftp_file}
${ftp_file}

rm -f Application_Status_Daily_v2_${pth}.done
mv Application_Status_Daily_v2_${today}.csv $HOME/generic_etl/data_archive/
