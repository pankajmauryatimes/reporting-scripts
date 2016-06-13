#!/usr/bin/ksh

set +x

if [ -r $LOAD_DIR/candidate_transaction_LIVE.csv ]
    then
    printf "\nFile $LOAD_DIR/candidate_transaction_LIVE.csv ...\n"
    printf "\nFile $LOAD_DIR/candidate_transaction_LIVE.csv ...\n" >> ${LOG_DIR}/${LOG_FILE}
else
       printf "File $LOAD_DIR/candidate_transaction_LIVE.csv do not found.\n" >> ${LOG_DIR}/${LOG_FILE}
       printf "Error: Error in POST KSH Script Execution. EXIT Code = $exit_code \n" >> ${LOG_DIR}/${LOG_FILE}
       ${KSH_SCRIPTS_DIR}/mail $email   "$cur_proc_name - FAILED with POST KSH Script"  ${LOG_DIR}/${LOG_FILE}
       exit 1
fi

if [ -r $LOAD_DIR/web_trend.csv ]
    then
    printf "\nFile $LOAD_DIR/web_trend.csv ...\n"
    printf "\nFile $LOAD_DIR/web_trend.csv ...\n" >> ${LOG_DIR}/${LOG_FILE}
else
       printf "File $LOAD_DIR/web_trend.csv do not found.\n" >> ${LOG_DIR}/${LOG_FILE}
       printf "Error: Error in POST KSH Script Execution. EXIT Code = $exit_code \n" >> ${LOG_DIR}/${LOG_FILE}
       ${KSH_SCRIPTS_DIR}/mail $email   "$cur_proc_name - FAILED with POST KSH Script"  ${LOG_DIR}/${LOG_FILE}
       exit 1
fi

mv $LOAD_DIR/candidate_transaction_LIVE.csv $LOAD_DIR/candidate_transaction_LIVE_${todate}.csv
mv $LOAD_DIR/web_trend.csv $LOAD_DIR/web_trend_${todate}.csv

echo "All Files are created successfully"
