delete from login_usage_history;
load data local infile '/home/dwhuser/generic_etl/wip/LOGIN_USAGE_HISTORY.txt' into table login_usage_history fields terminated by ',' enclosed by '"' lines terminated by '\n';

