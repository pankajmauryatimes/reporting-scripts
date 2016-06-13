select col1 as DESPRIPTION, ACTIVITY_DATE,sum(col2) as "APPLY BUTTON FOR ALL JOBS", sum(col3) as "USERS WITH 2+ YEAR EXPERIENCE",sum(col4) as "APPLY VIA REFERRAL",
sum(col5) as "APPLY WHEN AVF WAS SERVED"
from(
select 'IMPRESSION' as col1, ACTIVITY_DATE,
        TOTAL_VIEW_COUNT as col2,
        JOB_VIEWED_CAND_EXP2PLUS as col3,
        REFERRAL_JOB_VIEW_COUNT as col4,
        VIEW_WHEN_AVF_WAS_SERVED as col5
from job_insight_data_avf_fact where ACTIVITY_DATE between current_date -interval 31 day and current_date -interval 1 day
union
select 'APPLY_COUNT' as col1, ACTIVITY_DATE,
        TOTAL_APPLY_COUNT as col2,
        JOB_APPLY_CAND_EXP2PLUS as col3,
        REFERRAL_JOB_APPLY_COUNT as col4,
        APPLY_WHEN_AVF_WAS_SERVED as col5
from job_insight_data_avf_fact where ACTIVITY_DATE between current_date -interval 31 day and current_date -interval 1 day
) t group by ACTIVITY_DATE desc ,col1 desc INTO OUTFILE '/tmp/Job_Insight_Data_Report_2016-06-12.txt' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n'; 
