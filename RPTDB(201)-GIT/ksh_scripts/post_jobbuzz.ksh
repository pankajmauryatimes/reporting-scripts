#!/usr/bin/ksh

set +x
export totalfiles=25
set -A filearr TJ_TRACK.txt ROLE_FA.txt LOCATION.txt INDUSTRY.txt INDUSTRY_SUBGRP_FA.txt COMPANY.txt CANDIDATE.txt COMPANY_REVIEW_RATING.txt COMPANY_REVIEW_WORK_REASON.txt COMPANY_REVIEW_SUCCESS_SKILLS.txt COMPANY_INTERVIEW.txt SUB_ENTITY_TYPE_MASTER.txt LEVEL_MAS.txt INTERVIEW_QUESTION_CATEGORY_MAS.txt INDUSTRY_ROLE_SALARY_BAND.txt ENTITY_TYPE_MASTER.txt COMPANY_ROLE_SALARY_BAND.txt COMPANY_OVERALL_RATING.txt COMPANY_INTERVIEW_QUESTION_CATEGORY.txt ACTIVITY_TYPE_MASTER.txt ACTIVITY_FACT.txt FOLLOW_COMPANY_FACT.txt COMPANY_REVIEW_QNA.txt COMMENTS_FACT.txt JB_KPI_FACT.txt

export filearr
echo "Cheking for File completeness ...."
print "Cheking for File completeness ...."
#cd ${HOME}/generic_etl/data_files/jobbuzz 
i=0
while [[ ${i} -lt $totalfiles ]]; do
 currfile=${filearr[$i]}
  if [[ -f $LOAD_DIR/${currfile} ]]; then
    printf "Flat File${i} : ${currfile}"
    printf "\n"
  else
    printf "Data Extraction is not completed Propertly \n"
    printf "Missing File: ${currfile}"
    printf "\n"
#     /home/datareq/JOBBUZZ_ETL/mail.pl F
    exit 1
  fi
  i=`expr $i + 1`
  if [[ ${i} -eq $totalfiles ]]; then
     printf " $totalfiles Files  Extracted Succussfully\n"
     echo "$totalfiles Files Extracted Succussfully \n"
#  /home/datareq/JOBBUZZ_ETL/mail.pl T
  fi
done

export ip=115.112.206.220
/home/datareq/generic_etl/data_files/jobbuzz/jobbuzz.ftp > /home/datareq/generic_etl/logs/jobbuzz.log

echo "All Files are created successfully"
touch $LOAD_DIR/${cur_proc}_${today}.done
