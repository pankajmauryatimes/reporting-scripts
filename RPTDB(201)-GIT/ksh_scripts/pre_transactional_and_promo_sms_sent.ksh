#!/usr/bin/ksh

set +x

cd $HOME/generic_etl/wip/

echo "\"DATE\",\"SMS_TYPE\",\"COUNT\"" > ${cur_proc}_H.txt

cat ${cur_proc}_H.txt ${cur_proc}.csv > ${cur_proc}_${f_date}.csv

zip ${cur_proc}_${f_date}.zip ${cur_proc}_${f_date}.csv 

txt_body="Hi ,

Please find attached ZIP file for Daily Sales Lead (DEMO).


Thanks,
dbteam
"

 $mutt ${cur_proc}_${f_date} "$tmail" "$cmail" "$cur_proc_name" "$txt_body"

#mv daily_sales_leads_demo_${f_date}.zip ../data_archive/
rm -f sales_leads_demo_H.txt
rm -f Bottom20Clent_resumeview_search.csv
rm -f transactional_and_promo_sms_sent.ftp
rm -f transactional_and_promo_sms_sent.csv
rm -f transactional_and_promo_sms_sent_20150615.csv
