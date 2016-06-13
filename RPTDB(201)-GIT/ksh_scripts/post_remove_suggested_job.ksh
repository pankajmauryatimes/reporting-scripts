#!/usr/bin/ksh

set +x

cd $HOME/generic_etl/wip/
rm -f $HOME/generic_etl/wip/scp_file.ftp

echo "\"ID\",\"LOGIN_ID\",\"RESUME_ID\",\"JOB_ID\",\"UNDO\",\"TIME\",\"REASON\",\"FEATURE\"" > remove_suggested_job_H.txt
cat remove_suggested_job_H.txt remove_suggested_job.csv > remove_suggested_job_A.csv
mv remove_suggested_job_A.csv remove_suggested_job.csv

zip remove_suggested_job.zip remove_suggested_job.csv

#mv monthly_report_tj_mobile.zip $HOME/generic_etl/wip/

txt_body="Hi ,

Please find attached ZIP file for REMOVE SUGGESTED JOBS Report


Thanks,
dbteam
"

$mutt remove_suggested_job "$tmail" "$cmail" "$cur_proc_name" "$txt_body"

mv remove_suggested_job.zip ../data_archive/remove_suggested_job_${today}.zip




