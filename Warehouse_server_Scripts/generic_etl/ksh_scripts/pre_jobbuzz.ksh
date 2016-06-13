#!/bin/bash

perl -pi -e 's/,,/,\\N,/g' /opt/dw_data/data/jobbuzz/INDUSTRY_SUBGRP_FA.txt
perl -pi -e 's/,,/,\\N,/g' /opt/dw_data/data/jobbuzz/COMPANY_INTERVIEW_QUESTION_CATEGORY.txt
perl -pi -e 's/,,/,\\N,/g' /opt/dw_data/data/jobbuzz/LEVEL_MAS.txt
perl -pi -e 's/,,/,\\N,/g' /opt/dw_data/data/jobbuzz/INTERVIEW_QUESTION_CATEGORY_MAS.txt
perl -pi -e 's/,,/,\\N,/g' /opt/dw_data/data/jobbuzz/ROLE_FA.txt
perl -pi -e 's/,,/,\\N,/g' /opt/dw_data/data/jobbuzz/LOCATION.txt
perl -pi -e 's/,,/,\\N,/g' /opt/dw_data/data/jobbuzz/INDUSTRY.txt
perl -pi -e 's/,,/,\\N,/g' /opt/dw_data/data/jobbuzz/COMPANY.txt
perl -pi -e 's/,,/,\\N,/g' /opt/dw_data/data/jobbuzz/INDUSTRY_ROLE_SALARY_BAND.txt
perl -pi -e 's/,,/,\\N,/g' /opt/dw_data/data/jobbuzz/FOLLOW_COMPANY.txt
perl -pi -e 's/,,/,\\N,/g' /opt/dw_data/data/jobbuzz/COMPANY_ROLE_SALARY_BAND.txt
perl -pi -e 's/,,/,\\N,/g' /opt/dw_data/data/jobbuzz/COMPANY_REVIEW_WORK_REASON.txt
perl -pi -e 's/,,/,\\N,/g' /opt/dw_data/data/jobbuzz/COMPANY_REVIEW_SUCCESS_SKILLS.txt
perl -pi -e 's/,,/,\\N,/g' /opt/dw_data/data/jobbuzz/COMPANY_REVIEW_RATING.txt
perl -pi -e 's/,,/,\\N,/g' /opt/dw_data/data/jobbuzz/COMPANY_INTERVIEW.txt
perl -pi -e 's/,,/,\\N,/g' /opt/dw_data/data/jobbuzz/CANDIDATE.txt
perl -pi -e 's/,,/,\\N,/g' /opt/dw_data/data/jobbuzz/TJ_TRACK.txt
perl -pi -e 's/,,/,\\N,/g' /opt/dw_data/data/JB_KPI_FACT.txt
perl -pi -e 's/,,/,\\N,/g' /opt/dw_data/data/jobbuzz/ACTIVITY_FACT.txt
perl -pi -e 's/,,/,\\N,/g' /opt/dw_data/data/jobbuzz/ACTIVITY_TYPE_MASTER.txt
perl -pi -e 's/,,/,\\N,/g' /opt/dw_data/data/jobbuzz/COMPANY_REVIEW_QNA.txt
perl -pi -e 's/,,/,\\N,/g' /opt/dw_data/data/jobbuzz/COMPANY_REVIEW_RATING.txt
perl -pi -e 's/,,/,\\N,/g' /opt/dw_data/data/jobbuzz/ENTITY_TYPE_MASTER.txt
perl -pi -e 's/,,/,\\N,/g' /opt/dw_data/data/jobbuzz/SUB_ENTITY_TYPE_MASTER.txt

perl -pi -e 's/,,/,\\N,/g' /opt/dw_data/data/jobbuzz/FOLLOW_COMPANY_FACT.txt
perl -pi -e 's/,,/,\\N,/g' /opt/dw_data/data/jobbuzz/COMMENTS_FACT.txt
