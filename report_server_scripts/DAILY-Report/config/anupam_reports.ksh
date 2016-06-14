#!/bin/bash

HOME=/ndata-archive/DAILY-REPORT
export email=$HOME/generic_etl/ksh_scripts/email.pl
export cur_proc_name="Active Jobs and Daily Sales Lead Report"
export curr_dir=`date +%d%b%y`

cd $HOME/generic_etl/wip

rm -f Anupam_Report_ACtive_job_counts* ActiveJobs_SalesLead_Report*
cp $HOME/$curr_dir/corp/Anupam_Report_ACtive_job_counts.txt $HOME/generic_etl/wip/Anupam_Report_ACtive_job_counts.csv
cp $HOME/$curr_dir/corp/Anupam_daily_sales_leads.txt $HOME/generic_etl/wip/Anupam_daily_sales_leads.csv

echo "\"ADMIN_LOGIN_ID\",\"COMPANY_NAME\",\"COMPANY_CONSULTANT\",\"INDUSTRY\",\"ADDRESS1\",\"EMP_CITY\",\"CONTACT_PERSON\",\"DESIGNATION\",\"TEL_OFF\",\"TEL_OTHER\",\"EMAIL2\",\"OCCUPATION_OTH\",\"SALES_EMAIL\",\"SALES_VERTICAL_ID\",\"ACCOUNT_GROUP_ID\",\"ZONAL_MGR_EMAIL\",\"JOB_COUNT\"" > header.txt

cat header.txt Anupam_Report_ACtive_job_counts.csv > Anupam_Report_ACtive_job_counts_H.csv
mv Anupam_Report_ACtive_job_counts_H.csv Anupam_Report_ACtive_job_counts.csv

echo "\"LOGIN_ID\",\"COMPANY_NAME\",\"INDUSTRY\",\"STATE_CITY_NAME\",\"EMP_CITY_OTHER\",\"COMPANY_CONSULTANT\",\"COMPANY_DESCRIPTION\",\"LOGIN_CREATE_DATE\",\"CONTACT_PERSON\",\"DESIGNATION\",\"TEL_OTHER\",\"TEL_OFFICE\",\"EMAIL\",\"ADDRESS1\",\"IS_IN_TOUCH_WITH_SALES\",\"SALES_PERSON_NAME\"" > header.txt

cat header.txt Anupam_daily_sales_leads.csv > Anupam_daily_sales_leads_H.csv
mv Anupam_daily_sales_leads_H.csv Anupam_daily_sales_leads.csv

zip ActiveJobs_SalesLead_Report.zip Anupam_Report_ACtive_job_counts.csv Anupam_daily_sales_leads.csv

txt_body="Hi Anupam,

Please find attached file ActiveJobs_SalesLead_Report.zip for CSV files below:
ActiveJobs_SalesLead_Report.zip

Thanks,
dbteam
"

$email ActiveJobs_SalesLead_Report "anupam.gupta2@timesgroup.com" "sanjay.biswas@timesgroup.com" "$cur_proc_name" "$txt_body"

rm -f Anupam_Report_ACtive_job_counts* ActiveJobs_SalesLead_Report* ActiveJobs_SalesLead_Report*  header.txt Anupam_daily_sales_leads*

exit


