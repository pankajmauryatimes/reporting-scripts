#!/bin/bash

set +x

echo "Query Creating ......"
echo "select date_key from date_dimension where full_date=CURRENT_date() - inTERVAL 1 DAY;" > $HOME/generic_etl/wip/kettle_execute_date.txt
echo "Query Creation Completed"
echo "Query Executing for Date key"
#rm -f /tmp/kettle_execute_report1.txt
date_key_tmp=`mysql -udwhuser -pdwhuser tjdwh_db < $HOME/generic_etl/wip/kettle_execute_date.txt`
echo "Date key Executed"
date_key=`$date_key_tmp | tail -2`
#date_key=`cat /tmp/sanjay/kettle_execute_report1.txt`
echo "Date_key : $date_key"
