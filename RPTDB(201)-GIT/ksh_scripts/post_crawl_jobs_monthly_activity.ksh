#!/usr/bin/ksh

set +x

cd ${HOME}/generic_etl/wip

if [ -r ${HOME}/generic_etl/wip/crawl_jobs_monthly_activity.csv ]
    then
    printf "\nFile Found ${HOME}/generic_etl/wip/crawl_jobs_monthly_activity.csv ...\n"
    printf "\nFile Found ${HOME}/generic_etl/wip/crawl_jobs_monthly_activity.csv ...\n" >> ${LOG_DIR}/${LOG_FILE}
else
       printf "File ${HOME}/generic_etl/wip/crawl_jobs_monthly_activity.csv do not found.\n" >> ${LOG_DIR}/${LOG_FILE}
       printf "Error: Error in POST KSH Script Execution. EXIT Code = $exit_code \n" >> ${LOG_DIR}/${LOG_FILE}
       ${KSH_SCRIPTS_DIR}/mail $email   "$cur_proc_name - FAILED with POST KSH Script"  ${LOG_DIR}/${LOG_FILE}
       exit 1
fi

echo "\"ADMIN_LOGIN_ID\",\"LOGIN_ID\",\"AD_ID\",\"APPLICATION COUNT\"" > header.hed
cat header.hed crawl_jobs_monthly_activity.csv > crawl_jobs_monthly_activity.txt
mv crawl_jobs_monthly_activity.txt crawl_jobs_monthly_activity_${today}.csv
zip crawl_jobs_monthly_activity_${today}.zip crawl_jobs_monthly_activity_${today}.csv

#mv monthly_report_tj_mobile.zip $HOME/generic_etl/wip/

txt_body="Hi Amitabh,

Please find attached ZIP file.

crawl_jobs_monthly_activity.zip

Thanks,
dbteam
"

$mutt ${cur_proc}_${today} "$tmail" "$cmail" "$cur_proc_name" "$txt_body"

rm crawl_jobs_monthly_activity_${today}.csv header.hed
mv crawl_jobs_monthly_activity_${today}.zip ../data_archive/

echo "All Files are created successfully"
