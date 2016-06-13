#!/usr/bin/ksh

set +x
export today=`date +%Y-%m-%d`
export pth=`date +%d%b%y`
export totalfiles=1
set -A filearr LOGIN_USAGE_HISTORY.txt
export filearr

if [ -f /candreports/db2inst2/sqllib/db2profile ]; then
        . /candreports/db2inst2/sqllib/db2profile
fi

echo "Date: $today"
cd /home/datareq/generic_etl/data_files

echo "Delete existing Data File"
rm LOGIN_USAGE_HISTORY.txt

echo "Start Data Extraction"
/home/datareq/generic_etl/ksh_scripts/login_usage_history.csh > /home/datareq/generic_etl/logs/login_usage_history_${today}.log

echo "Export File Search"
i=0
while [[ ${i} -lt $totalfiles ]]; do
 currfile=${filearr[$i]}
  if [[ -f ${currfile} ]]; then
    printf "current file is "${currfile}
    printf "\n"
  else
    printf "Data Extraction is not completed Propertly \n"
    printf "Missing File "${currfile}
    printf "\n"
#     /home/datareq/JOBBUZZ_ETL/mail.pl F
    exit 1
  fi
  i=`expr $i + 1`
  if [[ ${i} -eq $totalfiles ]]; then
   echo "Date Extracted Succussfully \n"
#  /home/datareq/JOBBUZZ_ETL/mail.pl T
  fi
done

echo "Data Extraction Completed"
touch /home/datareq/generic_etl/job_completed/LOGIN_USAGE_HISTORY_${today}.done
#touch /home/datareq/generic_etl/data_files/login_usage_history_${pth}.done
echo "FTP File to EDW server"
cd /home/datareq/generic_etl/data_files
cp /home/datareq/generic_etl/ksh_scripts/ftp_login_usage_history.ftp /home/datareq/generic_etl/data_files
/home/datareq/generic_etl/data_files/ftp_login_usage_history.ftp > /home/datareq/generic_etl/logs/ftp_login_usage_history_${today}.log
/home/datareq/generic_etl/data_files/ftp_login_usage_history_adhoc.ftp > /home/datareq/generic_etl/logs/ftp_login_usage_history_adhoc_${today}.log

rm login_usage_history_${pth}.done
exit

