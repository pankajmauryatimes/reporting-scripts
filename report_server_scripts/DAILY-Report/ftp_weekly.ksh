#!/bin/ksh
set -x

export cur_proc=ftp_weekly_report
export ftp_dir=/home/dwhuser/generic_etl/wip
export pth=`date +%d%b%y`
#export pth='03Sep12'
export LOAD_DIR=/ndata-archive/DAILY-REPORT/${pth}/corp
export ip=172.16.84.220
export user=dwhuser
export pswd=dwhuser
export totalfiles=24
export cutoff=23:50:00
export remind=07:00:00
export remindsent=0
#set -A institute2_idReport-2012-09-06.xml institute1_idReport-2012-09-06.xml ExperienceReport-2012-09-06.xml QualificationMasReport-2012-09-06.xml QualificationMas2Report-2012-09-06.xml FUNC_Area_SpecReport-2012-09-06.xml FAReport-2012-09-06.xml IndustryReport-2012-09-06.xml LocationReport-2012-09-06.xml IndustryFAReport-2012-09-06.xml
export filearr
#touch weekly_report_\${pth}.done
FILE_READY=/ndata-archive/DAILY-REPORT/${pth}/corp/ALL_Weekely_REPActiveClient_Details_NEW_changed.txt
FILE_READY2=/ndata-archive/DAILY-REPORT/${pth}/ALL_Weekely_REPActiveClient_Details_NEW_changed.txt
time=$(date +"%T")
while [[ $time < $cutoff ]]; do
   if [ -a ${FILE_READY} ] 
   then
       printf "File found."
       printf "\nFILE_READY found.\n"  >> ${LOG_DIR}/${LOG_FILE}
       LOAD_DIR= /ndata-archive/DAILY-REPORT/${pth}/corp
       break
   elif [ -a ${FILE_READY2} ]
    then
       printf "File found."
       printf "\nFILE_READY found.\n"  >> ${LOG_DIR}/${LOG_FILE}
       LOAD_DIR= /ndata-archive/DAILY-REPORT/${pth}
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
#i=0
#if [[ ${filearr[$i]} != "" ]]; then
#    while [[ ${i} -lt $totalfiles ]]; do
#            echo "put ${filearr[$i]}" >> $ftp_file
#            i=`expr $i + 1`
#    done
#fi

echo "mput ALL_*" >> $ftp_file
echo "mput WEEKLY_Active*" >> $ftp_file
echo "put weekly_report_\${pth}.done" >> $ftp_file
echo "put weekly_report_demo_till_date_\${pth}.done" >> $ftp_file
echo "quit" >> $ftp_file
echo "EOF" >> $ftp_file
touch weekly_report_${pth}.done
touch weekly_report_demo_till_date_${pth}.done
 #execute FTP script
chmod 755 ${ftp_file}
${ftp_file}
exit 0

