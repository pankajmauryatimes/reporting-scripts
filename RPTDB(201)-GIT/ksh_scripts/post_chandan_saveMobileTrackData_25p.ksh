#!/usr/bin/ksh

set +x

if [ -r $LOAD_DIR/chandan_saveMobileTrackData_25p_last_day.csv ]
    then
    printf "\nFile $LOAD_DIR/chandan_saveMobileTrackData_25p_last_day.csv ...\n"
    printf "\nFile $LOAD_DIR/chandan_saveMobileTrackData_25p_last_day.csv ...\n" >> ${LOG_DIR}/${LOG_FILE}
    rm /home/datareq/saveMobileTrackData/chandan_saveMobileTrackData_25p_last_day.csv
    mv $LOAD_DIR/chandan_saveMobileTrackData_25p_last_day.csv /home/datareq/saveMobileTrackData/chandan_saveMobileTrackData_25p_last_day.csv
    mv $LOAD_DIR/chandan_saveMobileTrackData_25p_last_day.csv $LOAD_DIR/chandan_saveMobileTrackData_25p_last_day_${todate}.csv
else
       printf "File $LOAD_DIR/chandan_saveMobileTrackData_25p_last_day.csv do not found.\n" >> ${LOG_DIR}/${LOG_FILE}
       printf "Error: Error in POST KSH Script Execution. EXIT Code = $exit_code \n" >> ${LOG_DIR}/${LOG_FILE}
       ${KSH_SCRIPTS_DIR}/mail $email   "$cur_proc_name - FAILED with POST KSH Script"  ${LOG_DIR}/${LOG_FILE}
       exit 1
fi
