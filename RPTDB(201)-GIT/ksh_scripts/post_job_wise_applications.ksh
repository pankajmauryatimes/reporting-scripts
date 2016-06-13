#!/bin/bash


echo "\"JOB_ID\",\"POSTING_DATE\",\"JOB_TYPE\",\"APP_COUNT\"" > $HOME/generic_etl/wip/header.txt
cat $HOME/generic_etl/wip/header.txt $HOME/generic_etl/wip/job_wise_applications_$today.csv > $HOME/generic_etl/wip/job_wise_applications_$today.txt
mv $HOME/generic_etl/wip/job_wise_applications_$today.txt $HOME/generic_etl/wip/job_wise_applications_$today.csv

cd $HOME/generic_etl/wip

zip job_wise_applications_$today.zip job_wise_applications_$today.csv
txt_body="Hi ,

Please find attached ZIP file \"job_wise_applications_$today.zip\".

Number of application against each native and transcribed jobs.



Thanks,
dbteam
"
$mutt job_wise_applications_$today "$tmail" "$cmail" "$cur_proc_name " "$txt_body"

mv $HOME/generic_etl/wip/job_wise_applications_$today.zip $HOME/generic_etl/data_archive/
rm -f $HOME/generic_etl/wip/job_wise_applications_$today.csv
rm $HOME/generic_etl/wip/header.txt
