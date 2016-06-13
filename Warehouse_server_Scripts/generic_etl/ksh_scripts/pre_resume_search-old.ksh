#!/bin/ksh

set +x
#export Stat_date=`date +%Y%m%d`
#export Log_date=`date --date="1 day ago" +%Y-%m-%d`
export totalfiles=6
set -A filearr2 DailyStat.txt SearchLogStat.txt
export filearr2

cd /home/dwhuser/generic_etl/data_files/resume_daily_stat/scripts/
./ResumeDailyStat.sh > ${LOG_DIR}/ResumeDailyStat_${Stat_date}.log 2>&1
time=$(date +"%T")
printf "time is $time \n" >> ${LOG_DIR}/${LOG_FILE}
if [[ -r DailyStat_${Stat_date}.txt ]]
then
        printf " ResumeDailyStat.sh Script \n File created (DailyStat_${Stat_date}.txt) \n" >> ${LOG_DIR}/${LOG_FILE}
else
	printf "Error: Execution with ResumeDailyStat.sh Script \n File creation failed (DailyStat_${Stat_date}.txt) \n" >> ${LOG_DIR}/${LOG_FILE}
        printf "Error: Execution with ResumeDailyStat.sh Script \n File creation failed (DailyStat_${Stat_date}.txt) \n" >> ${LOG_DIR}/${LOG_FILE}
        printf "FAILED with ResumeDailyStat.sh Script \n" >> ${LOG_DIR}/${LOG_FILE}
        cat ${LOG_DIR}/${LOG_FILE} ${LOG_DIR}/ResumeDailyStat_${Stat_date}.log > ${LOG_DIR}/ResumeDailyStat2_${Stat_date}.log
        mv ${LOG_DIR}/ResumeDailyStat2_${Stat_date}.log  ${LOG_DIR}/${LOG_FILE}
	exit 1
fi

cd /home/dwhuser/generic_etl/data_files/resume_search_log/
./LogAnalysis.sh > ${LOG_DIR}/LogAnalysis_${Stat_date}.log 2>&1
time=$(date +"%T")
printf "time is $time \n" >> ${LOG_DIR}/${LOG_FILE}
if [[ -r SearchLogStat_${Log_date}.txt ]]
then
        printf "LogAnalysis.sh Script \n File created (SearchLogStat_${Log_date}.txt) \n" >> ${LOG_DIR}/${LOG_FILE}
else
        printf "Error: Execution with LogAnalysis.sh Script \n File creation failed (SearchLogStat_${Log_date}.txt) \n" >> ${LOG_DIR}/${LOG_FILE}
        printf "Error: Execution with LogAnalysis.sh Script \n File creation failed (SearchLogStat_${Log_date}.txt) \n" >> ${LOG_DIR}/${LOG_FILE}
        printf "FAILED with LogAnalysis.sh Script \n" >> ${LOG_DIR}/LogAnalysis_${Stat_date}.log
        cat ${LOG_DIR}/${LOG_FILE} ${LOG_DIR}/LogAnalysis_${Stat_date}.log > ${LOG_DIR}/LogAnalysis2_${Stat_date}.log
        mv ${LOG_DIR}/LogAnalysis2_${Stat_date}.log ${LOG_DIR}/${LOG_FILE}
        exit 1
fi

cp /home/dwhuser/generic_etl/data_files/resume_daily_stat/scripts/DailyStat_${Stat_date}.txt /home/dwhuser/generic_etl/data_archive/
cp /home/dwhuser/generic_etl/data_files/resume_search_log/SearchLogStat_${Log_date}.txt /home/dwhuser/generic_etl/data_archive/
mv /home/dwhuser/generic_etl/data_files/resume_daily_stat/scripts/DailyStat_${Stat_date}.txt /home/dwhuser/generic_etl/wip/DailyStat.txt
mv /home/dwhuser/generic_etl/data_files/resume_search_log/SearchLogStat_${Log_date}.txt /home/dwhuser/generic_etl/wip/SearchLogStat.txt

time=$(date +"%T")
cd /home/dwhuser/generic_etl/wip
i=0
while [[ ${i} -lt $totalfiles ]]; do
      currfile=${filearr2[$i]}
      echo "current file is "${currfile}
      printf "current file is ${currfile}"
      time=$(date +"%T")
      if [ -r /home/dwhuser/generic_etl/wip/$currfile ]
      then
          #Found all the data files#
          printf "$currfile found"
          i=`expr $i + 1`
      else
      #Send a reminder
          if [ $time > $remind ]
          then
              if [ $remindsent -eq 0 ]
              then
              ${KSH_SCRIPTS_DIR}/mail $email "CAUTION: $cur_proc_name process is still waiting for the file: $currfile"  ${LOG_DIR}/${cur_proc}.cron
              remindsent=1
              fi
          fi
          print "waiting for all files to be available for $currfile2"
          sleep 300   #wait 5 min before checking again
          time=$(date +"%T")
          printf "time is "$time
          printf "\n"
      fi
      if [[ $time > $cutoff ]]; then
          printf "$currfile not found.\n"  >> ${LOG_DIR}/${cur_proc}.cron
          printf "Process timed out before completion!\n" >> ${LOG_DIR}/${cur_proc}.cron
          printf "Data file has not been transfered!\n" >> ${LOG_DIR}/${cur_proc}.cron
          ${KSH_SCRIPTS_DIR}/mail $email   "$cur_proc_name - WARNING "  ${LOG_DIR}/${cur_proc}.cron
         exit 1
      fi
done

