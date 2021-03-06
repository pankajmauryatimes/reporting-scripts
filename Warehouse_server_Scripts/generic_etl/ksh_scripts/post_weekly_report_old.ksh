#!/bin/bash

set +x
export pth=`date +%d%b%y`

cd /home/dwhuser/generic_etl/wip
perl -pi -e 's/,,/,\\N,/g' ALL_*
mysql -udwhuser -pdwhuser tjdwh_staging < /home/dwhuser/generic_etl/txt_files/weekly_report.txt > /home/dwhuser/generic_etl/logs/weekly_report_${pth}.log
echo "select '\"',Client_Name,'\",\"',Account_Id,'\",\"',Vertical_Id,'\",\"',Industry,'\",\"',Admin_Login_Id,'\",\"',Acc_User_DB_access,'\",\"',Last_activation_date,'\",\"',Last_expiry_date,'\",\"',Online_products_active,'\",\"',logins_per_day_in_last_week,'\",\"',logins_per_day_in_last_month,'\",\"',Active_Jobs,'\",\"',New_Jobs_posted_in_last_week,'\",\"',New_Jobs_posted_in_last_month,'\",\"',Total_Expired_Jobs,'\",\"',Jobs_expired_in_last_week,'\",\"',Jobs_expired_in_last_month,'\",\"',searches_per_day_in_last_week,'\",\"',searches_per_day_in_last_month,'\",\"',resume_views_per_day_in_last_week,'\",\"',resume_views_per_day_in_last_month,'\",\"',Excel_Download_Last_Week,'\",\"',Excel_Download_Last_Month,'\",\"',pd_Db_Service,'\",\"',pd_db_Expiry_Date,'\",\"',pd_db_Start_Date,'\",\"',pd_job_Service,'\",\"',pd_job_Expiry_Date,'\",\"',pd_job_Start_Date,'\",\"',pd_visible_Service,'\",\"',pd_visible_Expiry_Date,'\",\"',pd_visible_Start_Date,'\",\"',pd_oth_Service,'\",\"',pd_oth_Expiry_Date,'\",\"',pd_oth_Start_Date,'\",\"',pd_flag,'\",\"',tr_Db_Service,'\",\"',tr_db_Expiry_Date,'\",\"',tr_db_Start_Date,'\",\"',tr_job_Service,'\",\"',tr_job_Expiry_Date,'\",\"',tr_job_Start_Date,'\",\"',tr_visible_Service,'\",\"',tr_visible_Expiry_Date,'\",\"',tr_visible_Start_Date,'\",\"',tr_oth_Service,'\",\"',tr_oth_Expiry_Date,'\",\"',tr_oth_Start_Date,'\",\"',tr_flag,'\",\"',Location,'\",\"',Contact_Person,'\",\"',Designation,'\",\"',Contact_Landline,'\",\"',Contact_Mobile,'\",\"',Client_Email_Id,'\",\"',Sales_Person_Email_ID,'\",\"',ZM_Email_ID,'\",\"',col1,'\",\"',col2,'\",\"',col3,'\",\"',col4,'\",\"',col5,'\",\"',col6,'\",\"',col7,'\",\"',col8,'\",\"',col9,'\",\"',col10,'\",\"',col11,'\",\"',col12,'\",\"',col13,'\",\"',col14,'\",\"',col15,'\",\"',col16,'\",\"',col17,'\",\"',col18,'\",\"',col19,'\",\"',col20,'\",\"',col21,'\",\"',col22,'\",\"',col23,'\",\"',col24,'\",\"',col25,'\",\"',col26,'\"'  into outfile '/tmp/weeklyReport_${pth}.csv' from weekly_report_fact where create_date=date(now());" > /home/dwhuser/generic_etl/wip/weekly_report_sql_${pth}.txt

mysql -udwhuser -pdwhuser tjdwh_staging < /home/dwhuser/generic_etl/wip/weekly_report_sql_${pth}.txt > /home/dwhuser/generic_etl/logs/weekly_report_sql_${pth}.log

mkdir /home/dwhuser/generic_etl/data_archive/weekly_report/$pth
gzip /home/dwhuser/generic_etl/wip/ALL_*.*
mv /home/dwhuser/generic_etl/wip/ALL_*.gz /home/dwhuser/generic_etl/data_archive/weekly_report/$pth/
mv /home/dwhuser/generic_etl/wip/weekly_report_sql_${pth}.txt /home/dwhuser/generic_etl/data_archive/active_expire/$pth/
cd /tmp
perl -pi -e \'/s/\t//g\' weekly_report_${pth}.csv
perl -pi -e \'/s/\\N//g\' weekly_report_${pth}.csv

exit
