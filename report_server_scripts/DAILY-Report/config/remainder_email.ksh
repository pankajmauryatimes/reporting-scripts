#!/usr/bin/ksh
set -x


HOME=/ndata-archive/DAILY-REPORT
export cur_proc=remainder_email
export cur_proc_name="CAUTION: Waiting for \"CORP Folder\" on REPORTING SERVER (221)"
export pth=`date +%d%b%y`
export LOAD_DIR=/ndata-archive/DAILY-REPORT/${pth}/corp
export email=$HOME/generic_etl/ksh_scripts/email.pl
export tmail=saints@timesgroup.com
export cmail=sanjay.biswas@timesgroup.com,patrick.joy@timesgroup.com,
export cutoff=23:50:00
export remind=11:00:00
export remindsent=0

time=$(date +"%T")

while [[ $time < $cutoff ]]; do
   file_count=$(ls /ndata-archive/DAILY-REPORT/${pth}/corp | wc -l) 
   if [[ $file_count == 0 ]] 
   then
       	if [[ $time > $remind ]]
	then
                 echo "zero_search_result.csv
mailer_report_09001930.csv
shiredel8_Active_jobs_update_1.txt
Seema_CDIAL_SMS_DETAILS.txt
sanjay_ravi_last_day_activations_Devine.txt
mailer_report_21300900.csv
mailer_report_19302130.csv
jobs_vadmin_1.csv
JOBS_MODERATED_LAST_7DAYS.txt
JOBS_LANDED_LAST_7DAYS.txt
JOB_MODERATION_REPORT.txt
Amitabh_daily_Corp_Ip_Details.txt
shiredel8_Active_jobs_update_2.txt
search_log_for_ExlDwn_MoreThen_5000.csv
recruiter_endorsement_last_day.txt
mayank_Client_misuse_rules_last_day.csv
JOBS_NOT_MODERATED_LAST_7DAYS.txt
Anupam_Report_ACtive_job_counts.txt
Anupam_daily_sales_leads.txt
Anupam_daily_sales_leads_quick_registration.txt
ALL_Weekely_REPActiveClient_Active_trial_Visibility_service.txt
ALL_Weekely_REPActiveClient_Active_trial_Job_posting_service.txt
ALL_Weekely_REPActiveClient_Active_trial_Database_service.txt
ALL_Weekely_REPActiveClient_Active_paid_Job_posting_service.txt
ALL_Weekely_REPActiveClient_Active_paid_Database_service.txt
ALL_Weekely_REPActiveClient_Details.txt
ALL_Weekely_REPActiveClient_Active_trial_Other_service.txt
ALL_Weekely_REPActiveClient_Active_paid_Visibility_service.txt
ALL_Weekely_REPActiveClient_Details_NEW_changed.txt
ALL_Weekely_REPActiveClient_Details_NEW_2010_12_31.txt
ALL_Weekely_REPActiveClient_Active_paid_Other_service.txt
WEEKLY_Active_Client_details_31_June_2009_demo.txt
WEEKLY_ActiveClient_Deactive_trial_Job_posting_service_demo.txt
WEEKLY_ActiveClient_Deactive_trial_Database_service_demo.txt
WEEKLY_ActiveClient_Deactive_paid_Visibility_service_demo.txt
WEEKLY_ActiveClient_Active_trial_Other_service_demo.txt
WEEKLY_ActiveClient_Active_trial_Job_posting_service_demo.txt
WEEKLY_ActiveClient_Active_paid_Visibility_service_demo.txt
WEEKLY_ActiveClient_Active_paid_Other_service_demo.txt
WEEKLY_ActiveClient_Deactive_trial_Visibility_service_demo.txt
WEEKLY_ActiveClient_Deactive_paid_Other_service_demo.txt
WEEKLY_ActiveClient_Deactive_paid_Job_posting_service_demo.txt
WEEKLY_ActiveClient_Deactive_paid_Database_service_demo.txt
WEEKLY_ActiveClient_Active_trial_Visibility_service_demo.txt
WEEKLY_ActiveClient_Active_trial_Database_service_demo.txt
WEEKLY_ActiveClient_Active_paid_Job_posting_service_demo.txt
WEEKLY_ActiveClient_Active_paid_Database_service_demo.txt
WEEKLY_ActiveClient_Deactive_trial_Other_service_demo.txt" > dummy.txt
                 zip dummy.zip dummy.txt

txt_body="Hi Team,

Files are not available on Reporting Server (221), Please find attached ZIP file for require Reports.
All these file are needed on location below:

SERVER   :115.112.206.221
LOCATION :$LOAD_DIR

TAKE CORRECTIVE ACTION IMMEDIATELY!!!


Thanks & Regards,
DB Team
"
                 $email "dummy" "${tmail}" "${cmail}" "$cur_proc_name"  "$txt_body"
		 #remindsent=1
	fi
        sleep 3600   #wait 1 hr before checking again
        time=$(date +"%T")
        printf "time is "$time
   else
       exit
   fi
done

rm -f dummy.*
exit


