#!/usr/bin/ksh

set +x

export now=`date +%Y-%m-%d' '%H:%M:%S`
cd $LOAD_DIR

if [ -r $LOAD_DIR/mobile_parameter_report.csv ]
    then
    printf "\nFile $LOAD_DIR/post_mobile_parameter_report.csv ...\n"
    printf "\nFile $LOAD_DIR/post_mobile_parameter_report.csv ...\n" >> ${LOAD_DIR}/${LOG_FILE}
else
       printf "File $LOAD_DIR/post_mobile_parameter_report.csv do not found.\n" >> ${LOAD_DIR}/${LOG_FILE}
       printf "Error: Error in POST KSH Script Execution. EXIT Code = $exit_code \n" >> ${LOAD_DIR}/${LOG_FILE}
       ${KSH_SCRIPTS_DIR}/mail $email   "$cur_proc_name - FAILED with POST KSH Script"  ${LOAD_DIR}/${LOG_FILE}
       exit 1
fi

#mv $LOAD_DIR/mobile_parameter.csv $LOAD_DIR/mobile_parameter_${todate}.csv

perl -pi -e 's/"//g' ${LOAD_DIR}/mobile_parameter_report.csv
echo "TITLE                            LOGIN_TYPE    COUNTS" > ${LOAD_DIR}/${cur_proc}_2.txt
echo "--------------------------       ----------    -------" >> ${LOAD_DIR}/${cur_proc}_2.txt
cat ${LOAD_DIR}/${cur_proc}_2.txt ${LOAD_DIR}/mobile_parameter_report.csv > ${LOAD_DIR}/${cur_proc}_3.txt

${KSH_SCRIPTS_DIR}/mail $email   "$cur_proc_name -Time: $now"  ${LOAD_DIR}/${cur_proc}_3.txt
rm -f ${LOAD_DIR}/${cur_proc}_3.txt ${LOAD_DIR}/${cur_proc}_2.txt

echo "All Files are created successfully"
