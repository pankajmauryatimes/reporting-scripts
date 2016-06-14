#!/bin/ksh
set -x

export cur_proc=ftp_ActExp_monthly
export ftp_dir=/home/dwhuser/generic_etl/wip
export pth=`date +%d%b%y`
#export pth='03Sep12'
export LOAD_DIR=/databackup/DAILY-REPORT/${pth}/corp
export ip=115.112.206.220
export user=dwhuser
export pswd=dwhuser
export totalfiles=24
export filearr

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
#i=0
#if [[ ${filearr[$i]} != "" ]]; then
#    while [[ ${i} -lt $totalfiles ]]; do
#            echo "put ${filearr[$i]}" >> $ftp_file
#            i=`expr $i + 1`
#    done
#fi

echo "mput MON_*" >> $ftp_file
echo "mput REP*" >> $ftp_file
echo "put monthly_report_\${pth}.done" >> $ftp_file
echo "quit" >> $ftp_file
echo "EOF" >> $ftp_file
touch put monthly_report_${pth}.done
 #execute FTP script
chmod 755 ${ftp_file}
${ftp_file}
exit 0
