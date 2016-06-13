#!/usr/bin/ksh

set +x
export pth=`date +%d%b%y`
currfile=LOGIN_USAGE_HISTORY.txt
rm /home/datareq/generic_etl/data_files/$currfile ]
rm  /home/datareq/generic_etl/data_files/login_usage_history_${pth}.done
