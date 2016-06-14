#!/bin/bash

HOME=/ndata-archive/DAILY-REPORT
export email=$HOME/generic_etl/ksh_scripts/email.pl
export cur_proc_name="Ascent Job Report"

cd $HOME/generic_etl/wip

echo "\"LOGIN_ID\",\"COMPANY_NAME\",\"AD_ID\",\"JOB_TITLE\",\"JOB_VIEWS\",\"APPLICATION_COUNT\",\"MONTHS\",\"POSTING_DATE\"" > header.txt

cat header.txt active_job_detail_shiredel8.csv > Ascent_Report_shiredel8_H.csv
mv Ascent_Report_shiredel8_H.csv Ascent_Report_shiredel8.csv
zip Ascent_Report_shiredel8.zip Ascent_Report_shiredel8.csv

txt_body="Hi Kamana

Please find attached file for BCCL active job details.


Thanks,
dbteam
"

$email Ascent_Report_shiredel8 "kamana.misra@timesgroup.com" "tjbi@timesgroup.com" "$cur_proc_name" "$txt_body"

rm -f Ascent_Report_shiredel8* 
rm -f header.txt
rm -f active_job_detail_shiredel8.csv
exit


