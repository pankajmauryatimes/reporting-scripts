select  distinct tt.mail_primary,tt.cand_name,tt.phone_mobile,tt.mail_primary,tt.work_exp
 from
(select ld.mail_primary,concat(concat(ld.first_name,' '),ld.last_name) as cand_name,ld.phone_mobile,rd.work_exp
 from login_dimension ld,
      resume_dimension rd,
      temp_F8_ad_ids tai
    where ld.isFakeEmail = 0
  and (ld.is_unsubscribed_cs is null or ld.is_unsubscribed_cs=0)
  and rd.net_status = 11
  and rd.view_status = 1
  and rd.login_key = ld.login_key
  and rd.ad_id=tai.ad_id
  and ld.mail_primary is not null
  and ld.phone_mobile is not null
  and rd.work_exp between 4 and 99
 ) tt where tt.cand_name is not null INTO OUTFILE '/tmp/promotional_data_F8_11Jun2016.txt' FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';
