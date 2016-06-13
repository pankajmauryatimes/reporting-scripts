#!/bin/ksh

echo "select distinct tt.mail_primary,tt.cand_name,tt.phone_mobile,tt.mail_primary,tt.work_exp
 from
(select ld.mail_primary,concat(concat(ld.first_name,' '),ld.last_name) as cand_name,ld.phone_mobile,rd.work_exp
 from login_dimension ld,
      resume_dimension rd
where ld.isFakeEmail = 0
  and (ld.is_unsubscribed_promo is null or ld.is_unsubscribed_promo=0)
  and rd.net_status = 11
  and rd.view_status = 1
  and rd.login_key = ld.login_key
  and rd.work_exp between 0 and 3
 and exists (select 1 from date_dimension dd where dd.full_date between current_date() - interval 24 month and current_date - inTERVAL 12 month and ld.last_modified_date = dd.date_key)
  and ld.mail_primary is not null
  and ld.phone_mobile is not null
 order by ld.last_modified_date desc
 ) tt  where tt.cand_name is not null INTO OUTFILE '/tmp/promotional_data_F7_${ddate}.txt' FIELDS TERMINATED BY ',' LINES TERMINATED BY '\\n';"> $HOME/generic_etl/sql_scripts/promotional_data_script_f7.sql
