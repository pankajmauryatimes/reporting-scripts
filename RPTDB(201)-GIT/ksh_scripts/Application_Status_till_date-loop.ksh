#!/bin/ksh

set +x

c=1
while [[ $c -le 5 ]]; do
   (( c-- ))
/home/datareq/generic_etl/ksh_scripts/generic_load_new.ksh /home/datareq/generic_etl/config/Application_Status_till_date.env > /home/datareq/generic_etl/logs/Application_Status_till_date.cron 2>&1  
   sleep 7200 
  (( c++ ))

done
