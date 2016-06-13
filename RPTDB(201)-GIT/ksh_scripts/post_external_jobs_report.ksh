#!/usr/bin/ksh

set +x

if [ -r $LOAD_DIR/${cur_proc}.csv ]
    then
    printf "\nFile $LOAD_DIR/crwal_jobs_report.csv ...\n"
    printf "\nFile $LOAD_DIR/crwal_jobs_report.csv ...\n" >> ${LOG_DIR}/${LOG_FILE}
else
       printf "File $LOAD_DIR/crwal_jobs_report.csv do not found.\n" >> ${LOG_DIR}/${LOG_FILE}
       printf "Error: Error in POST KSH Script Execution. EXIT Code = $exit_code \n" >> ${LOG_DIR}/${LOG_FILE}
       ${KSH_SCRIPTS_DIR}/mail $email   "$cur_proc_name - FAILED with POST KSH Script"  ${LOG_DIR}/${LOG_FILE}
       exit 1
fi

perl -pi -e 's/"//g' $LOAD_DIR/${cur_proc}.csv
echo "" > ${LOG_DIR}/${cur_proc}.txt
echo "Crwl Job Report" >> ${LOG_DIR}/${cur_proc}.txt
echo "" >> ${LOG_DIR}/${cur_proc}.txt
cat $LOAD_DIR/${cur_proc}.csv >> ${LOG_DIR}/${cur_proc}.txt
echo "" >> ${LOG_DIR}/${cur_proc}.txt
echo "" >> ${LOG_DIR}/${cur_proc}.txt
echo "Thanks" >> ${LOG_DIR}/${cur_proc}.txt
echo "RPT DB" >> ${LOG_DIR}/${cur_proc}.txt
${KSH_SCRIPTS_DIR}/mail $email "$cur_proc_name" ${LOG_DIR}/${cur_proc}.txt
rm ${LOG_DIR}/$cur_proc.txt
rm $LOAD_DIR/$cur_proc.csv
exit


