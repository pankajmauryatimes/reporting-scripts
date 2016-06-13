#!/bin/bash

CONFIG_FILE=$1
echo " Env file begin"
. ${CONFIG_FILE}
echo "PWHS begin"
. ${HOME}/generic_etl/config/pwhs.env
{LOG_DIR}/${LOG_FILE}
echo " " >> ${LOG_DIR}/${LOG_FILE}

if [ -r ${KSH_SCRIPTS_DIR}/post_${cur_proc}.ksh ]
   then
   echo "$(date +"%m/%d/%Y %T") :> Processing post_${cur_proc}.ksh Script ..."
   echo "LOG_FILE $LOG_FILE" 
   echo "$(date +"%m/%d/%Y %T") :> Processing post_${cur_proc}.ksh Script ..." >> ${LOG_DIR}/${LOG_FILE}
   chmod 755 ${KSH_SCRIPTS_DIR}/post_${cur_proc}.ksh
   echo "exit_code $? " 
   . ${KSH_SCRIPTS_DIR}/post_${cur_proc}.ksh >> ${LOG_DIR}/${LOG_FILE}
   exit_code=$?
   if [[ $exit_code != 0 ]]
      then
	echo "$(date +"%m/%d/%Y %T") :> post_${cur_proc}.ksh Script Processed. Please see log file for more information." >> ${LOG_DIR}/${LOG_FILE}
	echo "Error: Error in POST KSH Script Execution. EXIT Code = $exit_code " >> ${LOG_DIR}/${LOG_FILE}
	mail -s "$cur_proc_name - FAILED with POST KSH Script" $email < ${LOG_DIR}/${LOG_FILE}
	exit 1
   fi
   echo "$(date +"%m/%d/%Y %T") :> Finished post_${cur_proc}.ksh Script ..."
fi

#Move Flat File to Archive 
if [[ $LOAD_FILE != "" ]]
  then
    mv $LOAD_DIR/$LOAD_FILE $HOME/generic_etl/data_archive/$LOAD_FILE.${now}
fi

if [ "$send_mail" == "Y" ]; then
     echo "send mail on completion of independent job"
     echo $cur_proc_name Job Finished at `date  +%m/%d/%Y-%H:%M:%S` > $HOME/generic_etl/logs/dummy.txt
     if [[ $email == "" ]]; then
         email=sanjay.biswas@timesgroup.com
     fi
     perl /home/dwhuser/generic_etl/config/mail.pl T
     mail -s "$cur_proc_name Process Finished " $email < $HOME/generic_etl/logs/dummy.txt
     echo " " >$HOME/generic_etl/logs/dummy.txt
  fi
  tm=$(date +"%d%m%Y")
  echo $tm
  touch ${HOME}/generic_etl/job_complete/${cur_proc}_${tm}.done
echo "Process has been completed"
exit 1 
