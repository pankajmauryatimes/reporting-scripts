#!/bin/ksh

set +x

echo "update DATAREQ_QUEUE dq1 set dq1.REQ_DESC = replace(dq1.REQ_DESC, ' ', '_') where trim(REQ_DESC) like '% %' and date(FILE_CREATE_TIME) = current_date;" > req_queue.sql

echo "select concat(concat(concat(concat(trim(REQ_BY),'|'),trim(REQ_DESC),'|',REQ_ID),'|',trim(AD_ID_FILE),'_',trim(REQ_ID)) ,'|',trim(DATA_COUNT) ,'|',trim(AD_ID_FILE),'|',
SUBSTRING(replace(FIELDS,' ',''), 1, CHAR_LENGTH(replace(FIELDS,' ','')) - 1)) into outfile '${SQL_LOG}/DATAREQ_QUEUE_${now}.txt'
from DATAREQ_QUEUE where PROCESS_STATUS ='P' ;" >> req_queue.sql

mysql -udwhuser -pdwhuser tjdwh_db < req_queue.sql

export data_req_count=$(cat ${SQL_LOG}/DATAREQ_QUEUE_${now}.txt | wc -l)
echo "data_req_count: $data_req_count"

echo "$(cat $HOME/DATAREQUEST_PROCESS/log/DATAREQ_PROCESSOR_${now}.log)"
rm -f $HOME/DATAREQUEST_PROCESS/log/DATAREQ_PROCESSOR_${now}.log


rm -f req_queue.sql

