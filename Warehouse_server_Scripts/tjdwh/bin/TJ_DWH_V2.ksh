#!/bin/bash

set +x

date

export DATA_FILES=/opt/dw_data
export DATA_FILES_CAND=/opt/dw_data/data/cand_ixf
export DATA_FILES_CORP=/opt/dw_data/data/corp_ixf
export cutoff=21:50:00
export remind=11:00:00
export remindsent=0
export KSH_SCRIPTS_DIR=${HOME}/generic_etl/ksh_scripts
export LOG_FILE=$HOME/tjdwh/log/tj_dwh.mail
export email=saints@timesgroup.com,tjbi@timesgroup.com
export TODAY=$(date +'%d%b%Y')

NUM_RETRIES=96
TRIAL_NUM=1
FILE_CHECK_FLAG=0
FILE_CHECK_FLAG=0
COUNT=99
COUNT_CORP=99
FILE_CHECK_FLAG=0
FILE_CHECK_FLAG_1=0
printf "========================= Warehouse Script Begin ================================\n"
echo "DateTime: $(date +'%d%b%y-%T')"
printf "Checking the files in the directory\n"

##### Check whether the the files are present in the directory or not in 8 attempts #####

while [ $NUM_RETRIES -gt $TRIAL_NUM ]
do
echo "DateTime: $(date +'%d%b%y-%T')"

COUNT=$(ls -al  $DATA_FILES_CAND/ --time-style=+%D | grep $(date +%D) |grep '.ixf' | wc -l)
if [ $COUNT -eq 35 ]
then
        FILE_CHECK_FLAG=0
else
        printf "Files not found in the Canddidate Directory\n"
        printf "\n===========================================================================================\n"
        FILE_CHECK_FLAG=1
         /home/dwhuser/tjdwh/bin/mail.pl F > /dev/null
fi

COUNT_CORP=$(ls -al  $DATA_FILES_CORP/ --time-style=+%D | grep $(date +%D) |grep '.ixf' | wc -l)
if [ $COUNT_CORP -gt 21 ]
then
        FILE_CHECK_FLAG_1=0
else
        printf "\nFiles not found in the Corporate Directory"
        printf "\n===========================================================================================\n"
        FILE_CHECK_FLAG_1=1
         /home/dwhuser/tjdwh/bin/mail.pl F > /dev/null
fi

printf "\nFILE_CHECK_FLAG: $FILE_CHECK_FLAG \n"
printf "\nFILE_CHECK_FLAG_1: $FILE_CHECK_FLAG_1 \n"

if [[ $FILE_CHECK_FLAG -gt 0 ]] || [[ $FILE_CHECK_FLAG_1 -gt 0 ]]
then
 time=$(date +"%T")
 printf "time is "$time
 if [[ $time > $cutoff ]]; then
   printf "Process timed out before completion!\n" > ${LOG_FILE}
   printf "Data file has not been transfered!\n" >> ${LOG_FILE}
   mail_dby=$(cat ${LOG_FILE})
   ${KSH_SCRIPTS_DIR}/mail $email   "Warehouse Process timed out before completion! " "${mail_dby}"
   exit 1
 fi
printf "===========================================================================================\n"
printf "Files Not Found $TRIAL_NUM \n"
printf "=============================SLEEP FOR 10 MINS=============================================\n"

printf "Hi Team,\n\n" > ${LOG_FILE}
printf "Data file has not been transfered!\n" >> ${LOG_FILE}
printf "Take Corrective Action Immediately. \n" >> ${LOG_FILE}
w_mail_dby=$(cat ${LOG_FILE})
${KSH_SCRIPTS_DIR}/mail $email   "Warning: IXF Files Not Found for Warehouse Process." "${w_mail_dby}"

sleep 600
fi

TRIAL_NUM=`expr $TRIAL_NUM + 1`

printf "\n  TRIAL_NUM: $TRIAL_NUM \n"
echo "DateTime: $(date +'%d%b%y-%T')"

if [[ $FILE_CHECK_FLAG -eq 0 ]] && [[ $FILE_CHECK_FLAG_1 -eq 0 ]]
then
printf " \n"
printf "\n============================Break======================================================== \n"
break;
fi
done

if [[ $FILE_CHECK_FLAG -gt 0 ]] || [[ $FILE_CHECK_FLAG_1 -gt 0 ]]
then

