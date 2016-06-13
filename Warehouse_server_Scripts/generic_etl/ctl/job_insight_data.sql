truncate table tjdwh_staging.job_insight_data_stg;
truncate table tjdwh_staging.job_referral_count_stg;
truncate table tjdwh_staging.job_referral_count_stg2;

load data local infile '/home/dwhuser/generic_etl/wip/job_referral_data.csv' into table tjdwh_staging.job_referral_count_stg fields terminated by ',' enclosed by '"' lines terminated by '\n';

load data local infile '/home/dwhuser/generic_etl/wip/job_referral_data_2.csv' into table tjdwh_staging.job_referral_count_stg2 fields terminated by ',' enclosed by '"' lines terminated by '\n';
