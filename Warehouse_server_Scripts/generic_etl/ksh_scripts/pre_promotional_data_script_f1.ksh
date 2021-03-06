#!/bin/ksh

echo "select distinct tt.mail_primary,tt.cand_name,tt.phone_mobile,tt.mail_primary,tt.work_exp
 from
(select ld.mail_primary,concat(concat(ld.first_name,' '),ld.last_name) as cand_name,ld.phone_mobile,rd.work_exp
 from login_dimension ld,
      resume_dimension rd
where ld.isFakeEmail = 0
  and (ld.is_unsubscribed_cs is null or ld.is_unsubscribed_cs=0)
  and rd.net_status = 11
  and rd.view_status = 1
  and rd.login_key = ld.login_key
  and rd.work_exp between 2 and 3
 and ld.last_modified_date >= (select date_key from date_dimension where full_date= CURRENT_date() - inTERVAL 12 month)
  and ld.mail_primary is not null
  and ld.phone_mobile is not null
 order by ld.last_modified_date desc
 ) tt  where tt.cand_name is not null INTO OUTFILE '/tmp/promotional_data_F1_${ddate}.txt' FIELDS TERMINATED BY ',' LINES TERMINATED BY '\\n'; " > $HOME/generic_etl/sql_scripts/promotional_data_script_f1.sql