printf "===========================================================================================\n"
printf "Terminating load process as files not found in one of respective directory \n"
printf "===========================================================================================\n"
echo $(date +'%d%b%y-%T')

/home/dwhuser/tjdwh/bin/mail.pl F > /dev/null
exit 0

fi

######################## Ensure all mandatory params are entered #####################################################
#IXF Files Found.
printf "IXF files found for DWH.\n" > ${LOG_FILE}
printf "All files are available for CAND and CORP \n" >> ${LOG_FILE}
mail_bdy=$(cat ${LOG_FILE})
${KSH_SCRIPTS_DIR}/mail $email "IXF Files Successfully Transferred on Warehouse Server." ${mail_bdy}

echo ""
printf "*** Login Server 172.16.85.205 (DB2 STAGING SERVER) for Loading IXF file ****\n "
printf "Truncate Start \n"
echo "DateTime: $(date +'%d%b%y-%T')"
/home/dwhuser/tjdwh/bin/DB2stagingServer.csh > /home/dwhuser/tjdwh/log/DB2stagingServer_${TODAY}.log
s_return=`grep -i "DB2 SQL error:" /home/dwhuser/tjdwh/log/trunc.log|wc -l`
s_return1=`grep -i "command not found" /home/dwhuser/tjdwh/log/trunc.log|wc -l`
mv /home/dwhuser/tjdwh/log/trunc.log /home/dwhuser/tjdwh/log/trunc_$(date +'%d%b%y').log

echo "$(cat /home/dwhuser/tjdwh/log/DB2stagingServer.log)"

if [[ "$s_return" -gt "0" ]] || [[ "$s_return1" -gt 0 ]]
        then
                /home/dwhuser/tjdwh/bin/mail.pl F > /dev/null
                exit 0
fi

echo "Logout 172.16.85.205( dwhuser)"
echo "DateTime: $(date +'%d%b%y-%T')"
echo ""

d1=$(date +'%d%b%y')
printf "File Copy to the respective Directory Start \n "
echo "DateTime: $(date +'%d%b%y-%T')"

