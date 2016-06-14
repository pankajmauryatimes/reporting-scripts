#!/bin/bash


HOME=/ndata-archive/DAILY-REPORT
export email=$HOME/generic_etl/ksh_scripts/email.pl
export cur_proc_name="Weekly Report For Demo Logins"
export cur_proc=weekly_report_demo_till_date
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

echo "\"Manger Login Id\",\"Company Name\",\"Company / Consultant / Internal\",\"Address\",\"Location Key\",\"Location\",\"Contact Person\",\"Designation\",\"Contact Alt\",\"Contact Off\",\"Email Id\",\"Industry\",\"Expiry Month\",\"Expiry Date\",\"Start Date\",\"Sales Person Email\",\"Vertical_ID\",\"Account_ID\",\"ZMEmailID\",\"Login_Count\",\"DB Search\",\"Resume Viewed\",\"Active Jobs\",\"New Jobs \",\"Expired Jobs\",\"Active Account Users\",\"Word Doc Download\",\"Database Service\",\"Expiry Date\",\"Start Date\",\"Joblisting Service\",\"Expiry Date\",\"Start Date\",\"Visibility Service\",\"Expiry Date\",\"Start Date\",\"Other Service\",\"Expiry Date\",\"Start Date\",\"Active Paid Services\",\"Database Service\",\"Expiry Date\",\"Start Date\",\"Joblisting Service\",\"Expiry Date\",\"Start Date\",\"Visibility Service\",\"Expiry Date\",\"Start Date\",\"Other Services\",\"Expiry Date\",\"Start Date\",\"Active Trial Services\",\"Database Service\",\"Expiry Date\",\"Start Date\",\"Joblisting Service\",\"Expiry Date\",\"Start Date\",\"Visibility Service\",\"Expiry Date\",\"Start Date\",\"Other Service\",\"Expiry Date\",\"Start Date\",\"Deactivated Active Paid Services \",\"Database Service\",\"Expiry Date\",\"Start Date\",\"Joblisting Service\",\"Expiry Date\",\"Start Date\",\"Visibility Service\",\"Expiry Date\",\"Start Date\",\"Other Service\",\"Expiry Date\",\"Start Date\",\"Deactivated Active Trial Services\"" > header.txt

perl -pi -e "s/\\\N//g" ${cur_proc}_${today}.csv
cat header.txt ${cur_proc}_${today}.csv > ${cur_proc}_${today}_H.csv
mv ${cur_proc}_${today}_H.csv ${cur_proc}_${today}.csv
zip ${cur_proc}_${today}.zip ${cur_proc}_${today}.csv

txt_body="Hi Navneet,


Please find attached file

${cur_proc}_${today}.zip


Thanks,
dbteam
"

$email ${cur_proc}_${today} "navneet.parashar@timesgroup.com" "sanjay.biswas@timesgroup.com,,gaurav.kumar2@timesgroup.com" "$cur_proc_name" "$txt_body"

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

$email ${cur_proc}_${today} "sanjay.biswas@timesgroup.com" "sanjay.biswas@timesgroup.com,gaurav.kumar2@timesgroup.com" "$cur_proc_name" "$txt_body"
fi

exit


