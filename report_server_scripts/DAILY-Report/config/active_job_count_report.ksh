#!/bin/bash


HOME=/ndata-archive/DAILY-REPORT
export email=$HOME/generic_etl/ksh_scripts/email.pl
export cur_proc_name="Active Job Count Report"
export cur_proc=Anupam_Report_ACtive_job_counts
export today=`date +%d%b%y`

cd $HOME/$today/corp

zip ${cur_proc}_${today}.zip ${cur_proc}.txt

txt_body="Hi Anupam,


Please find attached file

${cur_proc}.zip


Thanks,
dbteam
"

$email ${cur_proc}_${today} "anupam.gupta2@timesgroup.com" "sanjay.biswas@timesgroup.com,gaurav.kumar2@timesgroup.com" "$cur_proc_name" "$txt_body"
#rm -f header.txt ${cur_proc}_${today}.csv
mv ${cur_proc}_${today}.zip $HOME/generic_etl/data_archive

exit



