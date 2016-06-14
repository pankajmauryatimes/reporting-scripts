#!/bin/bash


HOME=/ndata-archive/DAILY-REPORT
export email=$HOME/generic_etl/ksh_scripts/email.pl
export today=`date +%b%y`
export cur_proc_name="Monthly report for $today for TJ Mobile"
export cur_proc=monthly_report_tj_mobile
cd $HOME/generic_etl/wip

echo "Search for File :${cur_proc}"

if [ -e ${cur_proc}.zip ]
then

echo "File Found :${cur_proc}"
print "File Found :${cur_proc}"
txt_body="Hi Tina, 

Please find attached ZIP file.


Thanks,
dbteam
"

$email ${cur_proc} "kapil.bhardwaj@timesgroup.com" "sanjay.biswas@timesgroup.com,gaurav.kumar2@timesgroup.com,navneet.parashar@timesgroup.com,Satish.Daryani@timesgroup.com" "$cur_proc_name" "$txt_body"

mv ${cur_proc}.zip $HOME/generic_etl/data_archive

else

touch monthly_report_tj_mobile_info.txt
zip monthly_report_tj_mobile_info.zip monthly_report_tj_mobile_info.txt

echo "File Not Found :${cur_proc}"
txt_body="Hi Sanjay ,

File did not found ${cur_proc}


Thanks,
dbteam
"

$email  monthly_report_tj_mobile_info "sanjay.biswas@timesgroup.com" "" "Failed to sent file $cur_proc_name" "$txt_body"

rm  monthly_report_tj_mobile_info.zip monthly_report_tj_mobile_info.txt

fi

exit


