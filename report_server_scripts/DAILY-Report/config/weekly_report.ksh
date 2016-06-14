#!/bin/bash

HOME=/ndata-archive/DAILY-REPORT
export email=$HOME/generic_etl/ksh_scripts/email.pl
export cur_proc_name="Weekly Report"
export cur_proc=weeklyReport
export curr_dir=`date +%d%b%y`

cd $HOME/generic_etl/wip

if [ -r ${cur_proc}${curr_dir}.csv ]
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
     echo "get ${cur_proc}${curr_dir}.csv" >> $ftp_file
     echo "quit" >> $ftp_file
     echo "EOF" >> $ftp_file
#execute FTP script
chmod 755 ${ftp_file}
${ftp_file}
fi

if [ -r ${cur_proc}${curr_dir}.csv ]
then

echo "\"Sr.No.\",\"Client Name\",\"Account Id\",\"Vertical Id\",\"Industry\",\"Account Mgr Login Id\",\"No. of active Account Users with DB access (incl. Acct Mgr)\",\"Last activation date\",\"Last expiry date\",\"Online products active\",\"No. of logins per day in the last week\",\"No. of logins per day in the last month\",\"Active Jobs (No.)\",\"New Jobs posted in the last week\",\"New Jobs posted in the last month\",\"Total Expired Jobs\",\"Jobs expired in the last week\",\"Jobs expired in the last month\",\"No. of searches per day in the last week\",\"No. of searches per day in the last month \",\"No. of resume views per day in the last week\",\"No. of resume views per day in the last month\",\"No. Of Excel Download Last Week\",\"No. Of  Excel Download Last Month\",\"Database Service\",\"Expiry Date\",\"Start Date\",\"Joblisting Service\",\"Expiry Date\",\"Start Date\",\"Visibility Service\",\"Expiry Date\",\"Start Date\",\"Other Service\",\"Expiry Date\",\"Start Date\",\"Active Paid Services\",\"Database Service\",\"Expiry Date\",\"Start Date\",\"Joblisting Service\",\"Expiry Date\",\"Start Date\",\"Visibility Service\",\"Expiry Date\",\"Start Date\",\"Other Services\",\"Expiry Date\",\"Start Date\",\"Active Trial Services\",\"Location\",\"Contact Person\",\"Designation\",\"Contact No. Landline\",\"Contact No. Mobile\",\"Client Email Id\",\"Sales Person Email ID\",\"ZM Email ID\"" > header.txt

perl -pi -e "s/\\\N//g" ${cur_proc}${curr_dir}.csv

cat header.txt ${cur_proc}${curr_dir}.csv > ${cur_proc}${curr_dir}_H.csv
mv ${cur_proc}${curr_dir}_H.csv ${cur_proc}${curr_dir}.csv

zip ${cur_proc}${curr_dir}.zip ${cur_proc}${curr_dir}.csv

txt_body="Hi Anupam,


Please find attached file

${cur_proc}${curr_dir}.zip


Thanks,
dbteam
"

$email ${cur_proc}${curr_dir} "anupam.gupta2@timesgroup.com" "seema.mehndiratta@timesgroup.com, shagun.jha@timesgroup.com,sanjay.biswas@timesgroup.com,gaurav.kumar2@timesgroup.com" "$cur_proc_name" "$txt_body"
rm -f header.txt ${cur_proc}${curr_dir}.csv
mv ${cur_proc}${curr_dir}.zip $HOME/generic_etl/data_archive

else
	touch ${cur_proc}${curr_dir}.csv
        zip ${cur_proc}${curr_dir}.zip ${cur_proc}${curr_dir}.csv
	txt_body="Hi Team,


File is not found 

${cur_proc}${curr_dir}.zip


Thanks,
dbteam
"

$email ${cur_proc}${curr_dir} "sanjay.biswas@timesgroup.com" "sanjay.biswas@timesgroup.com,gaurav.kumar2@timesgroup.com" "$cur_proc_name" "$txt_body"
fi

exit


