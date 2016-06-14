#!/bin/bash

export email=$HOME/generic_etl/ksh_scripts/email.pl
export cur_proc_name="Active and Expire Client Report with Pay Mode"
export cur_proc=active_expire_report_v2
export today=`date +%d%b%y`

cd $HOME/generic_etl/wip

if [ -r active_report_v2_${today}.csv ]
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
     echo "get expire_report_${today}.csv" >> $ftp_file
     echo "get active_report_${today}.csv" >> $ftp_file
     echo "quit" >> $ftp_file
     echo "EOF" >> $ftp_file
#execute FTP script
chmod 755 ${ftp_file}
${ftp_file}
fi

if [ -r expire_report_v2_${today}.csv ]
then

#echo "\"Sr.No.\",\"Client Name\",\"Account Id\",\"Vertical Id\",\"Industry\",\"Account Mgr Login Id\",\"No. of active Account Users with DB access (incl. Acct Mgr)\",\"Last activation date\",\"Last expiry date\",\"Online products active\",\"Avg No. of logins per day in the last week\",\"Avg No. of logins per day in the last month\",\"Active Jobs (No.)\",\"New Jobs posted in the last week\",\"New Jobs posted in the last month\",\"Total Expired Jobs\",\"Jobs expired in the last week\",\"Jobs expired in the last month\",\"Avg No. of searches per day in the last week\",\"Avg No. of searches per day in the last month \",\"Avg. no. of resume views per day in the last week\",\"Avg. no. of resume views per day in the last month\",\"Avg. No. Of Excel Download Last Week\",\"Avg. No. Of  Excel Download Last Month\",\"Database Service\",\"Expiry Date\",\"Start Date\",\"Joblisting Service\",\"Expiry Date\",\"Start Date\",\"Visibility Service\",\"Expiry Date\",\"Start Date\",\"Other Service\",\"Expiry Date\",\"Start Date\",\"Active Paid Services\",\"Database Service\",\"Expiry Date\",\"Start Date\",\"Joblisting Service\",\"Expiry Date\",\"Start Date\",\"Visibility Service\",\"Expiry Date\",\"Start Date\",\"Other Services\",\"Expiry Date\",\"Start Date\",\"Active Trial Services\",\"Location\",\"Contact Person\",\"Designation\",\"Contact No. Landline\",\"Contact No. Mobile\",\"Client Email Id\",\"Sales Person Email ID\",\"ZM Email ID\"" > header.txt

perl -pi -e "s/\\\N//g" expire_report_v2_${today}.csv
perl -pi -e "s/\\\N//g" active_report_v2_${today}.csv

#cat header.txt ${cur_proc}${today}.csv > ${cur_proc}${today}_H.csv
#mv ${cur_proc}${today}_H.csv ${cur_proc}${today}.csv

zip expire_report_v2_${today}.zip expire_report_v2_${today}.csv
zip active_report_v2_${today}.zip active_report_v2_${today}.csv

#zip ${cur_proc}_${today}.zip expire_report_${today}.zip active_report_${today}.zip
txt_body="Hi Anupam,


Please find attached file

${cur_proc}.zip


Thanks,
dbteam
"

$email active_report_v2_${today} "anupam.gupta2@timesgroup.com" "sanjay.biswas@timesgroup.com," "$cur_proc_name -Active Client with Pay Mode" "$txt_body"

txt_body="Hi Anupam,


Please find attached file

${cur_proc}.zip


Thanks,
dbteam
"

$email expire_report_v2_${today} "anupam.gupta2@timesgroup.com" "sanjay.biswas@timesgroup.com" "$cur_proc_name -Expire Client with Pay Mode" "$txt_body"

rm -f header.txt ${cur_proc}_${today}.csv
rm -f ${cur_proc}_${today}.csv expire_report_v2_${today}.csv active_report_v2_${today}.csv
mv active_report_v2_${today}.zip $HOME/generic_etl/data_archive
mv expire_report_v2_${today}.zip $HOME/generic_etl/data_archive


else
	touch ${cur_proc}_${today}.csv
        zip ${cur_proc}_${today}.zip ${cur_proc}_${today}.csv
	txt_body="Hi Team,


File is not found 

${cur_proc}_${today}.zip


Thanks,
dbteam
"

$email ${cur_proc}${today} "sanjay.biswas@timesgroup.com" "sanjay.biswas@timesgroup.com" "$cur_proc_name" "$txt_body"
fi

exit


