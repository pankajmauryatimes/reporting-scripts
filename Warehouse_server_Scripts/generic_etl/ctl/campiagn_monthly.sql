load data local infile 'exp_wise_stage_relaxation.txt' into table monthly_tj_registrations_distribution_exp fields terminated by ',' enclosed by '"' lines terminated by '\n';
load data local infile 'location_wise_stage_relaxation.txt' into table monthly_tj_registrations_distribution_loc fields terminated by ',' enclosed by '"' lines terminated by '\n';
load data local infile 'Aggregate_stage_wise_inorganic_count.txt' into table monthly_tj_registrations_distribution fields terminated by ',' enclosed by '"' lines terminated by '\n';
load data local infile 'exp_wise_stage_organic.txt' into table monthly_tj_registrations_distribution_exp fields terminated by ',' enclosed by '"' lines terminated by '\n';
load data local infile 'location_wise_stage_organic.txt' into table monthly_tj_registrations_distribution_loc fields terminated by ',' enclosed by '"' lines terminated by '\n';
load data local infile 'Aggregate_stage_wise_organic_count.txt' into table monthly_tj_registrations_distribution fields terminated by ',' enclosed by '"' lines terminated by '\n';
load data local infile 'exp_wise_stage_older_converts_count.txt' into table tj_monthly_transaction_kpi fields terminated by ',' enclosed by '"' lines terminated by '\n'

