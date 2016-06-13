#!/bin/bash

set +x

rm -f /home/datareq/generic_etl/logs/web_application_flat_v2.txt
rm -f /home/datareq/generic_etl/logs/mob_application_flat_v2.txt
rm -f /home/datareq/generic_etl/logs/other_application_flat_v2.txt

/usr/bin/ksh /home/datareq/generic_etl/config/_run_sqlldr.ksh tcuser tjcandb /home/datareq/generic_etl/ctl/hourly_application_status_live_data.sql /home/datareq/generic_etl/logs/hourly_application_status_live_data_ctl_${now}.log DB2

