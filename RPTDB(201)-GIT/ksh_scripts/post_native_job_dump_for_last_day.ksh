#!/bin/bash

set +x

cd ${LOAD_DIR}

   echo "\"JOB_ID\",\"NET_STATUS\",\"POSTING_DATE\",\"EXPIRY_DATE\",\"ADMIN_LOGIN_ID\",\"LOGIN_ID\",\"JOB_TITLE\",\"WORK_EXP\",\"SALARY\",\"JOB_LOCCATION\",\"AREA_OF_SPECIALIZATION\",\"FUNCTIONAL_AREA\",\"INDUSTRY\",\"SKILL\",\"JOB_DESCRIPTION\"" > native_job_dump_header.txt
   cat native_job_dump_header.txt native_job_dump_for_last_day.txt > native_job_dump_for_last_day.csv
   
   zip native_job_dump_for_last_day_${dmo}.zip native_job_dump_for_last_day.csv 
   echo "Hi All
    Please find attached Dump of Native Jobs posted on yesterday"
   $mutt native_job_dump_for_last_day_${dmo} "$tomail" "$ccmail" "$cur_proc_name" "$txt_body"
   rm native_job_dump_header.txt
   #mv hourly_application_feature_wise_rep.zip $HOME/generic_etl/data_archive/hourly_application_feature_wise_rep_${now}.zip
   
   #${KSH_SCRIPTS_DIR}/mail2 $email "$cur_proc_name -Time: $now"  ${LOG_DIR}/hourly_application_feature_wise_rep.csv
 
