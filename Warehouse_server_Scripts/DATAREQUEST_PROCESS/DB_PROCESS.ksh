#!/usr/bin/ksh

set +x

export HOME=/home/dwhuser
export now=`date +%m%d%Y-%H%M%S`
export KSH_SCRIPTS_DIR=${HOME}/DATAREQUEST_PROCESS
#generic_etl/ksh_scripts
export e_email=tjbi@timesgroup.com
export s_email=tjbi@timesgroup.com,pravesh.suyal@timesgroup.com
time=$(date +"%T")
start_tm=$(date +"%T")

export DIR_SOLAR_FILE=$HOME/DATAREQUEST_PROCESS/SolarProject/files
export SQL_LOG=/tmp
export EMAIL_REP=$HOME/DATAREQUEST_PROCESS/log/email_rep.dmp
export CURR_DIR=$HOME/DATAREQUEST_PROCESS
export e_email=tjbi@timesgroup.com

cd ${CURR_DIR}

printf "\n ### DATA REQUEST PROCESS BIGIN ### (Time :$(date +'%d%b%y-%T')) \n"

printf "\n Holding Data Request for Process \n"
echo "update DATAREQ_QUEUE set PROCESS_STATUS='H' where PROCESS_STATUS ='P' ;" > $HOME/DATAREQUEST_PROCESS/log/hold_datareq_${now}.sql
mysql -udwhuser -pdwhuser tjdwh_db < $HOME/DATAREQUEST_PROCESS/log/hold_datareq_${now}.sql

#echo "Replace space in file name / description"
echo "update DATAREQ_QUEUE dq1 set dq1.REQ_DESC = replace(dq1.REQ_DESC, ' ', '_') where trim(REQ_DESC) like '% %' and date(FILE_CREATE_TIME) between current_date -interval 3 day and current_date;" > req_queue.sql

echo "select concat(concat(concat(concat(trim(REQ_BY),'|'),trim(REQ_DESC),'|',REQ_ID),'|',trim(AD_ID_FILE),'_',trim(REQ_ID)) ,'|',trim(DATA_COUNT) ,'|',trim(AD_ID_FILE),'|',
SUBSTRING(replace(FIELDS,' ',''), 1, CHAR_LENGTH(replace(FIELDS,' ','')) - 1)) into outfile '${SQL_LOG}/DATAREQ_QUEUE_${now}.txt'
from DATAREQ_QUEUE where PROCESS_STATUS ='H' ;" >> req_queue.sql

mysql -udwhuser -pdwhuser tjdwh_db < req_queue.sql
rm -f req_queue.sql

data_req_count=$(cat ${SQL_LOG}/DATAREQ_QUEUE_${now}.txt | wc -l)

#If data_req_count is zero"
if [[ -s ${SQL_LOG}/DATAREQ_QUEUE_${now}.txt ]] 
then
    printf "\n **** Data Request Found ($data_req_count). **** "
else
    printf "\n "
    printf "\n STAGE 1 check - No Data Request is Pinding"
    printf "\n Bye ...." \n
fi

COUNTER=1
for req_queue in $(cat ${SQL_LOG}/DATAREQ_QUEUE_${now}.txt)
do
  printf "\n QUEUE ($COUNTER) Executing .. (Time :$(date +'%d%b%y-%T')) \n" 
  printf "\n Rquest Detail below: \n $req_queue \n"
  REQ_BY=$(echo $req_queue | cut -d"|" -f1)
  REQ_DESC=$(echo $req_queue | cut -d"|" -f2)
  REQ_ID=$(echo $req_queue | cut -d"|" -f3)
  FILE_NAME=$(echo $req_queue | cut -d"|" -f4)
  DATA_COUNT=$(echo $req_queue | cut -d"|" -f5)
  AD_ID_FILE=$(echo $req_queue | cut -d"|" -f6)
  FIELDS=$(echo $req_queue | cut -d"|" -f7)

  printf "\n 	REQ_ID          :$REQ_ID"
  printf "\n 	REQ_BY          :$REQ_BY"
  printf "\n 	REQ_DESC        :$REQ_DESC"
  printf "\n 	FILE_NAME       :$FILE_NAME"
  printf "\n 	AD_ID_FILE      :$AD_ID_FILE"
  printf "\n 	FIELDS REQUESTED:$FIELDS"
  
  printf "\n\n    COUNT REQUESTED :$DATA_COUNT"
  printf "\n     AD_ID COUNT     :$(cat ${DIR_SOLAR_FILE}/${AD_ID_FILE}.csv | wc -l) \n" 
#Exist from loop if REQ ID not found
  if [[ $REQ_ID == "" ]]
  then
      printf "\n STAGE 2 check - No Data Rquest is Pendiang"
      break
  fi

req_no=${REQ_ID}.sql

printf "\n \n ** SQL Query Executing ** (Time :$(date +'%d%b%y-%T')) \n"

# Verify Data Request
if [[ $FIELDS == "" ]]
then
     printf "\n Field did not mention"
     printf "\n SKIP REQ_ID :$REQ_ID"
