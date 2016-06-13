load data local infile 'apps_status_till_date_daily.csv' into table apps_status_till_date_daily_stage fields terminated by ',' enclosed by '"' lines terminated by '\n';

load data local infile 'apps_status_till_date_daily1.csv' into table apps_status_till_date_stage fields terminated by ',' enclosed by '"' lines terminated by '\n';

