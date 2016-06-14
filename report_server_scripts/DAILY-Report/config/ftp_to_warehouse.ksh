#!/bin/ksh

HOME=/ndata-archive/DAILY-REPORT
export ftp_dir=/home/dwhuser/generic_etl/wip
export FILE_READY=/ndata-archive/DAILY-REPORT/`date +%d%b%y`/corp/govt_jobs_kpi.txt
export cutoff=23:50:00
export remind=11:00:00
export remindsent=0
export todate=`date +%m%d%Y`
export now=`date +%m%d%Y-%H%M%S`
export today=`date +%Y-%m-%d`
export pth=`date +%d%b%y`
export LOAD_DIR=/home/datareq/generic_etl/wip/
export cutoff=23:50:00
export remind=11:00:00

# Busy Wait for FILE_READY
printf "Busy Wait for FILE_READY\n"
time=$(date +"%T")

while [[ $time < $cutoff ]]; do
   if [ -a ${FILE_READY} ]
   then
       printf "File found."
       break
   else
        if [ $time > $remind ]
        then
             if [ $remindsent -eq 0 ]
             then
                 printf "\nReminder Time is: $time \n"
                 remindsent=1
             fi
        fi
        sleep 300   #wait 5 min before checking again
        time=$(date +"%T")
        printf "time is "$time
   fi

done;

#!/usr/bin/ksh

LOAD_DIR=/home/datareq/generic_etl/wip/
ip=172.16.84.220
user1=dwhuser
pswd=dwhuser
ftp -ivn $ip << EOF
quote USER $user1
quote PASS $pswd
binary
cd /home/dwhuser/generic_etl/wip/ 
lcd /ndata-archive/DAILY-REPORT/`date +%d%b%y`/corp/
put govt_jobs_kpi.txt
bye
EOF