mkdir $DATA_FILES/$d1
mkdir $DATA_FILES/$d1/corp_ixf
mkdir $DATA_FILES/$d1/cand_ixf
gzip $DATA_FILES_CORP/*
gzip $DATA_FILES_CAND/*

printf "Data Files Zipping Done..........going to Archive these files \n"
mv $DATA_FILES_CORP/* $DATA_FILES/$d1/corp_ixf/
mv $DATA_FILES_CAND/* $DATA_FILES/$d1/cand_ixf/

printf "Archived completed \n"
echo "DateTime: $(date +'%d%b%y-%T')"


printf "==================Kettle Start================ \n "
printf "	******** Deletion Start ******** \n"
printf "Delete Start from Resume Fact and Job Fact \n"
echo "DataTime: $(date +'%d%b%y-%T')"
tm=$(date +'%d%b%y-%T')

/opt/data-integration/kitchen.sh -user=admin -pass=admin -rep=dwh_repo -job=job_delete_jobs_and_resumes > /home/dwhuser/tjdwh/log/kettle_delete_jobs_and_resumes_${TODAY}.log
s_return=`grep -i "Error" /home/dwhuser/tjdwh/log/kettle_delete_jobs_and_resumes.log|wc -l`
if [ $s_return -gt 0 ]
        then
                /home/dwhuser/tjdwh/bin/mail.pl F > /dev/null
                exit 0
fi

printf "Deletion End: $(date +'%d%b%y-%T') \n "
echo ""

printf "	******** Job Master Dimension ******** \n"
printf "Start Job_Master_Dimension_1.krt: $(date +'%d%b%y-%T') \n"

/opt/data-integration/kitchen.sh -user=admin -pass=admin -rep=dwh_repo -job=Job_Master_Dimension_1 > /home/dwhuser/tjdwh/log/kettle_job_master_dim_${TODAY}.log
s_return=`grep -i "Failure Mail" /home/dwhuser/tjdwh/log/kettle_job_master_dim.log|wc -l`
if [ $s_return -gt 0 ]
        then
                exit 0
fi
printf "Completed Job_Master_Dimension_1.krt: $(date +'%d%b%y-%T') \n "
echo ""

printf "	******** Job Resume Dimension ******** \n"
printf "Start Job_Resume_Dimension_2.krt:    $(date +'%d%b%y-%T') \n"


/opt/data-integration/kitchen.sh -user=admin -pass=admin -rep=dwh_repo -job=Job_Resume_Dimension_2 > /home/dwhuser/tjdwh/log/kettle_job_resume_dim_${TODAY}.log
s_return=`grep -i "Failure Mail" /home/dwhuser/tjdwh/log/kettle_job_resume_dim.log|wc -l`
if [ $s_return -gt 0 ]
        then
                exit 0
fi

printf "Completed Job_Resume_Dimension_2.krt: $(date +'%d%b%y-%T') \n "
echo ""

printf "	******* Job Transformations ******* \n"
printf "Start Job_Transformations_3.krt:    $(date +'%d%b%y-%T') \n"

/opt/data-integration/kitchen.sh -user=admin -pass=admin -rep=dwh_repo -job=Job_Transformations_3 > /home/dwhuser/tjdwh/log/kettle_job_trans_${TODAY}.log
s_return=`grep -i "Failure Mail" /home/dwhuser/tjdwh/log/kettle_job_trans.log|wc -l`
if [ $s_return -gt 0 ]
        then
                exit 0
fi

printf "Completed Job_Transformations_3.krt: $(date +'%d%b%y-%T') \n "
echo ""

printf "	******** Job Fact Transformations ******** \n"
printf "Start Job_Fact_Transformations_4.krt:   $(date +'%d%b%y-%T') \n"

/opt/data-integration/kitchen.sh -user=admin -pass=admin -rep=dwh_repo -job=Job_Fact_Transformations_4 > /home/dwhuser/tjdwh/log/kettle_job_fact_trans_${TODAY}.log
s_return=`grep -i "Failure Mail" /home/dwhuser/tjdwh/log/kettle_job_fact_trans.log|wc -l`
if [ $s_return -gt 0 ]
        then
                exit 0
fi

printf "Completed Job_Fact_Transformations_4.krt $(date +'%d%b%y-%T') \n "
echo ""

printf "	******** Emp Unsubmail Transformations ******** \n"
printf "Start job_emp_unsubmail_6.krt:    $(date +'%d%b%y-%T') \n"

/opt/data-integration/kitchen.sh -user=admin -pass=admin -rep=dwh_repo -job=job_emp_unsubmail_6 > /home/dwhuser/tjdwh/log/kettle_job_emp_unsubmail_fact_${TODAY}.log
s_return=`grep -i "Failure Mail" /home/dwhuser/tjdwh/log/kettle_job_emp_unsubmail_fact.log|wc -l`
if [ $s_return -gt 0 ]
        then
                exit 0
fi

printf "Completed job_emp_unsubmail_6.krt $(date +'%d%b%y-%T') \n "
echo ""

printf "	******** Move Data Script Start ******** \n "
printf "Start Job_move_data_5.krt:    $(date +'%d%b%y-%T') \n"

/opt/data-integration/kitchen.sh -user=admin -pass=admin -rep=dwh_repo -job=Job_move_data_5 > /home/dwhuser/tjdwh/log/kettle_Job_move_to_warehouse_5_${TODAY}.log
s_return=`grep -i "error" /home/dwhuser/tjdwh/log/kettle_Job_move_to_warehouse_5.log|wc -l`
if [ $s_return -gt 0 ]
        then
              /home/dwhuser/tjdwh/bin/mail.pl F > /dev/null  
              exit 0
fi

printf "Completed Job_move_data_5.krt $(date +'%d%b%y-%T') \n "
echo ""

printf "	******** Procedures Call Script Start ******** \n "
printf "Start move_data_v2.csh:    $(date +'%d%b%y-%T') \n"


/home/dwhuser/tjdwh/bin/move_data_v2.csh > /home/dwhuser/tjdwh/log/mysql_move_data_v2_${TODAY}.log
s_return=`grep -i "ERROR" /home/dwhuser/tjdwh/log/mysql_move_data_v2.log|wc -l`
if [ $s_return -gt 0 ]
        then
                /home/dwhuser/tjdwh/bin/mail.pl F > /dev/null
                exit 0
fi

printf "Completed move_data_v2.csh $(date +'%d%b%y-%T') \n "
echo ""

printf "ETL Process Completed Succussfuly.\n" > ${LOG_FILE}

mail_bdy=$(cat ${LOG_FILE})
${KSH_SCRIPTS_DIR}/mail $email "ETL Process Completed Succussfuly." ${mail_bdy}

echo $(date +'%d%b%y-%T')
exit 0

