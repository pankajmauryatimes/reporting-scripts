#!/bin/ksh

set +x

cd /home/dwhuser/generic_etl/data_files/resume_search_log/
./LogAnalysis.sh > ${LOG_DIR}/LogAnalysis_${Stat_date}.log 2>&1
printf "time is $time \n" >> ${LOG_DIR}/${LOG_FILE}
if [[ -r SearchLogStat_${ydate}.txt ]]
then
        printf "LogAnalysis.sh Script \n File created (SearchLogStat_${ydate}.txt) \n" >> ${LOG_DIR}/${LOG_FILE}
else
        printf "Error: Execution with LogAnalysis.sh Script \n File creation failed (SearchLogStat_${ydate}.txt) \n" >> ${LOG_DIR}/${LOG_FILE}
        printf "Error: Execution with LogAnalysis.sh Script \n File creation failed (SearchLogStat_${ydate}.txt) \n" >> ${LOG_DIR}/${LOG_FILE}
        printf "FAILED with LogAnalysis.sh Script \n" >> ${LOG_DIR}/LogAnalysis_${ydate}.log
        cat ${LOG_DIR}/${LOG_FILE} ${LOG_DIR}/LogAnalysis_${ydate}.log > ${LOG_DIR}/LogAnalysis2_${ydate}.log
        mv ${LOG_DIR}/LogAnalysis2_${ydate}.log ${LOG_DIR}/${LOG_FILE}
        exit 1
fi
mv SearchLogStat_${ydate}.txt SearchLogStat.txt
