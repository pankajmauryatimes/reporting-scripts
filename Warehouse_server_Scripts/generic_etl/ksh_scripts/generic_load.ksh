#!/bin/ksh
set -x
################################################################################
     SCRIPT=generic_load.ksh 
#    PURPOSE: to monitor for the ready file and load data into the table.
#    AUTHOR: Sanjay Biswas
#    DATE: 01/07/2011
#  MODIFICATION LOG:
#    02/03/2003 Sanjay Biswas - Added code to execute MYSQL query.
#  

################################################################################

USAGE="Usage: $SCRIPT CONFIG_FILE"

if (( $# < 1 ))
then
  printf "ERROR: Insufficient parameters supplied\n$USAGE\n" >> ${LOG_DIR}/${LOG_FILE}
  exit 1
fi

##set environment variables like MYSQL, logs etc

#Run Config File
printf "Run Config File\n" >> ${LOG_DIR}/${LOG_FILE}

CONFIG_FILE=$1
. ${CONFIG_FILE}

if [[ $? != 0 ]]
then
   printf "Error Setting up configuration\n" >> ${LOG_DIR}/${LOG_FILE}
   exit 1
fi

#Check if the value of cur_proc_name is null
if [ "$cur_proc_name" == "" ]; then
      export cur_proc_name=$cur_proc
fi

#Run PWHS Config File
printf "Run PWHS Config File\n" >> ${LOG_DIR}/${LOG_FILE}

. ${HOME}/generic_etl/config/pwhs.env

exit_code=$?
time=$(date +"%T")
printf "$cur_proc Execution time is $time \n" >> ${LOG_DIR}/${LOG_FILE}
if [[ $exit_code != 0 ]]
then
	printf "Error: Error in pwhs.env Execution with Syntax errors. EXIT Code = $exit_code \n" >> ${LOG_DIR}/${LOG_FILE}
	${KSH_SCRIPTS_DIR}/mail $email   "$cur_proc_name - FAILED with PWHS File - Execution Errors"  ${LOG_DIR}/${LOG_FILE}
	exit 1
fi

i#printf $(date) >> ${LOG_DIR}/${LOG_FILE} >> ${LOG_DIR}/${LOG_FILE}
printf "\n " >> ${LOG_DIR}/${LOG_FILE} >> ${LOG_DIR}/${LOG_FILE}


#Convert ORIG_FILE_READY to FILE_READY
printf "Convert ORIG_FILE_READY to FILE_READY \n" >> ${LOG_DIR}/${LOG_FILE}
# Populate FILE_READY value from ORIG_FILE_READY after matching the date format

if [[ $ORIG_FILE_READY != "" ]]; then
    printf "Convert ORIG_FILE_READY to FILE_READY\n" >> ${LOG_DIR}/${LOG_FILE}	
    if [[ $YES_DATE == Y ]]; then
      export FILE_READY=${LOAD_DIR}/`echo ${ORIG_FILE_READY}|sed -e s/YYYYMMDD/\`TZ=CST+24 date +%Y%m%d\`/ -e s/MMDDYYYY/\`TZ=CST+24 date +%m%d%Y\`/ -e s/YYMMDD/\`TZ=CST+24 date +%y%m%d\`/ -e s/MMDDYY/\`TZ=CST+24 date +%m%d%y\`/`
      printf "FILE_READY is:${FILE_READY}\n" >> ${LOG_DIR}/${LOG_FILE}
    else
      export FILE_READY=${LOAD_DIR}/`echo ${ORIG_FILE_READY}|sed -e s/YYYYMMDD/\`date +%Y%m%d\`/ -e s/MMDDYYYY/\`date +%m%d%Y\`/ -e s/YYMMDD/\`date +%y%m%d\`/ -e s/MMDDYY/\`date +%m%d%y\`/`
      printf "FILE_READY is:${FILE_READY}\n" >> ${LOG_DIR}/${LOG_FILE}
    fi
fi

printf "FILE_READY = $FILE_READY \n"  >> ${LOG_DIR}/${LOG_FILE}


# Busy Wait for FILE_READY
printf "Busy Wait for FILE_READY\n"
printf "Busy Wait for FILE_READY\n" >> ${LOG_DIR}/${LOG_FILE}
time=$(date +"%T")
printf "File Ready Search Time is "$time >> ${LOG_DIR}/${LOG_FILE}
printf "\ncutoff is "$cutoff >> ${LOG_DIR}/${LOG_FILE}

while [[ $time < $cutoff ]]; do
   if [ -a ${FILE_READY} ] 
   then
       printf "File found."
       printf "\nFILE_READY found.\n"  >> ${LOG_DIR}/${LOG_FILE}
       break
   else
       	if [ $time > $remind ]
	then
	     if [ $remindsent -eq 0 ]
	     then
                 printf "\nReminder Time is: $time \n"
                 printf "$cur_proc_name - CAUTION: process is still waiting for the file: ${FILE_READY}\n" >> ${LOG_DIR}/${LOG_FILE}
                 printf "\nTAKE CORRECTIVE ACTION IMMEDIATELY!!!\n" >> ${LOG_DIR}/${LOG_FILE}
                 ${KSH_SCRIPTS_DIR}/mail $email   "$cur_proc_name - WARNING"  ${LOG_DIR}/${LOG_FILE}
		 remindsent=1
	     fi
	fi
        sleep 300   #wait 5 min before checking again
        time=$(date +"%T")
        printf "time is "$time
   fi
done

# Exit out from the script whenever time > cutoff
if [[ $time > $cutoff ]]; then
   printf "FILE_READY :${FILE_READY} not found.\n"  > ${LOG_DIR}/${LOG_FILE}
   printf "Process timed out before completion!\n" >> ${LOG_DIR}/${LOG_FILE}
   printf "Data file has not been transfered!\n" >> ${LOG_DIR}/${LOG_FILE}
   ${KSH_SCRIPTS_DIR}/mail $email   "${cur_proc_name} - WARNING "  ${LOG_DIR}/${LOG_FILE}
   exit 1
fi

# Convert ORIG_FILE_NAME by date
printf "Convert ORIG_FILE_NAME by date\n" >> ${LOG_DIR}/${LOG_FILE}
if [[ $GEN_LOAD_FILE_FLAG == Y ]]
then

  if [[ $ORIG_FILE_NAME != "" ]]
  then
     printf "Convert date format in ORIG_FILE_NAME to actual date.\n"
     printf "Convert date format in ORIG_FILE_NAME to actual date.\n" >> ${LOG_DIR}/${LOG_FILE}	
       if [[ $YES_DATE == Y ]]; then
          export ORIG_FILE_NAME=${LOAD_DIR}/`echo ${ORIG_FILE_NAME}|sed -e s/YYYYMMDD/\`TZ=CST+24 date +%Y%m%d\`/ -e s/MMDDYYYY/\`TZ=CST+24 date +%m%d%Y\`/ -e s/YYMMDD/\`TZ=CST+24 date +%y%m%d\`/ -e s/MMDDYY/\`TZ=CST+24 date +%m%d%y\`/`
       else
          export ORIG_FILE_NAME=${LOAD_DIR}/`echo ${ORIG_FILE_NAME}|sed -e s/YYYYMMDD/\`date +%Y%m%d\`/ -e s/MMDDYYYY/\`date +%m%d%Y\`/ -e s/YYMMDD/\`date +%y%m%d\`/ -e s/MMDDYY/\`date +%m%d%y\`/`
       fi
  else
       printf "GEN_LOAD_FILE_FLAG is Y but ORIG_FILE_NAME is Null\n" >> ${LOG_DIR}/${LOG_FILE}
       printf "Stopped execution of current process.\n" >> ${LOG_DIR}/${LOG_FILE}
       printf "TAKE CORRECTIVE ACTION IMMEDIATELY!!!\n" >> ${LOG_DIR}/${LOG_FILE}
       ${KSH_SCRIPTS_DIR}/mail $email   "$cur_proc_name - WARNING"  ${LOG_DIR}/${LOG_FILE}
       exit 1
  fi

fi

time=$(date +"%T")
printf "time is "$time >> ${LOG_DIR}/${LOG_FILE}
printf "\ncutoff is "$cutoff >> ${LOG_DIR}/${LOG_FILE}

#PRE KSH Script part
#If there is a customized Shell, execute it
#
if [ -r ${KSH_SCRIPTS_DIR}/pre_${cur_proc}.ksh ]
    then
    printf "\nProcessing pre_${cur_proc}.ksh Script ...\n"
    printf "\nProcessing pre_${cur_proc}.ksh Script ...\n" >> ${LOG_DIR}/${LOG_FILE}
    chmod 755 ${KSH_SCRIPTS_DIR}/pre_${cur_proc}.ksh
    ${KSH_SCRIPTS_DIR}/pre_${cur_proc}.ksh >> ${LOG_DIR}/${LOG_FILE}
    exit_code=$?
    if [[ $exit_code != 0 ]]
       then
       printf "pre_${cur_proc}.ksh Script Processed. Please see log file for more information.\n" >> ${LOG_DIR}/${LOG_FILE}
       printf "Error: Error in PRE KSH Script Execution. EXIT Code = $exit_code \n" >> ${LOG_DIR}/${LOG_FILE}
       ${KSH_SCRIPTS_DIR}/mail $email   "$cur_proc_name - FAILED with PRE KSH Script"  ${LOG_DIR}/${LOG_FILE}
       exit 1
   fi
fi

if [[ $time < $cutoff ]]; then
  if [[ $LOAD_FILE != "" ]]; then
     #Found Demand Verification file#
     # Copying data files to data, wip Dirs
     printf "Copying data files to data, wip Dirs\n"
     printf "Copying data files to WIP Dirs\n" >> ${LOG_DIR}/${LOG_FILE}
     #cp ${LOAD_DIR}/${LOAD_FILE} $HOME/generic_etl/data
     cp ${LOAD_DIR}/${LOAD_FILE} $HOME/generic_etl/wip
  
     # DB Status Check
     printf "DB Status Check\n"
     #database_status=`/home/dwload/generic_etl/ksh_scripts/dbstatus $MYSQL`
     database_status=0
     while [[ $time < $cutoff ]]; do
         if [[ "$database_status" = 0 ]]
	    then
	    printf "Database status was reviewed.  DB is running.\n"
	    printf "Database status was reviewed.  DB is running.\n" >> ${LOG_DIR}/${LOG_FILE}
	    break
         else
	   sleep 300 #wait 5 min before checking the database status again
	   #database_status=`/home/dwload/generic_etl/ksh_scripts/dbstatus $MYSQL`
	   time=$(date +"%T")
	   printf "time is "$time
	   printf "\nThe database is down.  Please review the MYSQL alert log \n" >> ${LOG_DIR}/${LOG_FILE}
	   printf " " >> ${LOG_DIR}/${LOG_FILE}
	   ${KSH_SCRIPTS_DIR}/mail $email   "$cur_proc - WARNING DB is DOWN"  ${LOG_DIR}/${LOG_FILE}
         fi
     done
     
     if [[ $time > $cutoff ]]; then
          
             if [[ "$database_status" = 1 ]]
             then
                ${KSH_SCRIPTS_DIR}/mail $email   "WARNING - $cur_proc failed as the DATABASE IS DOWN"  ${LOG_DIR}/${LOG_FILE}
             fi
             printf "Process timed out before completion!\n" >> ${LOG_DIR}/${LOG_FILE}
             printf "TAKE CORRECTIVE ACTION IMMEDIATELY!!!\n" >> ${LOG_DIR}/${LOG_FILE}
             time=$(date +"%T")
             printf "time is "$time
             ${KSH_SCRIPTS_DIR}/mail $email   "$cur_proc - WARNING"  ${LOG_DIR}/${LOG_FILE}
             exit 2
     else
               # All files got transfered, Start SQL Loader step 
               if [ -r ${CTL_FILE} ]
                  then
                  cd $LOAD_DIR 
                  printf " \nStatus normal: Starting Load Process \n"
                  printf " \nStatus normal: Starting Load Process \n" >> ${LOG_DIR}/${LOG_FILE}
                  if [[ $MYSQL_USER != "" ]]; then
                     ${CONFIG_DIR}/_run_sqlldr.ksh ${MYSQL_USER} ${MYSQL_DB} ${CTL_FILE} ${LOG_DIR}/${LOG_FILE} MYSQL
                  else
                      ${CONFIG_DIR}/_run_sqlldr.ksh ${DB2_USER} ${DB2_DB} ${CTL_FILE} ${LOG_DIR}/${LOG_FILE} DB2
                  fi
                 exit_code=$? 
                 if [[ $exit_code == 127 ]] || [[ $exit_code == 3 ]] || [[ $exit_code == 1 ]]
                    then
                    time=$(date +"%T")
                    printf "time is "$time >> ${LOG_DIR}/${LOG_FILE}
                    printf "\nError: Error in SQL Load Script Execution with Syntax errors. EXIT Code = $exit_code \n" >> ${LOG_DIR}/${LOG_FILE}
                    ${KSH_SCRIPTS_DIR}/mail $email   "$cur_proc_name - FAILED with SQL Loader - Syntax Errors"  ${LOG_DIR}/${LOG_FILE}
                    exit 1
                 fi
                   # SQL Loader step complete
                   printf "\nLoad completed successfully\n"
                   printf "\nLoad completed successfully\n" >> ${LOG_DIR}/${LOG_FILE}
     	       fi 
               # move the data file from WIP to archive directory
     	       printf "\nmove the data file from WIP to archive directory\n"
     	       mv $HOME/generic_etl/wip/${LOAD_FILE} $HOME/generic_etl/data_archive/${LOAD_FILE}.${now}
	 
	       #SQL file part
	       #If there is a SQL script, process it
	       #
	       # Exit out from the script whenever time > cutoff
	       if [[ $time < $cutoff ]]; then
	  	  
	  	    if [ -r ${SQL_FILE} ]
	  	    then
	  	           printf "\nProcessing SQL Script ...\n"
	  	           printf "\nProcessing SQL Script ...\n" >> ${LOG_DIR}/${LOG_FILE}
	  	           if [[ $MYSQL_USER != "" ]]; then
                              ${CONFIG_DIR}/_run_sql.ksh ${MYSQL_USER} ${MYSQL_DB} ${SQL_FILE} ${LOG_DIR}/${LOG_FILE} MYSQL
                           else
                              ${CONFIG_DIR}/_run_sql.ksh ${DB2_USER} ${DB2_DB} ${SQL_FILE} ${LOG_DIR}/${LOG_FILE} DB2
                           fi
	  	           exit_code=$?
	  	  
	  	           if [[ $exit_code != 0 ]]
	  	           then
	  	               printf "SQL Script Processed. Please see log file for more information.\n" >> ${LOG_DIR}/${LOG_FILE}
	  	               printf "Error: Error in SQL Script Execution. EXIT Code = $exit_code \n" >> ${LOG_DIR}/${LOG_FILE}
	  	               ${KSH_SCRIPTS_DIR}/mail $email   "$cur_proc_name - FAILED with SQL Script"  ${LOG_DIR}/${LOG_FILE}
	  	               exit 1
	  	           fi
	  	    fi
	  	    printf "Processed SQL Script ...\n" >> ${LOG_DIR}/${LOG_FILE}
	  	     
                    #KETTLE (ETL TOOL)
                    i=0
                    if [[ ${ktl_jobarr[$i]} != "" ]]; then
                         printf "Loading with Kettle ..."
                         printf "Loading with Kettle ..."  >> ${LOG_DIR}/${LOG_FILE}
                         while [[ ${i} -lt $ktl_totaljobs ]]; do
                                printf "Job :" ${ktl_jobarr[$i]}
                                printf "Job :" ${ktl_jobarr[$i]} >> ${LOG_DIR}/${LOG_FILE}
                                if [[ ${ktl_version} -eq 5 ]]
                                then
                                     ${CONFIG_DIR}/_run_kettle_v5.ksh ${ktl_rep} ${ktl_jobarr[$i]} ${LOG_DIR}/${LOG_FILE}
                                else
                                     ${CONFIG_DIR}/_run_kettle.ksh ${ktl_rep} ${ktl_jobarr[$i]} ${LOG_DIR}/${LOG_FILE}
                                fi
                                exit_code=$?
                                if [[ $exit_code != 0 ]]
                                then
                                    ${KSH_SCRIPTS_DIR}/mail $email "$cur_proc_name - FAILED with Kettle Execution" $HOME/generic_etl/logs/${ktl_jobarr[$i]}_${nowd}.log
                                    exit 1
                                fi
                                i=`expr $i + 1`
                         done
                     fi
	  	     printf "KETTLE Finished Successfully"
                     printf "KETTLE Finished Successfully"  >> ${LOG_DIR}/${LOG_FILE}
                     #POST KSH Script part
	  	     #If there is a customized Shell, execute it
	  	     #
	  	     if [ -r ${KSH_SCRIPTS_DIR}/post_${cur_proc}.ksh ]
	  	     then
	  	          printf "Processing post_${cur_proc}.ksh Script ...\n" >> ${LOG_DIR}/${LOG_FILE} 
	  	          printf "Processing post_${cur_proc}.ksh Script ...\n" >> ${LOG_DIR}/${LOG_FILE}
	  	          chmod 755 ${KSH_SCRIPTS_DIR}/post_${cur_proc}.ksh
	  	          ${KSH_SCRIPTS_DIR}/post_${cur_proc}.ksh >> ${LOG_DIR}/${LOG_FILE}
	  	          exit_code=$?
	  	          if [[ $exit_code != 0 ]]
	  	          then
	  	             printf "post_${cur_proc}.ksh Script Processed. Please see log file for more information.\n" >> ${LOG_DIR}/${LOG_FILE}
	  	             printf "Error: Error in POST KSH Script Execution. EXIT Code = $exit_code \n" >> ${LOG_DIR}/${LOG_FILE}
	  	             ${KSH_SCRIPTS_DIR}/mail $email   "$cur_proc_name - FAILED with POST KSH Script"  ${LOG_DIR}/${LOG_FILE}
	  	             exit 1
	  	          fi
	             fi
	 
	       else
		   	       printf "Process timed out before completion!\n" >> ${LOG_DIR}/${LOG_FILE}
		   	       printf "Task: Processing SQL Script not complete.\n" >> ${LOG_DIR}/${LOG_FILE}
		   	       ${KSH_SCRIPTS_DIR}/mail $email   "$cur_proc - WARNING "  ${LOG_DIR}/${LOG_FILE}
		   	       exit 1
	       fi
               if [ $CUR_PROC_FTP_SWITCH == Y ]; then
                    cd ${LOAD_DIR}
		    ftp_file=${LOAD_DIR}/${cur_proc}.ftp
		    echo "#!/bin/ksh" > $ftp_file
		    echo "HOST=$ip" >> $ftp_file
		    echo "USER=$user" >> $ftp_file
		    echo "PASSWD=$pswd" >> $ftp_file
		    echo "ftp -in \$HOST <<EOF" >> $ftp_file
		    echo "quote USER \$USER" >> $ftp_file
		    echo "quote PASS \$PASSWD" >> $ftp_file
		    echo "binary" >> $ftp_file
		    echo "cd $ftp_dir" >> $ftp_file
		    echo "pwd" >> $ftp_file
		    i=0
		    if [[ ${filearr[$i]} != "" ]]; then
			 while [[ ${i} -lt $totalfiles ]]; do
			       echo "put ${filearr[$i]}" >> $ftp_file
			       i=`expr $i + 1`
			 done
		    fi
		    echo "put ${LOAD_FILE}" >> $ftp_file
		    echo "quit" >> $ftp_file
		    echo "EOF" >> $ftp_file
                     ftp_file=${LOAD_DIR}/${cur_proc}.ftp
		    #execute FTP script
		    chmod 755 ${ftp_file}
		    ${ftp_file}
                    break
		    exit_code=$?
		    time=$(date +"%T")
		    printf "time is "$time >> ${LOG_DIR}/${LOG_FILE}
		    if [[ $exit_code != 0 ]]
		    then
		      printf "Error: Error in FTP Script during Execution. EXIT Code = $exit_code " >> ${LOG_DIR}/${LOG_FILE}
		      ${KSH_SCRIPTS_DIR}/mail $email   "$cur_proc_name - WARNING :Syntax Errors"  ${LOG_DIR}/${LOG_FILE}
		      exit 1
		   fi
	       fi
     fi

  else
     # LOAD_FILE is null, SQL Loader step skipped. 
     
     printf "LOAD_FILE is null!\n" >> ${LOG_DIR}/${LOG_FILE}
     printf "SQL Loader step skipped.\n" >> ${LOG_DIR}/${LOG_FILE}
             
  fi       
  printf "Processed post_${cur_proc}.ksh Script ...\n"
  printf "Processed post_${cur_proc}.ksh Script ...\n"  >> ${LOG_DIR}/${LOG_FILE} 
 
  # add job finish status to log file for batch jobs
  	  
  if [ "$batch_send_email" == "Y" ]; then
      printf "add job finish status to log file for batch jobs\n"  >> ${LOG_DIR}/${LOG_FILE}
      send_mail="N"
      echo "$cur_proc_name Job Finished at `date  +%m/%d/%Y-%H:%M:%S` \n" >> $HOME/generic_etl/logs/${batch_proc_name}_dummy.txt
  fi
  	  
  # send mail on completion of independent job
   
  if [ "$send_mail" == "Y" ]; then
     printf "send mail on completion of independent job\n"  >> ${LOG_DIR}/${LOG_FILE}
     echo $cur_proc_name Job Finished at `date  +%m/%d/%Y-%H:%M:%S` > $HOME/generic_etl/logs/dummy.txt
     if [[ $email == "" ]]; then
         email=sanjay.biswas@timesgroup.com
     fi
     if [[ $smail == "" ]]; then
         smail=${email}
     fi
     ${KSH_SCRIPTS_DIR}/mail $smail "$cur_proc_name Process Finished Successfully. " $HOME/generic_etl/logs/dummy.txt
     echo " " >$HOME/generic_etl/logs/dummy.txt
  fi
  touch /home/dwhuser/generic_etl/job_complete/${cur_proc}_${today}.done
fi

if [[ $time > $cutoff ]]; then
   printf "Process timed out before completion!\n" >> ${LOG_DIR}/${LOG_FILE}
   printf "Data file has not been transfered!\n" >> ${LOG_DIR}/${LOG_FILE}
   ${KSH_SCRIPTS_DIR}/mail $email   "$cur_proc - WARNING "  ${LOG_DIR}/${LOG_FILE}
   exit 1
fi

exit $exit_code