#Error message insert into table
     echo "update DATAREQ_QUEUE set PROCESS_STATUS='E', err_message='null value in column \"field\"' where REQ_ID = ${REQ_ID} ;" > $HOME/DATAREQUEST_PROCESS/log/${req_no}
     mysql -udwhuser -pdwhuser tjdwh_db < $HOME/DATAREQUEST_PROCESS/log/${req_no}

#Re-create data file
     if [[ -s ${DIR_SOLAR_FILE}/${AD_ID_FILE}.csv ]]
     then
         echo ""
     else
         if [[ -s ${CURR_DIR}/DATA_ARCHIVE/${AD_ID_FILE}.csv.gz ]]
         then
             cp ${CURR_DIR}/DATA_ARCHIVE/${AD_ID_FILE}.csv.gz ${CURR_DIR}/DATA_ARCHIVE/${AD_ID_FILE}.csv.gz-bak_${now}
             gunzip ${CURR_DIR}/DATA_ARCHIVE/${AD_ID_FILE}.csv.gz
             mv ${CURR_DIR}/DATA_ARCHIVE/${AD_ID_FILE}.csv ${DIR_SOLAR_FILE}/${AD_ID_FILE}.csv
         fi
     fi     
     echo "*** DATA REQUEST DESCRIPTION:" > ${EMAIL_REP}
     echo "" >> ${EMAIL_REP}
     echo "REQ_BY    :$REQ_BY" >> ${EMAIL_REP}
     echo "REQ_DESC  :$REQ_DESC" >> ${EMAIL_REP}
     echo "DATA_COUNT:$DATA_COUNT" >> ${EMAIL_REP}
     echo "FIELDS    :$FIELDS" >> ${EMAIL_REP}
     echo ""
     echo ""
     echo "Thanks," >> ${EMAIL_REP}
     echo "Datawarehouse Team" >> ${EMAIL_REP}
     echo "" >> ${EMAIL_REP}
     echo "This E-Notification was automatically generated. Please do not reply to this mail." >> ${EMAIL_REP}
     echo "" >> ${EMAIL_REP}

     #email=$(sort $HOME/DATAREQUEST_PROCESS/.email_dl.lst | grep "${REQ_BY}" |cut -d: -f2 | uniq )
     ${KSH_SCRIPTS_DIR}/mail $e_email "Error- DATA REQUEST \"${REQ_DESC}\" (Field is missing)" ${EMAIL_REP}

else

. $HOME/DATAREQUEST_PROCESS/DATAREQ_SQL_QUERIES.ksh > $HOME/DATAREQUEST_PROCESS/log/DATAREQ_PROCESSOR_SQL_${now}.log
#echo "$(cat $HOME/DATAREQUEST_PROCESS/log/DATAREQ_PROCESSOR_SQL_${now}.log) \n" 

printf "\n\n **SCP FILE ** \n"

FILE_NAME=${FILE_NAME}.txt

if [[ ${avl_data} -ne 0 ]]
then
. $HOME/DATAREQUEST_PROCESS/DATAREQ_SCPFILES.ksh > $HOME/DATAREQUEST_PROCESS/log/DATAREQ_PROCESSOR_SCP_${now}.log
  cat $HOME/DATAREQUEST_PROCESS/log/DATAREQ_PROCESSOR_SCP_${now}.log

  printf "\n\n **Confirme by Email ** \n"

. $HOME/DATAREQUEST_PROCESS/email_format.ksh > $HOME/DATAREQUEST_PROCESS/log/DATAREQ_PROCESSOR_EMAIL_${now}.log
  cat $HOME/DATAREQUEST_PROCESS/log/DATAREQ_PROCESSOR_EMAIL_${now}.log


#File Archiving
  cd ${DIR_SOLAR_FILE}
#zip ${AD_ID_FILE} ${AD_ID_FILE}.csv
  gzip ${AD_ID_FILE}.csv
  mv ${AD_ID_FILE}.csv.gz $HOME/DATAREQUEST_PROCESS/DATA_ARCHIVE
  #mv ${SQL_LOG}/DATAREQ_QUEUE_${now}.txt $HOME/DATAREQUEST_PROCESS/log
  rm -f /tmp/DATAREQ_QUEUE_${now}.txt

  cd -

  printf "\n File has been transferred"
  printf "\n $(date +'%d%b%y-%T') \n "
else
. $HOME/DATAREQUEST_PROCESS/err_email_format.ksh > $HOME/DATAREQUEST_PROCESS/log/DATAREQ_PROCESSOR_EMAIL_${now}.log
fi
fi  
  REQ_BY=''
  REQ_DESC=''
  REQ_ID=''
  FILE_NAME=''
  DATA_COUNT=''
  AD_ID_FILE=''
  FIELDS=''
  req_no=''
  avl_data=''
  COUNTER=$((COUNTER+1))
  email=''

done

#Remove archive file older then 3 days
cd $HOME/DATAREQUEST_PROCESS/DATA_ARCHIVE
find . -type f -name "*.txt" -mtime +7 -exec rm -f '{}' ';'
find . -type f -name "*.gz" -mtime +7 -exec rm -f '{}' ';'
cd -

printf "\n HOURLY PROCESS FINISHED"
printf "\n $(date +'%d%b%y-%T') \n"


