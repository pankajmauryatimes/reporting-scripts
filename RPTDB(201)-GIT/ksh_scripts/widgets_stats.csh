#!/bin/bash

set +x
export today=`date +%Y-%m-%d`

echo "Date: $today"

echo "Start Data Extraction"
db2 "connect to tjcandb user tcuser using jobusr"
db2 "set current schema tcuser"

#db2 -svf /home/datareq/generic_etl/sql_scripts/widgets_stats_staging_full.sql > /home/datareq/generic_etl/logs/widgets_stats_staging_sql_${today}.log
db2 -svf /home/datareq/generic_etl/sql_scripts/widgets_stats_staging_incremental.sql > /home/datareq/generic_etl/logs/widgets_stats_staging_sql_${today}.log
db2 "commit"
db2 "terminate"

exit

