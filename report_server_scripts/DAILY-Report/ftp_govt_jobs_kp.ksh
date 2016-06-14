#!/bin/ksh
set -x

export cur_proc=ftp_govt_jobs_kpi
export ftp_dir=/home/dwhuser/generic_etl/wip
export pth=`date +%d%b%y`
#export pth='03Sep12'
export LOAD_DIR=/ndata-archive/DAILY-REPORT/${pth}/corp
export ip=172.16.84.220
export user=dwhuser
export pswd=dwhuser
export totalfiles=1
export cutoff=23:50:00
export remind=07:00:00
export remindsent=0
export filearr
FILE_READY=/ndata-archive/DAILY-REPORT/${pth}/corp/govt_jobs_kpi.txt
time=$(date +"%T")
while [[ $time < $cutoff ]]; do
   if [ -a ${FILE_READY} ] 
   then
       printf "File found."
       printf "\nFILE_READY found.\n"  >> ${LOG_DIR}/${LOG_FILE}
       break
   else
       sleep 300   #wait 5 min before checking again
       time=$(date +"%T")
       printf "time is "$time
   fi
done

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
echo "del govt_jobs_kpi.txt" >> $ftp_file
echo "put govt_jobs_kpi.txt" >> $ftp_file
echo "quit" >> $ftp_file
echo "EOF" >> $ftp_file
touch govt_jobs_kpi_${pth}.done
 #execute FTP script
chmod 755 ${ftp_file}
${ftp_file}
exit 0



