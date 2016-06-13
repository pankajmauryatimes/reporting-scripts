#!/bin/bash

set +x

#today=`date +%d%b%y`
cd $HOME/generic_etl/wip/
echo "truncate table daily_login_fact;
load data local infile 'unique_applicants_${last_day}.csv' into table daily_login_fact fields terminated by ',' enclosed by '\"' lines terminated by '\n';" > $HOME/generic_etl/ctl/freshness_wise_daily_application.sql

cp /opt/dw_data/mongo_db/daily_logins/unique_applicants_${last_day}.csv $HOME/generic_etl/wip/unique_applicants_${last_day}.csv

sed -i '1d' unique_applicants_${last_day}.csv

