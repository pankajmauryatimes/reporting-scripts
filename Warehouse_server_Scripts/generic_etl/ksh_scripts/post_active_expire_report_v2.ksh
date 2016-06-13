#!/bin/bash

set +x
export pth=`date +%d%b%y`

printf "\n Chang directory to WIP\n"
cd /home/dwhuser/generic_etl/wip
printf "\n Create Directory for current date \n"
mkdir /home/dwhuser/generic_etl/data_archive/active_expire/$pth
printf "\n Ziping Flat files"
#gzip /home/dwhuser/generic_etl/wip/REP*.*
zip /home/dwhuser/generic_etl/data_archive/${cur_proc}_${pth}.zip /home/dwhuser/generic_etl/wip/REP*.*
printf "\n Move Flat file from WIP directory to /home/dwhuser/generic_etl/data_archive/weekly_report/$pth/"
mv /home/dwhuser/generic_etl/wip/REP*.gz /home/dwhuser/generic_etl/data_archive/active_expire/$pth/
rm -f /home/dwhuser/generic_etl/wip/${cur_proc}_${pth}.done
rm -f /home/dwhuser/generic_etl/wip/REP*.*

cd /tmp
rm -f scp_file.ftp
ftp_file=/tmp/scp_file.ftp
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
echo "put active_report_${pth}.csv" >> $ftp_file
echo "put expire_report_${pth}.csv" >> $ftp_file
echo "quit" >> $ftp_file
echo "EOF" >> $ftp_file
#execute FTP script
chmod 755 ${ftp_file}
${ftp_file}


exit
