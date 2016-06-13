#!/bin/ksh

set +x

cd /home/dwhuser/generic_etl/data_files/resume_daily_stat/scripts/
./ResumeDailyStat.sh > ${LOG_DIR}/ResumeDailyStat_${today}.log 2>&1
printf "time is $time \n" >> ${LOG_DIR}/${LOG_FILE}
if [[ -r DailyStat_${today}.txt ]]
then
        printf " ResumeDailyStat.sh Script \n File created (DailyStat_${today}.txt) \n" >> ${LOG_DIR}/${LOG_FILE}
else
	printf "Error: Execution with ResumeDailyStat.sh Script \n File creation failed (DailyStat_${today}.txt) \n" >> ${LOG_DIR}/${LOG_FILE}
        printf "Error: Execution with ResumeDailyStat.sh Script \n File creation failed (DailyStat_${today}.txt) \n" >> ${LOG_DIR}/${LOG_FILE}
        printf "FAILED with ResumeDailyStat.sh Script \n" >> ${LOG_DIR}/${LOG_FILE}
        cat ${LOG_DIR}/${LOG_FILE} ${LOG_DIR}/ResumeDailyStat_${today}.log > ${LOG_DIR}/ResumeDailyStat2_${today}.log
        mv ${LOG_DIR}/ResumeDailyStat2_${today}.log  ${LOG_DIR}/${LOG_FILE}
#	exit 1
fi


./FA_Distribution.sh > ${LOG_DIR}/FA_Distribution_${today}.log 2>&1
printf "time is $time \n" >> ${LOG_DIR}/${LOG_FILE}
if [[ -r DailyStat_${today}.txt ]]
then
        printf " FA_Distribution.sh Script \n File created (DailyStat_${today}.txt) \n" >> ${LOG_DIR}/${LOG_FILE}
else
        printf "Error: Execution with FA_Distribution.sh Script \n File creation failed (FA_Distribution_${today}.txt) \n" >> ${LOG_DIR}/${LOG_FILE}
        printf "Error: Execution with FA_Distribution.sh Script \n File creation failed (FA_Distribution_${today}.txt) \n" >> ${LOG_DIR}/${LOG_FILE}
        printf "FAILED with FA_Distribution.sh Script \n" >> ${LOG_DIR}/${LOG_FILE}
        cat ${LOG_DIR}/${LOG_FILE} ${LOG_DIR}/FA_Distribution_${today}.log > ${LOG_DIR}/FA_Distribution2_${today}.log
        mv ${LOG_DIR}/FA_Distribution2_${today}.log  ${LOG_DIR}/${LOG_FILE}
        #exit 1
fi

./DataRequest_SearchIndex_Alert.sh > ${LOG_DIR}/DataRequest_SearchIndex_Alert_${today}.log 2>&1
printf "time is $time \n" >> ${LOG_DIR}/${LOG_FILE}
if [[ -r DailyStat_${today}.txt ]]
then
        printf " DataRequest_SearchIndex_Alert.sh Script \n File created (DailyStat_${today}.txt) \n" >> ${LOG_DIR}/${LOG_FILE}
else
        printf "Error: Execution with DataRequest_SearchIndex_Alert.sh Script \n File creation failed (DataRequest_SearchIndex_Alert_${today}.txt) \n" >> ${LOG_DIR}/${LOG_FILE}
        printf "Error: Execution with DataRequest_SearchIndex_Alert.sh Script \n File creation failed (DataRequest_SearchIndex_Alert_${today}.txt) \n" >> ${LOG_DIR}/${LOG_FILE}
        printf "FAILED with DataRequest_SearchIndex_Alert.sh Script \n" >> ${LOG_DIR}/${LOG_FILE}
        cat ${LOG_DIR}/${LOG_FILE} ${LOG_DIR}/DataRequest_SearchIndex_Alert_${today}.log > ${LOG_DIR}/DataRequest_SearchIndex_Alert2_${today}.log
        mv ${LOG_DIR}/DataRequest_SearchIndex_Alert2_${today}.log  ${LOG_DIR}/${LOG_FILE}
        #exit 1
fi

./FA_Distribution_Jobs.sh > ${LOG_DIR}/FA_Distribution_Jobs_${today}.log 2>&1
printf "time is $time \n" >> ${LOG_DIR}/${LOG_FILE}
if [[ -r DailyStat_${today}.txt ]]
then
        printf " FA_Distribution_Jobs.sh Script \n File created (DailyStat_${today}.txt) \n" >> ${LOG_DIR}/${LOG_FILE}
else
        printf "Error: Execution with FA_Distribution_Jobs.sh Script \n File creation failed (FA_Distribution_Jobs_${today}.txt) \n" >> ${LOG_DIR}/${LOG_FILE}
        printf "Error: Execution with FA_Distribution_Jobs.sh Script \n File creation failed (FA_Distribution_Jobs_${today}.txt) \n" >> ${LOG_DIR}/${LOG_FILE}
        printf "FAILED with FA_Distribution_Jobs.sh Script \n" >> ${LOG_DIR}/${LOG_FILE}
        cat ${LOG_DIR}/${LOG_FILE} ${LOG_DIR}/FA_Distribution_Jobs_${today}.log > ${LOG_DIR}/FA_Distribution_Jobs2_${today}.log
        mv ${LOG_DIR}/FA_Distribution_Jobs2_${today}.log  ${LOG_DIR}/${LOG_FILE}
        #exit 1
fi

./TJMetricsReport.sh > ${LOG_DIR}/TJMetricsReport_${today}.log 2>&1
printf "time is $time \n" >> ${LOG_DIR}/${LOG_FILE}
if [[ -r TJMetricsReport_${today}.txt ]]
then
        sed -i '1d' TJMetricsReport_${today}.txt
        printf " TJMetricsReport.sh Script \n File created (TJMetricsReport_${today}.txt) \n" >> ${LOG_DIR}/${LOG_FILE}
else
        printf "Error: Execution with TJMetricsReport.sh Script \n File creation failed (TJMetricsReport_${today}.txt) \n" >> ${LOG_DIR}/${LOG_FILE}
        printf "Error: Execution with TJMetricsReport.sh Script \n File creation failed (TJMetricsReport_${today}.txt) \n" >> ${LOG_DIR}/${LOG_FILE}
        printf "FAILED with TJMetricsReport.sh Script \n" >> ${LOG_DIR}/${LOG_FILE}
        cat ${LOG_DIR}/${LOG_FILE} ${LOG_DIR}/TJMetricsReport_${today}.log > ${LOG_DIR}/TJMetricsReport2_${today}.log
        mv ${LOG_DIR}/TJMetricsReport2_${today}.log  ${LOG_DIR}/${LOG_FILE}
        #exit 1
fi

mv TJMetricsReport_${today}.txt TJMetricsReport.txt
mv DailyStat_${today}.txt DailyStat.txt
mv FA_Distribution_${today}.txt FA_Distribution.txt
mv dataRQ_search_index_${today}.txt dataRQ_search_index.txt
mv dataRQ_alert_${today}.txt dataRQ_alert.txt
mv FA_Distribution_Jobs_${today}.txt FA_Distribution_Jobs.txt

