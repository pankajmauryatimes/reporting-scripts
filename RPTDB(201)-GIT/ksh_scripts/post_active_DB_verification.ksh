#!/usr/bin/ksh

set +x

echo "\"LOGIN_ID\"" > $HOME/generic_etl/wip/header.txt
cat $HOME/generic_etl/wip/header.txt $HOME/generic_etl/wip/daily_applicants_${f_date}.csv > $HOME/generic_etl/wip/daily_applicants_${f_date}_H.csv
mv $HOME/generic_etl/wip/daily_applicants_${f_date}_H.csv $HOME/generic_etl/wip/daily_applicants_${f_date}.csv

echo "\"LOGIN_ID\"" > $HOME/generic_etl/wip/header.txt
cat $HOME/generic_etl/wip/header.txt $HOME/generic_etl/wip/daily_logins_${f_date}.csv > $HOME/generic_etl/wip/daily_logins_${f_date}_H.csv
mv $HOME/generic_etl/wip/daily_logins_${f_date}_H.csv $HOME/generic_etl/wip/daily_logins_${f_date}.csv

echo "\"LOGIN_ID\"" > $HOME/generic_etl/wip/header.txt
cat $HOME/generic_etl/wip/header.txt $HOME/generic_etl/wip/daily_profile_edits_${f_date}.csv > $HOME/generic_etl/wip/daily_profile_edits_${f_date}_H.csv
mv $HOME/generic_etl/wip/daily_profile_edits_${f_date}_H.csv $HOME/generic_etl/wip/daily_profile_edits_${f_date}.csv

cd $HOME/generic_etl/wip
rm -f report_active_DB_logins_${f_date}.zip

zip report_active_DB_logins_${f_date}.zip daily_applicants_${f_date}.csv daily_logins_${f_date}.csv daily_profile_edits_${f_date}.csv 

#mv monthly_report_tj_mobile.zip $HOME/generic_etl/wip/

txt_body="Hi,

Please find attached ZIP file \"report_active_DB_logins_${f_date}.zip\".

for 
-	Searchable resume Login ids
-	Login ids who applied last day
-	Login ids who edited their profile last day
 

Thanks,
dbteam
"

$mutt report_active_DB_logins_${f_date} "$tmail" "$cmail" "$cur_proc_name" "$txt_body"

mv $HOME/generic_etl/wip/report_active_DB_logins_${f_date}.zip $HOME/generic_etl/data_archive/
rm -f $HOME/generic_etl/wip/header.txt
rm -f $HOME/generic_etl/wip/daily_applicants_${f_date}.csv
rm -f $HOME/generic_etl/wip/daily_logins_${f_date}.csv
rm -f $HOME/generic_etl/wip/daily_profile_edits_${f_date}.csv
