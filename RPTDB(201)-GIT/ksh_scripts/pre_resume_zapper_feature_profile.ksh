#!/usr/bin/ksh

today=`date +%d%b%y`

echo "export to /home/datareq/generic_etl/wip/RESUME_ZAPPER_FEATURE_PROFILE_$today.csv of del modified by coldel, datesiso  select FROM_EMAIL, SUBJECT,MSG_CONTENT ,DATE(CREATED) AS SEND_DATE,COUNT(TO_EMAIL) as counts from ECM_RECRUITER_RESPONSE   where created between char(current date - 1 day,ISO)||' 00:00:00.0000' and char(current date,ISO)||' 23:59:59.9999'  group by FROM_EMAIL, SUBJECT,MSG_CONTENT ,DATE(CREATED) having count(TO_EMAIL) >= 20  with ur" > /home/datareq/generic_etl/sql_scripts/resume_zapper_feature_profile.sql
