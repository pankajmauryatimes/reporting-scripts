#!/usr/bin/ksh

set +x

echo "export to $HOME/generic_etl/wip/daily_applicants_${f_date}.csv of del modified by coldel, datesiso select distinct T.LOGIN_ID from (select ua.LOGIN_ID from SITE_INBOX_RESPONSE sir join USER_AD ua on ua.AD_ID = sir.RESUME_ID where sir.DATE_RESPONDED = current date - 1 DAY and ua.NET_STATUS in (11, 20) union select ua.LOGIN_ID from EXTERNAL_JOB_RESPONSE ejr join USER_AD ua on ua.AD_ID = ejr.RESUME_ID where ejr.DATE_RESPONDED between char(current date - 1 day,ISO)||' 00:00:00' and char(current date - 1 day,ISO)||' 23:59:59' and ua.NET_STATUS in (11, 20)) T with ur

export to  $HOME/generic_etl/wip/daily_logins_${f_date}.csv of del modified by coldel, datesiso select distinct u.login_id from USER u join USER_AD ua on u.LOGIN_ID = ua.LOGIN_ID join RCRT_RESUME_ADS rra on ua.AD_ID = rra.AD_ID where u.AGENT = 'I' and ua.NET_STATUS in (11, 20) and u.LAST_LOGIN_DATE = current date - 1 DAY and rra.SAVED_RESUME_PATH is not null with ur

export to  $HOME/generic_etl/wip/daily_profile_edits_${f_date}.csv of del modified by coldel, datesiso select distinct ua.LOGIN_ID from USER_AD ua join RCRT_RESUME_ADS rra on ua.AD_ID = rra.AD_ID where ua.SUB_CAT_ID = 2711 and ua.NET_STATUS in (11, 20) and ua.LAST_MODIFIED_TIME between char(current date - 1 day,ISO)||' 00:00:00' and char(current date - 1 day,ISO)||' 23:59:59' except select distinct ua.LOGIN_ID from USER_AD ua join RCRT_RESUME_ADS_EXTENSION rra on ua.AD_ID = rra.AD_ID where ua.SUB_CAT_ID = 2711 and ua.NET_STATUS in (11, 20) and rra.DOC_MODIFIED_DATETIME between char(current date - 1 day,ISO)||' 00:00:00' and char(current date - 1 day,ISO)||' 23:59:59' with ur" > $HOME/generic_etl/sql_scripts/active_DB_verification.sql

