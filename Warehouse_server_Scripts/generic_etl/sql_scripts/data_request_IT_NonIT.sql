truncate table test_ad;
load data local infile '/home/dwhuser/IT_NONIT/data/3Month_IT_0-2Y.txt' into table test_ad fields terminated by ',' enclosed by '"' lines terminated by '\n';
select distinct concat(concat(tt.mail_primary,','),tt.first_name) into outfile '/tmp/DATAREQUEST/chandan_email_3Month_IT_0-2Y.txt' from (select ld.mail_primary,ld.first_name from login_dimension ld, resume_dimension rd, test_ad ta where ld.isFakeEmail = 0 and ld.is_unsubscribed_promo is null and rd.net_status = 11 and rd.view_status = 1 and rd.login_key = ld.login_key and ta.ad_id = rd.ad_id order by ld.last_modified_date desc ) tt limit 100000 ;

truncate table test_ad;
load data local infile '/home/dwhuser/IT_NONIT/data/3Month_IT_2-99Y.txt' into table test_ad fields terminated by ',' enclosed by '"' lines terminated by '\n';
select distinct concat(concat(tt.mail_primary,','),tt.first_name) into outfile '/tmp/DATAREQUEST/chandan_email_3Month_IT_2-99Y.txt' from (select ld.mail_primary,ld.first_name from login_dimension ld, resume_dimension rd, test_ad ta where ld.isFakeEmail = 0 and ld.is_unsubscribed_promo is null and rd.net_status = 11 and rd.view_status = 1 and rd.login_key = ld.login_key and ta.ad_id = rd.ad_id order by ld.last_modified_date desc ) tt limit 100000 ;

truncate table test_ad;
load data local infile '/home/dwhuser/IT_NONIT/data/3Month_NonIT_0-2Y.txt' into table test_ad fields terminated by ',' enclosed by '"' lines terminated by '\n';
select distinct concat(concat(tt.mail_primary,','),tt.first_name) into outfile '/tmp/DATAREQUEST/chandan_email_3Month_NonIT_0-2Y.txt' from (select ld.mail_primary,ld.first_name from login_dimension ld, resume_dimension rd, test_ad ta where ld.isFakeEmail = 0 and ld.is_unsubscribed_promo is null and rd.net_status = 11 and rd.view_status = 1 and rd.login_key = ld.login_key and ta.ad_id = rd.ad_id order by ld.last_modified_date desc ) tt limit 100000 ;

truncate table test_ad;
load data local infile '/home/dwhuser/IT_NONIT/data/3Month_NonIT_2-99Y.txt' into table test_ad fields terminated by ',' enclosed by '"' lines terminated by '\n';
select distinct concat(concat(tt.mail_primary,','),tt.first_name) into outfile '/tmp/DATAREQUEST/chandan_email_3Month_NonIT_2-99Y.txt' from (select ld.mail_primary,ld.first_name from login_dimension ld, resume_dimension rd, test_ad ta where ld.isFakeEmail = 0 and ld.is_unsubscribed_promo is null and rd.net_status = 11 and rd.view_status = 1 and rd.login_key = ld.login_key and ta.ad_id = rd.ad_id order by ld.last_modified_date desc ) tt limit 100000 ;

truncate table test_ad;
load data local infile '/home/dwhuser/IT_NONIT/data/4Month_IT_0-2Y.txt' into table test_ad fields terminated by ',' enclosed by '"' lines terminated by '\n';
select distinct concat(concat(tt.mail_primary,','),tt.first_name) into outfile '/tmp/DATAREQUEST/chandan_email_4Month_IT_0-2Y.txt' from (select ld.mail_primary,ld.first_name from login_dimension ld, resume_dimension rd, test_ad ta where ld.isFakeEmail = 0 and ld.is_unsubscribed_promo is null and rd.net_status = 11 and rd.view_status = 1 and rd.login_key = ld.login_key and ta.ad_id = rd.ad_id order by ld.last_modified_date desc ) tt limit 100000 ;

truncate table test_ad;
load data local infile '/home/dwhuser/IT_NONIT/data/4Month_IT_2-99Y.txt' into table test_ad fields terminated by ',' enclosed by '"' lines terminated by '\n';
select distinct concat(concat(tt.mail_primary,','),tt.first_name) into outfile '/tmp/DATAREQUEST/chandan_email_4Month_IT_2-99Y.txt' from (select ld.mail_primary,ld.first_name from login_dimension ld, resume_dimension rd, test_ad ta where ld.isFakeEmail = 0 and ld.is_unsubscribed_promo is null and rd.net_status = 11 and rd.view_status = 1 and rd.login_key = ld.login_key and ta.ad_id = rd.ad_id order by ld.last_modified_date desc ) tt limit 100000 ;

truncate table test_ad;
load data local infile '/home/dwhuser/IT_NONIT/data/4Month_NonIT_0-2Y.txt' into table test_ad fields terminated by ',' enclosed by '"' lines terminated by '\n';
select distinct concat(concat(tt.mail_primary,','),tt.first_name) into outfile '/tmp/DATAREQUEST/chandan_email_4Month_NonIT_0-2Y.txt' from (select ld.mail_primary,ld.first_name from login_dimension ld, resume_dimension rd, test_ad ta where ld.isFakeEmail = 0 and ld.is_unsubscribed_promo is null and rd.net_status = 11 and rd.view_status = 1 and rd.login_key = ld.login_key and ta.ad_id = rd.ad_id order by ld.last_modified_date desc ) tt limit 100000 ;

truncate table test_ad;
load data local infile '/home/dwhuser/IT_NONIT/data/4Month_NonIT_2-99Y.txt' into table test_ad fields terminated by ',' enclosed by '"' lines terminated by '\n';
select distinct concat(concat(tt.mail_primary,','),tt.first_name) into outfile '/tmp/DATAREQUEST/chandan_email_4Month_NonIT_2-99Y.txt' from (select ld.mail_primary,ld.first_name from login_dimension ld, resume_dimension rd, test_ad ta where ld.isFakeEmail = 0 and ld.is_unsubscribed_promo is null and rd.net_status = 11 and rd.view_status = 1 and rd.login_key = ld.login_key and ta.ad_id = rd.ad_id order by ld.last_modified_date desc ) tt limit 100000 ;


