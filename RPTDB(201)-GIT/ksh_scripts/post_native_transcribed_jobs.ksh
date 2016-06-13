#!/usr/bin/ksh

set +x

echo "\"AD_ID\",\"POSTING_DATE\",\"LOGIN_ID\",\"ADMIN_LOGIN_ID\",\"JOB_FUNCTION\",\"FUNC_AREA_SPEC\",\"WORK_EXP\",\"WORK_EXP2\",\"LOCATION\",\"JOB_TITLE\",\"LOWSALARY\",\"HIGHSALARY\",\"COUNT\"" > $HOME/generic_etl/wip/header.txt

cat $HOME/generic_etl/wip/header.txt $HOME/generic_etl/wip/native_jobs_parameter.csv > $HOME/generic_etl/wip/native_jobs_parameter_${f_date}.csv

echo "\"AD_ID\",\"POSTING_DATE\",\"LOGIN_ID\",\"ADMIN_LOGIN_ID\",\"JOB_FUNCTION\",\"FUNC_AREA_SPEC\",\"WORK_EXP\",\"WORK_EXP2\",\"JOB_TITLE\",\"LOCATION\",\"LOWSALARY\",\"HIGHSALARY\",\"COUNT\"" > $HOME/generic_etl/wip/header.txt

cat $HOME/generic_etl/wip/header.txt $HOME/generic_etl/wip/transcribed_jobs_parameter.csv > $HOME/generic_etl/wip/transcribed_jobs_parameter_${f_date}.csv

cd $HOME/generic_etl/wip

zip native_transcribed_jobs.zip native_jobs_parameter_${f_date}.csv transcribed_jobs_parameter_${f_date}.csv

txt_body="Hi ,

Please find attached ZIP file \"native_transcribed_jobs.zip\".

Number of application against each job (native and transcribed) exacted for last 7 days from the posting.


Native Jobs: \"native_jobs_parameter_${f_date}.csv\"
Transcribed Jobs: \"transcribed_jobs_parameter_${f_date}.csv\"

Thanks,
dbteam
"

$mutt native_transcribed_jobs "$tmail" "$cmail" "$cur_proc_name " "$txt_body"


mv $HOME/generic_etl/wip/native_transcribed_jobs.zip  $HOME/generic_etl/data_archive
rm -f $HOME/generic_etl/wip/header.txt
rm -f $HOME/generic_etl/wip/transcribed_jobs_parameter_${f_date}.csv
rm -f $HOME/generic_etl/wip/native_jobs_parameter_${f_date}.csv
rm -f $HOME/generic_etl/wip/transcribed_jobs_parameter.csv
rm -f $HOME/generic_etl/wip/native_jobs_parameter.csv
