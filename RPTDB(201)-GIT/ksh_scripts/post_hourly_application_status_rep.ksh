#!/bin/bash

set +x

cd ${LOG_DIR}

echo " " > app_dummy.log
echo "-- WEB --" >> app_dummy.log
echo "SUBGROUP                            SOURCE              SOURCE DESCRIPTION                       NATIVE     TRANSCRIBE" >> app_dummy.log
cat app_dummy.log web_application_v3.txt > web_application_v3.csv

echo " " > app_dummy.log
echo "-- MOBILE --" >> app_dummy.log
#echo "SOURCE              SOURCE DESCRIPTION                       NATIVE     TRANSCRIBE" >> app_dummy.log
cat app_dummy.log mob_application_v3.txt > mob_application_v3.csv

echo " " > app_dummy.log
echo "-- OTHER --" >> app_dummy.log
#echo "SOURCE              SOURCE DESCRIPTION                       NATIVE     TRANSCRIBE" >> app_dummy.log
cat app_dummy.log other_application_v3.txt > other_application_v3.csv

cat web_application_v3.csv mob_application_v3.csv other_application_v3.csv > ${LOG_DIR}/hourly_application_status_rep.txt

perl -pi -e 's/"//g' ${LOG_DIR}/hourly_application_status_rep.txt

time=$(date +"%T")
if [[ $time > $report_tm ]]; then
   cd ${HOME}/generic_etl/wip
   cp ${LOG_DIR}/application_by_source_v3.csv ${HOME}/generic_etl/wip/
   cp ${LOG_DIR}/hourly_application_status_rep.txt ${HOME}/generic_etl/wip/
   echo "\"CATEGORY\",\"SUBGROUP\",\"SOURCE_CODE\",\"SOURCE_DESC\",\"NATIVE_JOBS_COUNT\",\"TRANSCRIBED_JOBS_COUNT\"" > header.txt
   cat header.txt application_by_source_v3.csv > hourly_application_feature_wise_rep.csv
   zip hourly_application_feature_wise_rep.zip hourly_application_feature_wise_rep.csv
   txt_body=`cat hourly_application_status_rep.txt`
   echo "$txt_body"
   $mutt hourly_application_feature_wise_rep "$tmail" "$cmail" "$cur_proc_name" "$txt_body"
   mv hourly_application_feature_wise_rep.zip $HOME/generic_etl/data_archive/hourly_application_feature_wise_rep_${now}.zip
   
   rm -f hourly_application_feature_wise_rep.csv application_by_source_v3.csv header.txt hourly_application_status_rep.txt
cd -
else
   ${KSH_SCRIPTS_DIR}/mail2 $email "$cur_proc_name -Time: $now"  ${LOG_DIR}/hourly_application_status_rep.txt
fi

rm -f ${LOG_DIR}/hourly_application_status_rep.txt
rm -f ${LOG_DIR}/web_application_flat_v3.txt ${LOG_DIR}/mob_application_flat_v3.txt ${LOG_DIR}/other_application_flat_v3.txt 
rm -f web_application_v3.txt mob_application_v3.txt other_application_v3.txt
 
