#!/bin/bash

cd ${HOME}/generic_etl/wip/


cp -p /opt/dw_data/mongo_db/push_data/iphone_push_report_${SourceFile_date}.csv ${HOME}/generic_etl/data_archive
cp -p /opt/dw_data/mongo_db/push_data/and_push_report_${SourceFile_date}.csv ${HOME}/generic_etl/data_archive

cp -p /opt/dw_data/mongo_db/push_data/iphone_push_report_${SourceFile_date}.csv ${HOME}/generic_etl/wip/iphone_push_report_stg.csv
cp -p /opt/dw_data/mongo_db/push_data/and_push_report_${SourceFile_date}.csv ${HOME}/generic_etl/wip/and_push_report_stg.csv

sed -i '1d' ${HOME}/generic_etl/wip/iphone_push_report_stg.csv
sed -i '1d' ${HOME}/generic_etl/wip/and_push_report_stg.csv

sed -i '/^$/d' ${HOME}/generic_etl/wip/iphone_push_report_stg.csv
sed -i '/^$/d' ${HOME}/generic_etl/wip//and_push_report_stg.csv

perl -pi -e "s/^/${SourceFile_date},/g" ${HOME}/generic_etl/wip/iphone_push_report_stg.csv
perl -pi -e "s/^/${SourceFile_date},/g" ${HOME}/generic_etl/wip/and_push_report_stg.csv

echo "create_date,device,Total_user,Active_users,Login_id_device_id,ActiveDevice_loginId,TotalNafSent,TotalNafJobSent,TotalNafJobAlertSent,TotalNafResumeViewSent,Unique_Di_Li_NAF_pushed,invalid_sender_id,iphone_InvalidRegistration,iphone_APPLE_CLOUD_DOWN,error_iphone_CLOUD_DOWN_CommExce" > header_i.txt

echo "create_date,device,Total_user,Active_users,Login_id_device_id,ActiveDevice_loginId,TotalNafSent,TotalNafJobSent,TotalNafJobAlertSent,TotalNafResumeViewSent,UniqueDeviceId_LoginId_Naf_Pushed,errorMisingCollapseKey,messageTobig,error_NR,error_MismatchSenderId,error_DQ_exceeded,error_QExceeded,error_INvalid_token_id" > header_a.txt

cat header_i.txt ${HOME}/generic_etl/wip/iphone_push_report_stg.csv > ${HOME}/generic_etl/wip/iphone_push_report.csv
cat header_a.txt ${HOME}/generic_etl/wip/and_push_report_stg.csv > ${HOME}/generic_etl/wip/and_push_report.csv

rm header_a.txt header_i.txt iphone_push_report_stg.csv and_push_report_stg.csv 

