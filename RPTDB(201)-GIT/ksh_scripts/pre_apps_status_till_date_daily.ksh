#!/bin/bash

set +x

/usr/bin/ksh /home/datareq/generic_etl/config/_run_sqlldr.ksh tcuser tjcandb /home/datareq/generic_etl/ctl/apps_status_till_date_daily_LIVE.sql /home/datareq/generic_etl/logs/apps_status_till_date_daily__ctl_${now}.log DB2

