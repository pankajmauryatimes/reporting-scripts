#!/bin/ksh

set +x

echo "load data local infile '${cur_proc}_${today}.csv' into table apps_status_till_date fields terminated by ',' enclosed by '\"' lines terminated by '\n';" > $HOME/generic_etl/ctl/Application_Status_Daily_v2.sql
