#!/usr/bin/ksh

set +x

echo "export to $HOME/generic_etl/wip/tj_webservices_usages_${f_date}_A.csv of del modified by coldel, datesiso select COUNT(1) as COUNT,SERVICE_NAME,SOURCE from TJ_WEBSERVICES_USAGES where CALL_TIME between char(((CURRENT DATE - (DAY(CURRENT DATE) - 1) DAYS) - 1 MONTH),ISO)||' 00:00:00.00' and char((((CURRENT DATE - (DAY(CURRENT DATE) - 1) DAYS)) - 1 DAY),ISO)||' 23:59:59.99' GROUP BY SERVICE_NAME,SOURCE with ur 

export to $HOME/generic_etl/wip/tj_webservices_usages_${f_date}_B.csv of del modified by coldel, datesiso select distinct LOGIN_ID,SOURCE from TJ_WEBSERVICES_USAGES where CALL_TIME between char(((CURRENT DATE - (DAY(CURRENT DATE) - 1) DAYS) - 1 MONTH),ISO)||' 00:00:00.00' and char((((CURRENT DATE - (DAY(CURRENT DATE) - 1) DAYS)) - 1 DAY),ISO)||' 23:59:59.99' with ur

export to $HOME/generic_etl/wip/MOBILE_USAGE_TRACK_${f_date}_C.csv of del modified by coldel, datesiso select * from MOBILE_USAGE_TRACK where MODIFY_DATE between char(((CURRENT DATE - (DAY(CURRENT DATE) - 1) DAYS) - 1 MONTH),ISO)||' 00:00:00.00' and char((((CURRENT DATE - (DAY(CURRENT DATE) - 1) DAYS)) - 1 DAY),ISO)||' 23:59:59.99'  with ur

export to $HOME/generic_etl/wip/career_services_lead_MOB_${f_date}_D.csv of del modified by coldel, datesiso select date(CAPTURE_TIME) as CAPTURE_TIME,Feature_name,source, count(1) as count from LEAD_CAPTURE_BY_SOURCE where CAPTURE_TIME between char(((CURRENT DATE - (DAY(CURRENT DATE) - 1) DAYS) - 1 MONTH),ISO)||' 00:00:00.00' and char((((CURRENT DATE - (DAY(CURRENT DATE) - 1) DAYS)) - 1 DAY),ISO)||' 23:59:59.99' Group by date(capture_time),Feature_name,source with ur " > $HOME/generic_etl/sql_scripts/monthly_report_tj_mobile.sql 



