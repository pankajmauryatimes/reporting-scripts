#!/bin/bash

set +x
export now=`date +%Y-%m-%d' '%H:%M:%S`
perl -pi -e 's/"//g' ${LOG_DIR}/Alert_Process_monitor_job_not_running.txt
echo "DESCRIPTION                   ALERTCOMBINATION_ID" > ${LOG_DIR}/Alert_Process_monitor_job_not_running2.txt
echo "-----------                   -------------------" >> ${LOG_DIR}/Alert_Process_monitor_job_not_running2.txt
cat ${LOG_DIR}/Alert_Process_monitor_job_not_running2.txt ${LOG_DIR}/Alert_Process_monitor_job_not_running.txt > ${LOG_DIR}/Alert_Process_monitor_job_not_running3.txt
mv ${LOG_DIR}/Alert_Process_monitor_job_not_running3.txt ${LOG_DIR}/Alert_Process_monitor_job_not_running.txt
rm -f ${LOG_DIR}/Alert_Process_monitor_job_not_running3.txt ${LOG_DIR}/Alert_Process_monitor_job_not_running2.txt
${KSH_SCRIPTS_DIR}/mail2 $email   "$cur_proc_name -Time: $now"  ${LOG_DIR}/Alert_Process_monitor_job_not_running.txt
rm -f ${LOG_DIR}/Alert_Process_monitor_job_not_running.txt
exit 0

