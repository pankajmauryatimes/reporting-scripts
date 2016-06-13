#!/usr/bin/ksh

set +x

cd $HOME/generic_etl/wip/


echo "\"LOGIN_ID\",\"LAST_MONTH_LOGINS\",\"LAST_MONTH_VIEW\",\"LAST_MONTH_SEARCHES\",\"AVG_LAST_MONTH_LOGINS\",\"AVG_LAST_MONTH_VIEW\",\"AVG_LAST_MONTH_SEARCHES\",\"CURR_MONTH_LOGINS\",\"CURR_MONTH_RESUME_VIEWS\",\"CURR_MONTH_NO_OF_SEARCHES\",\"AVG_CURR_MONTH_LOGINS\",\"AVG_CURR_MONTH_RESUME_VIEWS\",\"AVG_CURR_MONTH_NO_OF_SEARCHES\",\"DIFF_DAY_NO_OF_LOGINS\",\"DIFF_DAY_RESUME_VIEWS\",\"DIFF_DAY_NO_OF_SEARCHES\",\"" > Bottom20Clent_resumeview_search_H.txt

cat $HOME/generic_etl/wip/Bottom20Clent_resumeview_search_H.txt $HOME/generic_etl/wip/Bottom20Clent_resumeview_search.csv > $HOME/generic_etl/wip/Bottom20Clent_resumeview_search_${f_date}.csv

zip Bottom20Clent_resumeview_search_${f_date}.zip Bottom20Clent_resumeview_search_${f_date}.csv 

txt_body="Hi ,

Please find attached ZIP file for Resumathon (Resume View Reward) Report.


Thanks,
dbteam
"

$mutt Bottom20Clent_resumeview_search_${f_date} "$tmail" "$cmail" "Resumathon (Resume View Reward) Report" "$txt_body"

mv Bottom20Clent_resumeview_search_${f_date}.zip ../data_archive/
rm -f Bottom20Clent_resumeview_search_H.txt
#rm -f Bottom20Clent_resumeview_search.csv

