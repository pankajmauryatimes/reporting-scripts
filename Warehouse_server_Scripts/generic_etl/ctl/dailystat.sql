load data local infile 'DailyStat.txt' into table live_hire_db_fact fields terminated by ',' enclosed by '"' lines terminated by '\n';
load data local infile 'FA_Distribution.txt' into table tjdwh_staging.resume_index_fa_exp fields terminated by ',' enclosed by '"' lines terminated by '\n';
load data local infile 'dataRQ_search_index.txt' into table tjdwh_staging.resume_search_index fields terminated by ',' enclosed by '"' lines terminated by '\n';
load data local infile 'dataRQ_alert.txt' into table tjdwh_staging.resume_alert_index fields terminated by ',' enclosed by '"' lines terminated by '\n';
load data local infile 'FA_Distribution_Jobs.txt' into table tjdwh_staging.jobs_index_fa_exp fields terminated by ',' enclosed by '"' lines terminated by '\n';
load data local infile 'TJMetricsReport.txt' into table tjdwh_staging.live_resume_db_fact fields terminated by ',' enclosed by '"' lines terminated by '\n';
