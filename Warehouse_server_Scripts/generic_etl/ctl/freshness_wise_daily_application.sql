truncate table daily_login_fact;
load data local infile 'unique_applicants_12062016.csv' into table daily_login_fact fields terminated by ',' enclosed by '"' lines terminated by '\n';
