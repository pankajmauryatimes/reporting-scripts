#!/usr/bin/ksh

set +x
export today=`date +%d%b%y`
export cutoff=23:50:00
export remind=07:00:00
export remindsent=0
export totalfiles=1
set -A filearr Vivek_CS_Analysis_data_${today}.csv
export filearr

export FILE_READY=/home/datareq/calling_data/rest_calling_data.zip
time=$(date +"%T")
while [[ $time < $cutoff ]]; do
    if [[ -f ${FILE_READY} ]]; then
      printf "Data Files Found "
      printf "\n"
      break
    else
        printf "File Not Found"
        sleep 300   #wait 5 min before checking again
        time=$(date +"%T")
        printf "time is "$time
    fi
done

cd /home/datareq/generic_etl/data_files
rm -f Vivek_CS_Analysis_data*
echo "Date: $today"
if [ -f /candreports/db2inst2/sqllib/db2profile ]; then
        . /candreports/db2inst2/sqllib/db2profile
fi
echo "Start Data Extraction"
/home/datareq/generic_etl/ksh_scripts/calling_data.csh > /home/datareq/generic_etl/logs/calling_data_${today}.log
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
echo "MOVE FTP File"
cp /home/datareq/generic_etl/ksh_scripts/ftp_calling_data.ftp /home/datareq/generic_etl/data_files
echo "File Transfer to REPORT SERVER"
/home/datareq/generic_etl/data_files/ftp_calling_data.ftp > /home/datareq/generic_etl/logs/ftp_calling_data_${today}.log
echo "File Transfer Completed."

exit

