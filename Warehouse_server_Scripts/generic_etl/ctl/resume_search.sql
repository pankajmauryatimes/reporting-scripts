load data local infile 'DailyStat.txt' into table live_hire_db_fact fields terminated by ',' enclosed by '"' lines terminated by '\n';
load data local infile '/home/dwhuser/generic_etl/wip/SearchLogStat.txt' into table corp_search_aggregate fields terminated by ',' enclosed by '"' lines terminated by '\n';

