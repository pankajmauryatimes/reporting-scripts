#!/bin/bash

set +x
export today=`date +%Y-%m-%d`
cd $HOME/generic_etl/wip
mv apps_status_till_date_daily.csv  $HOME/generic_etl/data_archive/apps_status_till_date_daily-${today}.csv
rm apps_status_till_date_daily_${pth}.done
exit
