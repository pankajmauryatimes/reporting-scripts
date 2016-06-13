#!/usr/bin/ksh
set -x

#HOST='115.112.206.221'
#USER='datareq'
#PASSWD='datareq'
#ftp -in $HOST <<EOF
#quote USER $USER
#quote PASS $PASSWD
#mkdir $pth
#cd /candbackup/DAILY-REPORT/${pth}
#mkdir DWH
#cd /candbackup/DAILY-REPORT/${pth}/DWH
#pwd
#put quality_cv_report_$pth.csv
#quit
#EOF

export ftp_dir=/candbackup/DAILY-REPORT
export pth=`date +%d%b%y`
export LOAD_DIR=/home/datareq/generic_etl/wip
export ip='115.112.206.221'
export user=datareq
export pswd=datareq
export pth=`date +%d%b%y`


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
echo "mkdir $pth" >> $ftp_file
echo "cd /candbackup/DAILY-REPORT/${pth}" >> $ftp_file
echo "pwd" >> $ftp_file
echo "put Chandan_data_with_resume_ab_test.csv" >> $ftp_file
echo "put Chandan_data_Total_ab_test.csv" >> $ftp_file
echo "quit" >> $ftp_file
echo "EOF" >> $ftp_file
 #execute FTP script
chmod 755 ${ftp_file}
${ftp_file}
exit 0

