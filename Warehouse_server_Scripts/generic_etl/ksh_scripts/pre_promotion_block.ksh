#!/bin/ksh

set +x

rm /home/dwhuser/generic_etl/sql_scripts/${cur_proc}.sql
sort /home/dwhuser/generic_etl/wip/${cur_proc}_${today}.txt | uniq > /home/dwhuser/generic_etl/sql_scripts/${cur_proc}.sql
cp /home/dwhuser/generic_etl/sql_scripts/${cur_proc}.sql  /home/dwhuser/generic_etl/data_archive/${cur_proc}_${today}.txt
#cp /home/dwhuser/generic_etl/wip/${cur_proc}_${today}.txt /home/dwhuser/generic_etl/sql_scripts/${cur_proc}.sql
if [[ -r /home/dwhuser/generic_etl/sql_scripts/${cur_proc}.sql ]]
then
    printf "\n SQL Script Found \n" >> ${LOG_DIR}/${LOG_FILE}
    echo "SQL Script Found \n"
else
   printf "\n SQL FILE NOT FOUND FOR EXECUTION \n" >> ${LOG_DIR}/${LOG_FILE}
   exit 1
fi

rm -f $FILE_READY
