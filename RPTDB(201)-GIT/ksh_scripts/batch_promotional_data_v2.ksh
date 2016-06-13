#!/bin/ksh

set +x

export today=`date +%d-%m-%Y`
export KSH_SCRIPTS_DIR=$HOME/generic_etl/ksh_scripts
export pth=`date +%d%b%y`
export last_day=$(date --date="1 day ago" +%d-%m-%Y)
export email=sanjay.biswas@timesgroup.com,shashank.pandey@timesgroup.com,amit.singhal@timesgroup.com,gaurav.kumar2@timesgroup.com
export ip=115.112.206.142
export user=dwhuser
export pswd=dwh@123
export ftp_dir=/opt/dwhdata/

set -A procarr  F1 F2 F21 F4 F8 F8S F9
export procarr
export totalproc=7

. /candreports/db2inst2/sqllib/db2profile
db2 "connect to tjrptdb user tcuser using jobusr"
db2 "set current schema tcuser"
echo "DB Connected"

i=0
while [[ ${i} -lt $totalproc ]]; do
    curr_proc=${procarr[$i]}
    export ftp_file=$HOME/generic_etl/wip/promotional_data_${curr_proc}_file.ftp
    echo "----------- ${curr_proc} Process Begin ----------"
    export now=`date +%m%d%Y-%H%M%S`
    echo "LOG FILE:$HOME/generic_etl/logs/promotional_data_v2_${curr_proc}_${now}.log"
    . $HOME/generic_etl/ksh_scripts/promotional_data_v2.ksh ${curr_proc} > $HOME/generic_etl/logs/promotional_data_v2_${curr_proc}_${now}.log
    echo "----------- ${curr_proc} Process End ------------"
    echo ""
    i=`expr $i + 1`
done

db2 "commit"
db2 "terminate"

echo "Batch Process Finished"
exit
