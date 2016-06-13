#!/bin/ksh

set +x

#export today=`date +%Y-%m-%d`
export today=`date +%d-%m-%Y`
export KSH_SCRIPTS_DIR=$HOME/generic_etl/ksh_scripts
export pth=`date +%d%b%y`
#export ftp_dir=/databackup/DAILY-REPORT/${pth}/corp
export email=sanjay.biswas@timesgroup.com,nitin.chadha@timesgroup.com,amit.singhal@timesgroup.com

export ip=115.112.206.142
export user=dwhuser
export pswd=dwhpass
export ftp_dir=/opt/dwhdata/

. /candreports/db2inst2/sqllib/db2profile
db2 "connect to tjrptdb user tcuser using jobusr"
db2 "set current schema tcuser"
echo "DB Connected"

    curr_proc=F5
    echo "Running Process "${curr_proc}

    export ftp_file=$HOME/generic_etl/wip/promotional_data_${curr_proc}_file.ftp
    echo "----------- Sub Process Begin ----------"
    export now=`date +%m%d%Y-%H%M%S`
    . $HOME/generic_etl/ksh_scripts/promotional_data_F5.ksh ${curr_proc} > $HOME/generic_etl/logs/promotional_data_${curr_proc}_${now}.log
    cat $HOME/generic_etl/logs/promotional_data_${curr_proc}_${now}.log
    echo "----------- Sub Process End ------------"

db2 "commit"
db2 "terminate"

echo "Main Process Finished"
exit
