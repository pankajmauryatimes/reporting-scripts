#!/bin/bash

set +x

if [[ ${AD_ID_FILE} == "" ]]
then
    printf "\n Call me from Parent file" >> $HOME/DATAREQUEST_PROCESS/log/DATAREQ_PROCESSOR_${now}.log
    exit
fi

perl -pi -e "s/,/\n/g" ${DIR_SOLAR_FILE}/${AD_ID_FILE}.csv
sed '/^$/d' ${DIR_SOLAR_FILE}/${AD_ID_FILE}.csv > $HOME/DATAREQUEST_PROCESS/log/${AD_ID_FILE}.prc
mv $HOME/DATAREQUEST_PROCESS/log/${AD_ID_FILE}.prc ${DIR_SOLAR_FILE}/${AD_ID_FILE}.csv

#echo "Delete Existing Data File, if already exists"
rm -f $HOME/DATAREQUEST_PROCESS/wip/${FILE_NAME}.txt

echo "update DATAREQ_QUEUE set PROCESS_STATUS='W' where REQ_ID = ${REQ_ID} ;" > $HOME/DATAREQUEST_PROCESS/log/${req_no}
mysql -udwhuser -pdwhuser tjdwh_db < $HOME/DATAREQUEST_PROCESS/log/${req_no}

echo "truncate table datareq_ad_ids ;" > $HOME/DATAREQUEST_PROCESS/log/${req_no}
echo "load data local infile '${DIR_SOLAR_FILE}/${AD_ID_FILE}.csv' into table datareq_ad_ids fields terminated by ',' enclosed by '\"' lines terminated by '\n' ;" >> $HOME/DATAREQUEST_PROCESS/log/${req_no}

if [[ -s ${DIR_SOLAR_FILE}/${AD_ID_FILE}.csv ]]
then
    if [[ $FIELDS == Mobile ]]
    then
         echo "select distinct $FIELDS from (select distinct trim(replace(ld.phone_mobile,',',' ')) as Mobile,FLOOR(RAND()*100000) as rownum from login_dimension ld,resume_dimension rd,datareq_ad_ids dad where rd.net_status = 11 and rd.view_status = 1 and rd.login_key = ld.login_key and rd.ad_id = dad.ad_id and length(trim(ld.phone_mobile)) = 12 and substring(trim(ld.phone_mobile),1,2) = '91' and ld.contact_by_sms_flag = 'Y' and (ld.hibernate_date < now() or ld.hibernate_date is null) order by rownum desc ) tt limit ${DATA_COUNT} INTO OUTFILE '${SQL_LOG}/${FILE_NAME}.txt' FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\n' ;" >> $HOME/DATAREQUEST_PROCESS/log/${req_no}
    else

     where=`echo where $FIELDS | sed -e 's/,/ is not null and /g' | sed -e 's/$/ is not null/g'`

         echo "select distinct $FIELDS from (select rd.ad_id AS ResumeId,concat(trim(replace(ld.first_Name,',',' ')),' ',trim(replace(ld.last_name,',',' '))) as FullName,trim(replace(ld.first_Name,',',' ')) as FirstName, trim(replace(ld.last_name,',',' ')) as LastName,trim(replace(ld.mail_primary,',',' ')) as Email,trim(replace(ld.phone_mobile,',',' ')) as Mobile,(select trim(replace(ld1.location_name,',',' ')) from location_dimension ld1 where ld1.location_key = rd.currentlocation_key) as Location,FLOOR(RAND()*100000) as rownum from login_dimension ld,resume_dimension rd,datareq_ad_ids dad where ld.isFakeEmail = 0 and (ld.is_unsubscribed_promo is null or ld.is_unsubscribed_promo =0) and rd.net_status = 11 and rd.view_status = 1 and rd.login_key = ld.login_key and rd.ad_id = dad.ad_id and (ld.hibernate_date < now() or ld.hibernate_date is null) order by rownum desc ) tt $where limit ${DATA_COUNT} INTO OUTFILE '${SQL_LOG}/${FILE_NAME}.txt' FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\n' ;" >> $HOME/DATAREQUEST_PROCESS/log/${req_no}

    fi
else
    printf "\n\nMissing AD_ID File: ${DIR_SOLAR_FILE}/${AD_ID_FILE}.csv \n\n" >> $HOME/DATAREQUEST_PROCESS/log/DATAREQ_PROCESSOR_${now}.log
    ${KSH_SCRIPTS_DIR}/mail $e_email "Error- DATA REQUEST \"${REQ_DESC}\" (AD_ID File is missing)" $HOME/DATAREQUEST_PROCESS/log/DATAREQ_PROCESSOR_${now}.log 
fi

mysql -udwhuser -pdwhuser tjdwh_db < $HOME/DATAREQUEST_PROCESS/log/${req_no} > $HOME/DATAREQUEST_PROCESS/log/${req_no}.log 2>&1

printf "\n SQL QUERY BELOW: \n" >> $HOME/DATAREQUEST_PROCESS/log/DATAREQ_PROCESSOR_${now}.log
cat $HOME/DATAREQUEST_PROCESS/log/${req_no} >> $HOME/DATAREQUEST_PROCESS/log/DATAREQ_PROCESSOR_${now}.log
#printf "\n $LOG_SQL \n" >> $HOME/DATAREQUEST_PROCESS/log/DATAREQ_PROCESSOR_${now}.log

mv ${SQL_LOG}/${FILE_NAME}.txt $HOME/DATAREQUEST_PROCESS/DATA_FILES/

avl_data=''
avl_data=$(cat $HOME/DATAREQUEST_PROCESS/DATA_FILES/${FILE_NAME}.txt | wc  -l)

err_sql=$(cat $HOME/DATAREQUEST_PROCESS/log/${req_no}.log | grep 'ERROR')
if [[ $err_sql != "" ]]
then
    echo "Error: Execution of SQL Script"
    echo "update DATAREQ_QUEUE set PROCESS_STATUS='E',err_message='$err_sql' where REQ_ID = ${REQ_ID} ;" > $HOME/DATAREQUEST_PROCESS/log/${req_no}_err
    mysql -udwhuser -pdwhuser tjdwh_db < $HOME/DATAREQUEST_PROCESS/log/${req_no}_err

else
    echo "SQL Executed Succussfully"
    echo "update DATAREQ_QUEUE set PROCESS_STATUS='C' ,SENT_COUNT = $avl_data,FILE_SENT_TIME = current_timestamp where REQ_ID = ${REQ_ID};" > $HOME/DATAREQUEST_PROCESS/log/${req_no}_r
mysql -udwhuser -pdwhuser tjdwh_db < $HOME/DATAREQUEST_PROCESS/log/${req_no}_r

fi

printf "\n OutPut File :${SQL_LOG}/${FILE_NAME}.txt" >> $HOME/DATAREQUEST_PROCESS/log/DATAREQ_PROCESSOR_${now}.log
printf "\n DATA POINT FOUND: $avl_data \n" >> $HOME/DATAREQUEST_PROCESS/log/DATAREQ_PROCESSOR_${now}.log

rm -f $HOME/DATAREQUEST_PROCESS/log/${req_no}_r
perl -pi -e 's/"//g' $HOME/DATAREQUEST_PROCESS/DATA_FILES/${FILE_NAME}.txt

