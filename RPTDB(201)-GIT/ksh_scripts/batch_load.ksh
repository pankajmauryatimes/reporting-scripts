#!/bin/ksh
set -x
################################################################################
      SCRIPT=batch_load.ksh 
#    PURPOSE: to load group of files using generic_load.ksh
# PARAMETERS: takes upto 8 programs/files to process with first parameter as the config file
#     AUTHOR: Sanjay Biswas
#       DATE: 03/11/2011
# MODIFICATION LOG:

################################################################################

USAGE="Usage: $SCRIPT CONFIG_FILE PROG1 PROG2 PROG3 PROG4 ...."

if (( $# < 2 ))
then
  echo "ERROR: Insufficient parameters supplied\n$USAGE"
  exit 1
fi

. $HOME/generic_etl/config/$1

#Check if the value of batch_proc_name is null
if [ "$batch_proc_name" == "" ]; then
      export batch_proc_name=$cur_proc
fi

# Check if the second parameter is Y ; means the file names are included in the first env file
if [ $2 = Y ]
then
i=0
while [[ ${i} -lt $totalfiles ]]; do
 currfile=${filearr[$i]}
  echo "current file is "${currfile}

  $HOME/generic_etl/ksh_scripts/generic_load.ksh $HOME/generic_etl/config/$currfile
  i=`expr $i + 1`
done

fi

# send mail on completion of batch job

if [ "$batch_send_email" == "Y" ]; then
  if [[ $email == "" ]]; then
     email=sbiswas@navisite.com
  fi
  mail -s "$batch_proc_name Process Finished " $email < $HOME/generic_etl/logs/${batch_proc_name}_dummy.txt
  ${KSH_SCRIPTS_DIR}/mail $email "$batch_proc_name Process Finished"  $HOME/generic_etl/logs/${batch_proc_name}_dummy.txt
echo " " >$HOME/generic_etl/logs/${batch_proc_name}_dummy.txt
fi
exit $exit_code

