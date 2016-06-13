#!/bin/bash

set +x
echo "$(date +"%m/%d/%Y %T")"
echo "Delete DWH tables"
printf "Delete DWH tables"
#mysql -udwhuser -pdwhuser tjdwh_jobbuzz < /home/dwhuser/generic_etl/sql_scripts/jobbuzz_del.sql > /home/dwhuser/generic_etl/logs/jobbuzz_del.log  2>&1
# if [[ $exit_code != 0 ]]
 #     then
  #      printf "$(date +"%m/%d/%Y %T") :> Error post_${cur_proc}.ksh Script (Delete DWH tables). Please see log file for more information.(${LOG_DIR}/${LOG_FILE})"
   #     echo "$(date +"%m/%d/%Y %T") :> post_${cur_proc}.ksh Script Processed. Please see log file for more information." >> ${LOG_DIR}/${LOG_FILE}
    #    echo "Error: Error in POST KSH Script Execution. EXIT Code = $exit_code " >> ${LOG_DIR}/${LOG_FILE}
     #   mail -s "$cur_proc_name - FAILED with POST KSH Script" $email < ${LOG_DIR}/${LOG_FILE}
      #  exit 1
   #fi
 printf "$(date +"%m/%d/%Y %T") :> Finished Delete DWH tables ..."
printf "Directory create for the day ..."
mkdir /home/dwhuser/generic_etl/data_archive/jobbuzz/$today
printf "GZIP Flat Files"
gzip /opt/dw_data/data/jobbuzz/*.*
printf "Move Flat Files"
mv /opt/dw_data/data/jobbuzz/*.* /home/dwhuser/generic_etl/data_archive/jobbuzz/$today/

printf "=========================================Kettle Start======================================== \n "

printf "ETL =========================1_Job_Dimension_Lookup============================================= \n"
/opt/kettle/kitchen.sh -user=admin -pass=admin -rep=jobbuzz_repo -job=1_Job_Dimension_Lookup > /home/dwhuser/tjdwh/log/1_Job_Dimension_Lookup.log
s_return=`grep -i "Failure Mail" /home/dwhuser/tjdwh/log/1_Job_Dimension_Lookup.log|wc -l`
if [ $s_return -gt 0 ]
        then
                exit 0
fi
printf "ETL =========================2_Job_Dimensions============================================= \n"
/opt/kettle/kitchen.sh -user=admin -pass=admin -rep=jobbuzz_repo -job=2_Job_Dimensions > /home/dwhuser/tjdwh/log/2_Job_Dimensions.log
s_return=`grep -i "Failure Mail" /home/dwhuser/tjdwh/log/2_Job_Dimensions.log|wc -l`
if [ $s_return -gt 0 ]
        then
                exit 0
fi
printf "ETL =========================3_Job_Facts============================================= \n"
/opt/kettle/kitchen.sh -user=admin -pass=admin -rep=jobbuzz_repo -job=3_Job_Facts > /home/dwhuser/tjdwh/log/3_Job_Facts.log
s_return=`grep -i "Failure Mail" /home/dwhuser/tjdwh/log/3_Job_Facts.log|wc -l`
if [ $s_return -gt 0 ]
        then
                exit 0
fi
printf "Finished ETL Process"
