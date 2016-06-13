#!/usr/bin/ksh

set +x

cd $HOME/generic_etl/wip/


echo "\"NAME\",\"COM_NAME\",\"EMAIL\",\"MOBILE\",\"CREATE_DATE\"" > sales_leads_demo_H.txt

cat $HOME/generic_etl/wip/sales_leads_demo_H.txt $HOME/generic_etl/wip/daily_sales_leads_demo.csv > $HOME/generic_etl/wip/daily_sales_leads_demo_${f_date}.csv

zip daily_sales_leads_demo_${f_date}.zip daily_sales_leads_demo_${f_date}.csv 

txt_body="Hi ,

Please find attached ZIP file for Daily Sales Lead (DEMO).


Thanks,
dbteam
"

$mutt daily_sales_leads_demo_${f_date} "$tmail" "$cmail" "$cur_proc_name" "$txt_body"

mv daily_sales_leads_demo_${f_date}.zip ../data_archive/
rm -f sales_leads_demo_H.txt
rm -f daily_sales_leads_demo_${f_date}.csv 

