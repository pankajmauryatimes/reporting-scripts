load data local infile 'mobile_parameter.csv' into table candidate_transaction_kpi fields terminated by ',' enclosed by '"' lines terminated by '\n';
call tjsitestats.prc_generate_daily_mobile_stats(current_date);
