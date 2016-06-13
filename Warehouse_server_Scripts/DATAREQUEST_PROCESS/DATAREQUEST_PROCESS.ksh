#!/usr/bin/ksh

set +x

export HOME=/home/dwhuser
export now=`date +%m%d%Y-%H%M%S`
#export KSH_SCRIPTS_DIR=${HOME}/generic_etl/ksh_scripts
export mail=$HOME/DATAREQUEST_PROCESS/mail
export e_email=tjbi@timesgroup.com
export s_email=tjbi@timesgroup.com,pravesh.suyal@timesgroup.com
time=$(date +"%T")
start_tm=$(date +"%m%d%Y-%H%M%S")

export DIR_SOLAR_FILE=$HOME/DATAREQUEST_PROCESS/SolarProject/files
export SQL_LOG=/tmp
export EMAIL_REP=$HOME/DATAREQUEST_PROCESS/log/email_rep.dmp
export CURR_DIR=$HOME/DATAREQUEST_PROCESS
export e_email=tjbi@timesgroup.com

printf "Checking for Solar Process already running or not" > $HOME/DATAREQUEST_PROCESS/log/DATAREQ_PROCESSOR_${start_tm}.log
printf "Checking for Solar Process already running or not"

time=$(date +"%T") 
printf "\n time is "$time >> $HOME/DATAREQUEST_PROCESS/log/DATAREQ_PROCESSOR_${start_tm}.log
printf "\n time is "$time

run_proc_flag=0
proc_flag=1
cut_off=0
while [[ $run_proc_flag < $proc_flag ]]; do
solar_proc=$(ps -ef | grep 'DB_PROCESS.ksh' | grep '/home/dwhuser')

if [[ $solar_proc == '' ]]
then
   printf "\n Process Not Running\n" >> $HOME/DATAREQUEST_PROCESS/log/DATAREQ_PROCESSOR_${start_tm}.log
   printf "\n Process Not Running\n" 
   proc_flag=0
   break
else
   printf "\n DATAREQUEST Process Running and now waiting for 5 minuts ....\n" >> $HOME/DATAREQUEST_PROCESS/log/DATAREQ_PROCESSOR_${start_tm}.log
   printf "\n DATAREQUEST Process Running and now waiting for 5 minuts ....\n"

   time=$(date +"%T")
   printf "\ntime is "$time >> $HOME/DATAREQUEST_PROCESS/log/DATAREQ_PROCESSOR_${start_tm}.log
   sleep 300   #wait 5(300 sec.) min before checking again
   proc_flag=1
fi
 cut_off=$(expr $cut_off + 1)
 if [[ $cut_off > 3 ]]
 then
     printf "\n Process has been terminate as per the cut off time (30 minuts waiting)\n" >> $HOME/DATAREQUEST_PROCESS/log/DATAREQ_PROCESSOR_${start_tm}.log
     printf "\n Process has been terminate as per the cut off time (30 minuts waiting)\n"

     time=$(date +"%T")
     printf "\ntime is "$time >> $HOME/DATAREQUEST_PROCESS/log/DATAREQ_PROCESSOR_${start_tm}.log
     exit
 fi
done

echo "DATAREQ Execution Begin ..." >> $HOME/DATAREQUEST_PROCESS/log/DATAREQ_PROCESSOR_${start_tm}.log
end_tm=${start_tm}_$(date +"%H%M%S")

$HOME/DATAREQUEST_PROCESS/DB_PROCESS.ksh >> $HOME/DATAREQUEST_PROCESS/log/DATAREQ_PROCESSOR_${start_tm}.log 2>&1

mv $HOME/DATAREQUEST_PROCESS/log/DATAREQ_PROCESSOR_${start_tm}.log $HOME/DATAREQUEST_PROCESS/log/DATAREQ_PROCESSOR_${end_tm}.log
exit
