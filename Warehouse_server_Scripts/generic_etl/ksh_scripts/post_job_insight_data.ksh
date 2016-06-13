#!/bin/bash

set +x
rm -f /home/dwhuser/generic_etl/wip/job_insight_data.csv

mysql -udwhuser -pdwhuser tjdwh_db < /home/dwhuser/generic_etl/sql_scripts/post_job_insight_data.sql > /home/dwhuser/generic_etl/logs/post_job_insight_data.sql_${pth}.log

echo "\"DESPRIPTION\",\"ACTIVITY_DATE\",\"APPLY BUTTON FOR ALL JOBS\",\"USERS WITH 2+ YEAR EXPERIENCE\",\"APPLY VIA REFERRAL\",\"APPLY WHEN AVF WAS SERVED\"" >  /home/dwhuser/generic_etl/logs/header_jobinsight.txt

perl -pi -e "s/\\\N//g" /tmp/Job_Insight_Data_Report_${file_date}.txt
cat /home/dwhuser/generic_etl/logs/header_jobinsight.txt /tmp/Job_Insight_Data_Report_${file_date}.txt > /tmp/Job_Insight_Data_Report_${file_date}.csv

txt_body="Hi Nikhil,


Please find attached file

Job_Insight_Data_Report_${file_date}.zip

Thanks & Regards
Warehouse Team


This E-Notification was automatically generated. Please do not reply to this mail.
"

cd /tmp

zip Job_Insight_Data_Report_${file_date}.zip Job_Insight_Data_Report_${file_date}.csv

$mutt Job_Insight_Data_Report_${file_date} "$tmail" "$cmail" "$cur_proc_name " "$txt_body"
mv Job_Insight_Data_Report_${file_date}.zip ${HOME}/generic_etl/data_archive/
mv ${LOAD_DIR}/job_referral_data.csv ${HOME}/generic_etl/data_archive/
mv ${LOAD_DIR}/job_referral_data_2.csv ${HOME}/generic_etl/data_archive/

rm -f Job_Insight_Data_Report_${file_date}.csv

cd -

