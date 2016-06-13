#!/bin/ksh

set +x

export HOME=/home/dwhuser
export now=`date +%m%d%Y-%H%M%S`
#export KSH_SCRIPTS_DIR=${HOME}/generic_etl/ksh_scripts
export mail=$HOME/DATAREQUEST_PROCESS/mail
export e_email=tjbi@timesgroup.com
export s_email=tjbi@timesgroup.com,pravesh.suyal@timesgroup.com
export log_dir=/home/dwhuser/DATAREQUEST_PROCESS/log
tm=$now
export log_file=solar_execution_$tm.log

echo "$tm"
echo "Checking for Solar Process already running or not" > $log_dir/$log_file
time=$(date +"%T") >> $log_dir/$log_file
printf "\n time is "$time >> $log_dir/$log_file

cd $HOME/DATAREQUEST_PROCESS/SolarProject
run_proc_flag=0
proc_flag=1
cut_off=0
while [[ $run_proc_flag < $proc_flag ]]; do
solar_proc=$(ps -ef | grep java | grep '/SolarProject/')

if [[ $solar_proc == '' ]]
then
   printf "\n Process Not Running\n" >> $log_dir/$log_file
   printf "\n Process Not Running\n"
   proc_flag=0
   break
else
   printf "\n SOLAR Process Running and now waiting for 5 minuts ....\n" >> $log_dir/$log_file
   printf "\n SOLAR Process Running and now waiting for 5 minuts ....\n"
   time=$(date +"%T")
   printf "\ntime is "$time >> $log_dir/$log_file
   sleep 300   #wait 5(300 sec.) min before checking again
   proc_flag=1
fi
 cut_off=$(expr $cut_off + 1)
 if [[ $cut_off > 7 ]]
 then
     printf "\n Process has been terminate as per the cut off time (30 minuts waiting)\n" >> $log_dir/$log_file
     printf "\n Process has been terminate as per the cut off time (30 minuts waiting)\n"
     time=$(date +"%T")
     printf "\ntime is "$time >> $log_dir/$log_file
     exit
 fi
done

echo "SOLAR Execution Begin ..." >> $log_dir/$log_file
echo "SOLAR Execution Begin ..."
start_tm=$(date +"%T")

./solr_execution.sh > $HOME/DATAREQUEST_PROCESS/log/solr_execution_${now}.log 2>&1

if [[ $? != 0 ]]
then
   printf "\n Error Setting up configuration in SOLAR INDEX \n" >> $log_dir/$log_file
   printf "\n Error Setting up configuration in SOLAR INDEX \n"
   #${KSH_SCRIPTS_DIR}/mail $s_email "Error - SOLAR INDEX for Data Rrequest process }" $HOME/DATAREQUEST_PROCESS/log/solr_execution_${now}.log 
   mail $s_email "Error - SOLAR INDEX for Data Rrequest process }" $HOME/DATAREQUEST_PROCESS/log/solr_execution_${now}.log 
   end_now=`date +%H%M%S`
   tm=${tm}_${end_now}
   printf "\n Process Terminate with error. \n" >> $log_dir/$log_file
   exit 1
else
  printf "\n Executed Successfully. \n" >> $log_dir/$log_file
fi

end_now=`date +%H%M%S`
tm=${tm}_${end_now}
printf "\n Process Compeleted Successfully. \n" >> $log_dir/$log_file
exit

