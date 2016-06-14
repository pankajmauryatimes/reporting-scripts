#!/bin/bash


HOME=/ndata-archive/DAILY-REPORT
export email=$HOME/generic_etl/ksh_scripts/email.pl
export cur_proc_name="Monthly Active Client Report"
export cur_proc=monthly_report
export today=`date +%d%b%y`

cd $HOME/generic_etl/wip

if [ -r ${cur_proc}_${today}.csv ]
then
     echo "File -Found :${cur_proc}${curr_dir}.csv"
else
     export ip=172.16.84.220
     export user=dwhuser
     export pswd=dwhuser
     export ftp_dir=/tmp

     ftp_file=$HOME/generic_etl/wip/scp_file.ftp
     echo "#!/bin/ksh" > $ftp_file
     echo "HOST=$ip" >> $ftp_file
     echo "USER=$user" >> $ftp_file
     echo "PASSWD=$pswd" >> $ftp_file
     echo "ftp -in \$HOST <<EOF" >> $ftp_file
     echo "quote USER \$USER" >> $ftp_file
     echo "quote PASS \$PASSWD" >> $ftp_file
     echo "binary" >> $ftp_file
     echo "cd $ftp_dir" >> $ftp_file
     echo "pwd" >> $ftp_file
     echo "get ${cur_proc}_${today}.csv" >> $ftp_file
     echo "quit" >> $ftp_file
     echo "EOF" >> $ftp_file
#execute FTP script
chmod 755 ${ftp_file}
${ftp_file}
fi

if [ -r ${cur_proc}_${today}.csv ]
then

echo "\"Admin_Login_Id\",\"Company_Name\",\"Company_Cons_Internal\",\"Address\",\"Location_Key\",\"Location\",\"Contact_Person\",\"Designation\",\"Contact_Alt\",\"Contact_Off\",\"Email_Id\",\"Industry\",\"Expiry_Month\",\"Expiry_Date\",\"Start_Date\",\"Sales_Person_Email\",\"Vertical_ID\",\"Account_ID\",\"ZMEmailID\",\"DB_Search\",\"Resume_Viewed\",\"Active_Jobs\",\"New_Jobs\",\"Expired_Jobs\",\"Active_Account_Users\",\"Word_Doc_Download\",\"AP_Db_Service\",\"AP_DB_Expiry_Date\",\"AP_DB_Start_Date\",\"AP_job_Service\",\"AP_job_Expiry_Date\",\"AP_job_Start_Date\",\"AP_visible_Service\",\"AP_visible_Expiry_Date\",\"AP_visible_Start_Date\",\"AP_oth_Service\",\"AP_oth_Expiry_Date\",\"AP_oth_Start_Date\",\"AP_flag\",\"AT_Db_Service\",\"AT_DB_Expiry_Date\",\"AT_DB_Start_Date\",\"AT_job_Service\",\"AT_job_Expiry_Date\",\"AT_job_Start_Date\",\"AT_visible_Service\",\"AT_visible_Expiry_Date\",\"AT_visible_Start_Date\",\"AT_oth_Service\",\"AT_oth_Expiry_Date\",\"AT_oth_Start_Date\",\"AT_flag\",\"DP_Db_Service\",\"DP_DB_Expiry_Date\",\"DP_DB_Start_Date\",\"DP_job_Service\",\"DP_job_Expiry_Date\",\"DP_job_Start_Date\",\"DP_visible_Service\",\"DP_visible_Expiry_Date\",\"DP_visible_Start_Date\",\"DP_oth_Service\",\"DP_oth_Expiry_Date\",\"DP_oth_Start_Date\",\"DP_flag\",\"DT_Db_Service\",\"DT_DB_Expiry_Date\",\"DT_DB_Start_Date\",\"DT_job_Service\",\"DT_job_Expiry_Date\",\"DT_job_Start_Date\",\"DT_visible_Service\",\"DT_visible_Expiry_Date\",\"DT_visible_Start_Date\",\"DT_oth_Service\",\"DT_oth_Expiry_Date\",\"DT_oth_Start_Date\",\"DT_flag\"" > header.txt

perl -pi -e "s/\\\N//g" ${cur_proc}_${today}.csv

cat header.txt ${cur_proc}${today}.csv > ${cur_proc}${today}_H.csv
mv ${cur_proc}${today}_H.csv ${cur_proc}${today}.csv

zip ${cur_proc}_${today}.zip ${cur_proc}_${today}.csv

txt_body="Hi Anupam,


Please find attached file

${cur_proc}.zip


Thanks,
dbteam
"

$email ${cur_proc}_${today} "anupam.gupta2@timesgroup.com" "sanjay.biswas@timesgroup.com,,gaurav.kumar2@timesgroup.com" "$cur_proc_name" "$txt_body"
rm -f header.txt ${cur_proc}_${today}.csv
mv ${cur_proc}_${today}.zip $HOME/generic_etl/data_archive


else
	touch ${cur_proc}_${today}.csv
        zip ${cur_proc}_${today}.zip ${cur_proc}_${today}.csv
	txt_body="Hi Team,


File is not found 

${cur_proc}_${today}.zip


Thanks,
dbteam
"

$email ${cur_proc}${today} "sanjay.biswas@timesgroup.com" "sanjay.biswas@timesgroup.com,gaurav.kumar2@timesgroup.com" "$cur_proc_name" "$txt_body"

rm ${cur_proc}_${today}.zip ${cur_proc}_${today}.csv
fi

exit



