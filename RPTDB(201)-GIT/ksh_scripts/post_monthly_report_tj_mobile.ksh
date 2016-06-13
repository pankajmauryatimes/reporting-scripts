#!/usr/bin/ksh

set +x

echo "\"COUNT\",\"SERVICE_NAME\",\"SOURCE\"" > $HOME/generic_etl/wip/header.txt
cat $HOME/generic_etl/wip/header.txt $HOME/generic_etl/wip/tj_webservices_usages_${f_date}_A.csv > $HOME/generic_etl/wip/tj_webservices_usages_${f_date}_AH.csv
mv $HOME/generic_etl/wip/tj_webservices_usages_${f_date}_AH.csv $HOME/generic_etl/wip/tj_webservices_usages_${f_date}_A.csv

echo "\"LOGIN_ID\",\"SOURCE\"" > $HOME/generic_etl/wip/header.txt
cat $HOME/generic_etl/wip/header.txt $HOME/generic_etl/wip/tj_webservices_usages_${f_date}_B.csv > $HOME/generic_etl/wip/tj_webservices_usages_${f_date}_BH.csv
mv $HOME/generic_etl/wip/tj_webservices_usages_${f_date}_BH.csv $HOME/generic_etl/wip/tj_webservices_usages_${f_date}_B.csv

echo "\"MOBSEQ_ID\",\"UNIQUE_ID\",\"PLATEFORM\",\"FIELD_1\",\"FIELD_2\",\"CREATE_DATE\",\"MODIFY_DATE\",\"TOKEN\"" > $HOME/generic_etl/wip/header.txt
cat $HOME/generic_etl/wip/header.txt $HOME/generic_etl/wip/MOBILE_USAGE_TRACK_${f_date}_C.csv > $HOME/generic_etl/wip/MOBILE_USAGE_TRACK_${f_date}_CH.csv
mv $HOME/generic_etl/wip/MOBILE_USAGE_TRACK_${f_date}_CH.csv $HOME/generic_etl/wip/MOBILE_USAGE_TRACK_${f_date}_C.csv

echo "\"CAPTURE_TIME\",\"FEATURE_NAME\",\"SOURCE\",\"COUNT\"" > $HOME/generic_etl/wip/header.txt
cat $HOME/generic_etl/wip/header.txt $HOME/generic_etl/wip/career_services_lead_MOB_${f_date}_D.csv > $HOME/generic_etl/wip/career_services_lead_MOB_${f_date}_DH.csv
mv $HOME/generic_etl/wip/career_services_lead_MOB_${f_date}_DH.csv $HOME/generic_etl/wip/career_services_lead_MOB_${f_date}_D.csv

cd $HOME/generic_etl/wip
rm -f monthly_report_tj_mobile_A.zip
rm -f monthly_report_tj_mobile_B.zip

zip monthly_report_tj_mobile_A.zip tj_webservices_usages_${f_date}_A.csv MOBILE_USAGE_TRACK_${f_date}_C.csv 
zip monthly_report_tj_mobile_B.zip tj_webservices_usages_${f_date}_B.csv 
zip monthly_report_tj_mobile_C.zip career_services_lead_MOB_${f_date}_D.csv

#mv monthly_report_tj_mobile.zip $HOME/generic_etl/wip/

txt_body="Hi Tina,

Please find attached ZIP file.

monthly_report_tj_mobile_B.zip

Thanks,
dbteam
"

$mutt ${cur_proc}_B "$tmail" "$cmail" "$cur_proc_name Part 2/3" "$txt_body"

txt_body="Hi Tina,

Please find attached ZIP file.

monthly_report_tj_mobile_A.zip

Thanks,
dbteam
"

$mutt ${cur_proc}_A "$tmail" "$cmail" "$cur_proc_name Part 1/3" "$txt_body"


txt_body="Hi Tina,

Please find attached ZIP file.

monthly_report_tj_mobile_C.zip

Thanks,
dbteam
"

$mutt ${cur_proc}_C "$tmail" "$cmail" "$cur_proc_name Part 3/3" "$txt_body"


mv $HOME/generic_etl/wip/${cur_proc}_A.zip $HOME/generic_etl/data_archive
mv $HOME/generic_etl/wip/${cur_proc}_B.zip $HOME/generic_etl/data_archive
rm -f $HOME/generic_etl/wip/header.txt
rm -f $HOME/generic_etl/wip/monthly_report_tj_mobile*
