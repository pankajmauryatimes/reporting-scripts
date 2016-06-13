#!/bin/bash

set +x

/usr/bin/ksh /home/datareq/generic_etl/config/_run_sqlldr.ksh tcuser tjcandb /home/datareq/generic_etl/ctl/Application_Status_today_LIVE.sql /home/datareq/generic_etl/logs/Application_Status_today_ctl_${now}.log DB2

#cp /home/datareq/generic_etl/logs/other_application_flat.txt-bak /home/datareq/generic_etl/logs/other_application_flat.txt
#cp /home/datareq/generic_etl/logs/web_application_flat.txt-bak  /home/datareq/generic_etl/logs/web_application_flat.txt
#cp /home/datareq/generic_etl/logs/mob_application_flat.txt-bak  /home/datareq/generic_etl/logs/mob_application_flat.txt


