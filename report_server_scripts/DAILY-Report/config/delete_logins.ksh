#!/bin/bash

export HOME=/ndata-archive/DAILY-REPORT
export email=$HOME/generic_etl/ksh_scripts/email.pl
export cur_proc_name="Login ids to be deleted-Saint"
export cur_proc=deleted_account_list_saint
export today=`date +%m%d%Y`

cd $HOME/generic_etl/wip

if [ -r ${cur_proc}_${today}.txt ]
then


zip ${cur_proc}_${today}.zip ${cur_proc}_${today}.txt

txt_body="Hi Team,


Please find attached file or execute below query on both TJ LIVE HIRE and CAND DB.
${cur_proc}_${today}.zip


Note : Please send log file.




Thanks,
dbteam
"

$email ${cur_proc}_${today} "saints@timesgroup.com" "sanjay.biswas@timesgroup.com,shagun.jha@timesgroup.com" "$cur_proc_name" "$txt_body"
rm -f header.txt ${cur_proc}_${today}.txt
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

$email ${cur_proc}_${today} "shagun.jha@timesgroup.com" "sanjay.biswas@timesgroup.com" "NOT FOUND $cur_proc_name" "$txt_body"

rm ${cur_proc}_${today}.zip ${cur_proc}_${today}.csv
fi

exit



