#!/bin/ksh

set +x

export totalfiles=10
set -A filearr ExperienceReport.xml  QualificationMasReport.xml  QualificationMas2Report.xml institute2_idReport.xml  FAReport.xml  institute1_idReport.xml  FUNC_Area_SpecReport.xml  
IndustryReport-${FDAY}.xml  LocationReport-${FDAY}.xml  IndustryFAReport-${FDAY}.xml
export filearr

cd $HOME/generic_etl/data_archive/corp_search

echo "Directory Changed to /home/dwhuser/generic_etl/data_files" >> ${LOG_DIR}/${LOG_FILE}
printf "\nDirectory Changed to /home/dwhuser/generic_etl/data_files\n"

echo "SCP File Creation ....." >> ${LOG_DIR}/${LOG_FILE}
printf "\nSCP File Creation .....\n"

echo "
#!/bin/bash

set +x
scp search@115.112.206.83:/mnt/reporttool/report/ExperienceReport-${FDAY}.xml .
scp search@115.112.206.83:/mnt/reporttool/report/QualificationMasReport-${FDAY}.xml .
scp search@115.112.206.83:/mnt/reporttool/report/QualificationMas2Report-${FDAY}.xml .
scp search@115.112.206.83:/mnt/reporttool/report/institute2_idReport-${FDAY}.xml .
scp search@115.112.206.83:/mnt/reporttool/report/FAReport-${FDAY}.xml .
scp search@115.112.206.83:/mnt/reporttool/report/institute1_idReport-${FDAY}.xml .
scp search@115.112.206.83:/mnt/reporttool/report/FUNC_Area_SpecReport-${FDAY}.xml . 
scp search@115.112.206.83:/mnt/reporttool/report/IndustryReport-${FDAY}.xml .
scp search@115.112.206.83:/mnt/reporttool/report/LocationReport-${FDAY}.xml .
scp search@115.112.206.83:/mnt/reporttool/report/IndustryFAReport-${FDAY}.xml .
" > xml_scp_${FDAY}.csh
echo "SCP Begin ....." >> ${LOG_DIR}/${LOG_FILE}
printf "\nSCP Begin .....\n"

chmod 755 xml_scp_${FDAY}.csh
. $HOME/generic_etl/data_archive/corp_search/xml_scp_${FDAY}.csh

echo "SCP Completed" >> ${LOG_DIR}/${LOG_FILE}
printf "\nSCP Completed\n"

cp ExperienceReport-${FDAY}.xml ${HOME}/generic_etl/data_files/corp_search/ExperienceReport.xml
cp QualificationMasReport-${FDAY}.xml ${HOME}/generic_etl/data_files/corp_search/QualificationMasReport.xml
cp QualificationMas2Report-${FDAY}.xml ${HOME}/generic_etl/data_files/corp_search/QualificationMas2Report.xml
cp institute2_idReport-${FDAY}.xml ${HOME}/generic_etl/data_files/corp_search/institute2_idReport.xml
cp FAReport-${FDAY}.xml ${HOME}/generic_etl/data_files/corp_search/FAReport.xml
cp institute1_idReport-${FDAY}.xml ${HOME}/generic_etl/data_files/corp_search/institute1_idReport.xml
cp FUNC_Area_SpecReport-${FDAY}.xml ${HOME}/generic_etl/data_files/corp_search/FUNC_Area_SpecReport.xml
cp IndustryReport-${FDAY}.xml ${HOME}/generic_etl/data_files/corp_search/IndustryReport.xml
cp LocationReport-${FDAY}.xml ${HOME}/generic_etl/data_files/corp_search/LocationReport.xml
cp IndustryFAReport-${FDAY}.xml ${HOME}/generic_etl/data_files/corp_search/IndustryFAReport.xml

# Check for the existance of all the data files before kick off
time=$(date +"%T")
i=0
while [[ ${i} -lt $totalfiles ]]; do
      currfile=${filearr[$i]}
      echo "\n current file is "${currfile}
      printf "\n current file is ${currfile}"
      time=$(date +"%T")
      if [ -r $HOME/generic_etl/data_files/corp_search/$currfile ]
      then
          #Found all the data files#
          printf "\n $currfile found ...."
          echo " $currfile found ..." >> ${LOG_DIR}/${LOG_FILE}
          i=`expr $i + 1`
      else
          printf "$currfile not found.\n"  >> ${LOG_DIR}/${cur_proc}.cron
          echo " $currfile not found."  >> ${LOG_DIR}/${LOG_FILE}
          printf "Data file has not been transfered!\n" >> ${LOG_DIR}/${cur_proc}.cron
          echo "Data file has not been transfered!" >>  ${LOG_DIR}/${LOG_FILE}
          ${KSH_SCRIPTS_DIR}/mail $email   "$cur_proc_name - WARNING "  ${LOG_DIR}/${cur_proc}.cron
         exit 1
      fi
done
