#!/usr/bin/ksh

set +x
export today=`date +%Y-%m-%d`
export pth=`date +%d%b%y`
export totalfiles=6
set -A filearr WIDGET_CREATE_FACT.txt WIDGET_UPDATE_FACT.txt WIDGET_MASTER.txt WIDGET_STATUS_MASTER.txt new_resume_profile_complete_fact.txt edit_resume_profile_complete_fact.txt new_resume_profile_complete_widgets_dist_fact.txt edit_resume_profile_complete_widgets_dist_fact.txt 
#active_resume_profile_complete_fact.txt
export filearr

if [ -f /candreports/db2inst2/sqllib/db2profile ]; then
        . /candreports/db2inst2/sqllib/db2profile
fi

echo "Date: $today"
cd /home/datareq/generic_etl/data_files

echo "Delete existing Data File"
rm WIDGET_CREATE_FACT.txt
rm WIDGET_UPDATE_FACT.txt
rm WIDGET_MASTER.txt
rm WIDGET_STATUS_MASTER.txt
rm new_resume_profile_complete_fact.txt
rm edit_resume_profile_complete_fact.txt
rm new_resume_profile_complete_widgets_dist_fact.txt 
rm edit_resume_profile_complete_widgets_dist_fact.txt

echo "Start Data Extraction"
/home/datareq/generic_etl/ksh_scripts/widgets_stats.csh > /home/datareq/generic_etl/logs/widgets_stats_${today}.log

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
touch /home/datareq/generic_etl/job_completed/widgets_stats_${today}.done
touch /home/datareq/generic_etl/data_files/widgets_stats_${pth}.done
echo "FTP File to EDW server"
cp /home/datareq/generic_etl/ksh_scripts/ftp_widgets_stats.ftp /home/datareq/generic_etl/data_files
cp /home/datareq/generic_etl/ksh_scripts/ftp_widgets_stats_v2.ftp /home/datareq/generic_etl/data_files

/home/datareq/generic_etl/data_files/ftp_widgets_stats.ftp > /home/datareq/generic_etl/logs/ftp_widgets_stats_${today}.log
/home/datareq/generic_etl/data_files/ftp_widgets_stats_v2.ftp > /home/datareq/generic_etl/logs/ftp_widgets_stats_v2_${today}.log

rm widgets_stats_${pth}.done

exit


