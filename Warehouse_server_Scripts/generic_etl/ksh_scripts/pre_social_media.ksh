#!/bin/bash

set +x
export Stat_date=`date +%Y%m%d`
cp /opt/dw_data/mongo_db/social_data/social_report_${today}.csv /home/dwhuser/generic_etl/data_archive/social_report/
export WIP_FILE=`tail -n +2 /opt/dw_data/mongo_db/social_data/social_report_${today}.csv|sed -e s/YYYYMMDD/\`date +%Y%m%d\`/ -e s/MMDDYYYY/\`date +%m%d%Y\`/ -e s/YYMMDD/\`date +%y%m%d\`/ -e s/MMDDYY/\`date +%m%d%y\`/`
echo $WIP_FILE > /home/dwhuser/generic_etl/wip/social_report.csv

