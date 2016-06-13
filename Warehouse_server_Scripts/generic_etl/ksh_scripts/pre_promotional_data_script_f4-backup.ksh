#!/bin/ksh

echo "select distinct tt.mail_primary,tt.cand_name,tt.phone_mobile,tt.mail_primary,tt.work_exp
 from
(select ld.mail_primary,concat(concat(ld.first_name,' '),ld.last_name) as cand_name,ld.phone_mobile,rd.work_exp
 from login_dimension ld,
      resume_dimension rd,
      date_dimension dd
where ld.isFakeEmail = 0
  and ld.is_unsubscribed_promo is null
  and rd.net_status = 11
  and rd.view_status = 1
  and rd.login_key = ld.login_key
  and rd.work_exp = 0 
  and ld.last_modified_date = dd.date_key
  and dd.full_date between CURRENT_date() - inTERVAL 12 month and CURRENT_date() - inTERVAL 7 month
  and ld.mail_primary is not null
  and ld.phone_mobile is not null
 order by ld.last_modified_date desc
 ) tt where tt.cand_name is not null INTO OUTFILE '/tmp/promo_data_0_1_exp_f4_${ddate}.txt' FIELDS TERMINATED BY ',' LINES TERMINATED BY '\\n';" > $HOME/generic_etl/sql_scripts/promotional_data_script_f4.sql

echo "select distinct tt.mail_primary,tt.cand_name,tt.phone_mobile,tt.mail_primary,tt.work_exp
 from
(select ld.mail_primary,concat(concat(ld.first_name,' '),ld.last_name) as cand_name,ld.phone_mobile,rd.work_exp
 from login_dimension ld,
      resume_dimension rd,
      date_dimension dd
where ld.isFakeEmail = 0
  and ld.is_unsubscribed_promo is null
  and rd.net_status = 11
  and rd.view_status = 1
  and rd.login_key = ld.login_key
  and rd.work_exp between 1 and 5
  and ld.last_modified_date = dd.date_key
  and dd.full_date between CURRENT_date() - inTERVAL 12 month and CURRENT_date() - inTERVAL 7 month
 order by ld.last_modified_date desc
 ) tt where tt.cand_name is not null INTO OUTFILE '/tmp/promo_data_1_6_exp_f4_${ddate}.txt' FIELDS TERMINATED BY ',' LINES TERMINATED BY '\\n'; " >> $HOME/generic_etl/sql_scripts/promotional_data_script_f4.sql

echo "select distinct tt.mail_primary,tt.cand_name,tt.phone_mobile,tt.mail_primary,tt.work_exp
 from
(select ld.mail_primary,concat(concat(ld.first_name,' '),ld.last_name) as cand_name,ld.phone_mobile,rd.work_exp
 from login_dimension ld,
      resume_dimension rd,
      date_dimension dd
where ld.isFakeEmail = 0
  and ld.is_unsubscribed_promo is null
  and rd.net_status = 11
  and rd.view_status = 1
  and rd.login_key = ld.login_key
  and rd.work_exp >= 6
  and ld.last_modified_date = dd.date_key
  and dd.full_date between CURRENT_date() - inTERVAL 12 month and CURRENT_date() - inTERVAL 7 month
  and ld.mail_primary is not null
  and ld.phone_mobile is not null
 order by ld.last_modified_date desc
 ) tt where tt.cand_name is not null INTO OUTFILE '/tmp/promo_data_6above_exp_f4_${ddate}.txt' FIELDS TERMINATED BY ',' LINES TERMINATED BY '\\n';">> $HOME/generic_etl/sql_scripts/promotional_data_script_f4.sql

