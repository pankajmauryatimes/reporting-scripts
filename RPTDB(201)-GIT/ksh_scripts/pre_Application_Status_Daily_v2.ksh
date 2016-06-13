#!/bin/bash

set +x

/usr/bin/ksh /home/datareq/generic_etl/config/_run_sqlldr.ksh tcuser tjcandb /home/datareq/generic_etl/ctl/Application_Status_Daily_Live_v2.sql /home/datareq/generic_etl/logs/Application_Status_Daily_v2_ctl_${now}.log DB2

