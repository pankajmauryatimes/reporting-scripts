#!/usr/bin/ksh

set +x

cd $HOME/generic_etl/wip/
rm -f $HOME/generic_etl/wip/scp_file.ftp
mv Effort_dnc_daily_timestamp.csv $HOME/generic_etl/data_archive/Effort_dnc_daily_timestamp_${today}.csv

mv Effort_RPC_timestamp.csv $HOME/generic_etl/data_archive/Effort_RPC_timestamp_${today}.csv

