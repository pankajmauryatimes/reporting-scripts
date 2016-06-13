#!/bin/bash

export pth=`date +%d%b%y`

cd /home/dwhuser/generic_etl/wip

cp /tmp/Amitabh_Duplicate_jobs-${pth}.csv /home/dwhuser/generic_etl/wip
chmod 755 /home/dwhuser/generic_etl/wip/.job_duplicate.ftp 
#./home/dwhuser/generic_etl/wip/.job_duplicate.ftp > /home/dwhuser/generic_etl/logs/.job_duplicate.log
/home/dwhuser/generic_etl/wip/.job_duplicate.ftp > /home/dwhuser/generic_etl/logs/.job_duplicate.log
echo "FTP Completed"

rm -f $HOME/generic_etl/wip/Amitabh_Duplicate_jobs-${pth}.csv
exit
