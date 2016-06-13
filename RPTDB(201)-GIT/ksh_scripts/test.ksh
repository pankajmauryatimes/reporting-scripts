#!/bin/bash

set +x

. $HOME/generic_etl/config/pwhs.env
. $HOME/generic_etl/config/Application_Status_today.env

export email=sanjay.biswas@timesgroup.com
export tmail=sanjay.biswas@timesgroup.com
export cmail=tjbi@timesgroup.com

cd ${LOG_DIR}

echo " " > app_dummy.log
echo "-- WEB --" >> app_dummy.log
echo "SOURCE              SOURCE DESCRIPTION                       NATIVE     TRANSCRIBE" >> app_dummy.log
cat app_dummy.log web_application.txt > web_application.csv

echo " " > app_dummy.log
echo "-- MOBILE --" >> app_dummy.log
#echo "SOURCE              SOURCE DESCRIPTION                       NATIVE     TRANSCRIBE" >> app_dummy.log
cat app_dummy.log mob_application.txt > mob_application.csv

echo " " > app_dummy.log
echo "-- OTHER --" >> app_dummy.log
#echo "SOURCE              SOURCE DESCRIPTION                       NATIVE     TRANSCRIBE" >> app_dummy.log
cat app_dummy.log other_application.txt > other_application.csv

cat web_application.csv mob_application.csv other_application.csv > ${LOG_DIR}/Application_Status_today.txt

perl -pi -e 's/"//g' ${LOG_DIR}/Application_Status_today.txt

time=$(date +"%T")
if [[ $time > $report_tm ]]; then
   cd ${HOME}/generic_etl/wip
   cp ${LOG_DIR}/application_by_source.csv ${HOME}/generic_etl/wip/
   cp ${LOG_DIR}/Application_Status_today.txt ${HOME}/generic_etl/wip/
sleep 500
   echo "\"SOURCE_CODE\",\"SOURCE_DESC\",\"NATIVE_JOBS_COUNT\",\"TRANSCRIBED_JOBS_COUNT\"" > header.txt
   cat header.txt application_by_source.csv > APPLICATION_STATUS_TILL_DATE.csv
   zip APPLICATION_STATUS_TILL_DATE.zip APPLICATION_STATUS_TILL_DATE.csv
   txt_body=`cat Application_Status_today.txt`
   echo "$txt_body"
   $mutt APPLICATION_STATUS_TILL_DATE "$tmail" "$cmail" "$cur_proc_name" "$txt_body"

   #mv APPLICATION_STATUS_TILL_DATE.zip $HOME/generic_etl/data_archive/APPLICATION_STATUS_TILL_DATE_${now}.zip

   #rm -f APPLICATION_STATUS_TILL_DATE.csv application_by_source.csv header.txt Application_Status_today.txt
cd -
else
   ${KSH_SCRIPTS_DIR}/mail $email "$cur_proc_name -Time: $now"  ${LOG_DIR}/Application_Status_today.txt
fi

#rm -f ${LOG_DIR}/Application_Status_today.txt
#rm -f ${LOG_DIR}/web_application_flat.txt ${LOG_DIR}/mob_application_flat.txt ${LOG_DIR}/other_application_flat.txt
#rm -f web_application.csv mob_application.csv other_application.csv web_application.txt mob_application.txt other_application.txt
cd -
exit 1

