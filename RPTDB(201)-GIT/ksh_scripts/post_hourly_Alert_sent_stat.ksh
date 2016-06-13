#!/bin/bash

set +x
export now=`date +%Y-%m-%d' '%H:%M:%S`

perl -pi -e 's/"//g' ${LOG_DIR}/hourly_Alert_sent_stat.txt
perl -pi -e 's/,/,\t\t/g' ${LOG_DIR}/hourly_Alert_sent_stat.txt
echo "SENT_DATE SENT_HOUR  A_20000   A_20500     A_21000    A_1009    A_1005     A_22000     A_30000   A_35000     A_20100    A_20400    A_40000 " > ${LOG_DIR}/hourly_Alert_sent_stat2.txt
echo "--------  --------- --------- ----------- ---------  -------- ----------- ---------   --------- -----------  ---------  ---------  ---------" >> ${LOG_DIR}/hourly_Alert_sent_stat2.txt
cat ${LOG_DIR}/hourly_Alert_sent_stat2.txt ${LOG_DIR}/hourly_Alert_sent_stat.txt > ${LOG_DIR}/hourly_Alert_sent_stat3.txt
mv ${LOG_DIR}/hourly_Alert_sent_stat3.txt ${LOG_DIR}/hourly_Alert_sent_stat.txt
rm -f ${LOG_DIR}/hourly_Alert_sent_stat2.txt
${KSH_SCRIPTS_DIR}/mail2 $email   "$cur_proc_name -Time: $now"  ${LOG_DIR}/hourly_Alert_sent_stat.txt
rm -f ${LOG_DIR}/hourly_Alert_sent_stat.txt
exit 0
