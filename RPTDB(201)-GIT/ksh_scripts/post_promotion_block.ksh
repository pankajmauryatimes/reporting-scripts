#!/usr/bin/ksh

set +x

if [ -r $LOAD_DIR/${cur_proc}.txt ]
    then
    printf "\nFile $LOAD_DIR/${cur_proc}.txt ...\n"
    printf "\nFile $LOAD_DIR/${cur_proc}.txt ...\n" >> ${LOG_DIR}/${LOG_FILE}
    /home/datareq/generic_etl/data_files/ftp_promotion_block.ftp > /home/datareq/generic_etl/logs/ftp_promotion_block.log
    /home/datareq/generic_etl/data_files/promotion_block_adhoc.ftp > /home/datareq/generic_etl/logs/promotion_block_adhoc.log
else
       printf "File $LOAD_DIR/${cur_proc}.txt do not found.\n" >> ${LOG_DIR}/${LOG_FILE}
       printf "Error: Error in POST KSH Script Execution. EXIT Code = $exit_code \n" >> ${LOG_DIR}/${LOG_FILE}
       ${KSH_SCRIPTS_DIR}/mail $email   "$cur_proc_name - FAILED with POST KSH Script"  ${LOG_DIR}/${LOG_FILE}
       exit 1
fi

perl -pi -e 's/"//g' $LOAD_DIR/${cur_proc}.txt
mv $LOAD_DIR/${cur_proc}.txt $LOAD_DIR/${cur_proc}_${today}.txt

echo "All Files are created successfully"
