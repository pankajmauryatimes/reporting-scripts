#!/bin/bash

set +x
export today=`date +%Y-%m-%d`

echo "Date: $today"

echo "Start Data Extraction"
db2 "connect to tjcandb user tcuser using jobusr"
db2 "set current schema tcuser"

db2 -svf /home/datareq/generic_etl/sql_scripts/login_usage_history.sql > /home/datareq/generic_etl/logs/login_usage_history_${today}.log
#db2 -svf /home/datareq/JOBBUZZ_ETL/export_incremental.sql > /home/datareq/JOBBUZZ_ETL/log/export_incremental_${today}.log
db2 "commit"
db2 "terminate"

echo "Data Extraction Completed"
touch /home/datareq/generic_etl/data_files/login_usage_history_${pth}.done
