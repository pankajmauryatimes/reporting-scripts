alter table HOURLY_APPLICATION_REPORT_TMP activate not logged initially with empty table

IMPORT FROM /home/datareq/generic_etl/logs/web_application_flat.txt OF DEL insert into HOURLY_APPLICATION_REPORT_TMP
insert into HOURLY_APPLICATION_REPORT_TMP(SOURCE_ID,SOURCE_CODE,NATIVE_JOBS_COUNT,TRANSCRIBED_JOBS_COUNT) select 1,'TOTAL',coalesce(sum(NATIVE_JOBS_COUNT),0),coalesce(sum(TRANSCRIBED_JOBS_COUNT),0) from HOURLY_APPLICATION_REPORT_TMP WHERE SOURCE_ID =1  
IMPORT FROM /home/datareq/generic_etl/logs/mob_application_flat.txt OF DEL insert into HOURLY_APPLICATION_REPORT_TMP
insert into HOURLY_APPLICATION_REPORT_TMP(SOURCE_ID,SOURCE_CODE,NATIVE_JOBS_COUNT,TRANSCRIBED_JOBS_COUNT) select 2,'TOTAL',coalesce(sum(NATIVE_JOBS_COUNT),0),coalesce(sum(TRANSCRIBED_JOBS_COUNT),0) from HOURLY_APPLICATION_REPORT_TMP WHERE SOURCE_ID = 2
IMPORT FROM /home/datareq/generic_etl/logs/other_application_flat.txt OF DEL insert into HOURLY_APPLICATION_REPORT_TMP
insert into HOURLY_APPLICATION_REPORT_TMP(SOURCE_ID,SOURCE_CODE,NATIVE_JOBS_COUNT,TRANSCRIBED_JOBS_COUNT) select 3,'TOTAL',coalesce(sum(NATIVE_JOBS_COUNT),0),coalesce(sum(TRANSCRIBED_JOBS_COUNT),0) from HOURLY_APPLICATION_REPORT_TMP WHERE SOURCE_ID =3 

export to /home/datareq/generic_etl/logs/web_application.txt of del modified by coldel, datesiso select CASE WHEN har.SOURCE_CODE = 'TOTAL' then left('** '||har.SOURCE_CODE||' **',20) else left(har.SOURCE_CODE,20) end||' '||left(coalesce(jas.SOURCE_DESC,' '),40)||' '||left(char(har.NATIVE_JOBS_COUNT),10)||' '|| left(char(har.TRANSCRIBED_JOBS_COUNT),5) AS STR from HOURLY_APPLICATION_REPORT_TMP har left join JOB_APPLICATION_SOURCE_LOOKUP jas on (har.SOURCE_CODE = jas.SOURCE_CODE) WHERE har.SOURCE_ID =1 with ur

export to /home/datareq/generic_etl/logs/mob_application.txt of del modified by coldel, datesiso select CASE WHEN har.SOURCE_CODE = 'TOTAL' then left('** '||har.SOURCE_CODE||' **',20) else left(har.SOURCE_CODE,20) end||' '||left(coalesce(jas.SOURCE_DESC,' '),40)||' '||left(char(har.NATIVE_JOBS_COUNT),10)||' '|| left(char(har.TRANSCRIBED_JOBS_COUNT),5) AS STR from HOURLY_APPLICATION_REPORT_TMP har left join JOB_APPLICATION_SOURCE_LOOKUP jas on (har.SOURCE_CODE = jas.SOURCE_CODE) WHERE har.SOURCE_ID =2 with ur

export to /home/datareq/generic_etl/logs/other_application.txt of del modified by coldel, datesiso select CASE WHEN har.SOURCE_CODE = 'TOTAL' then left('** '||har.SOURCE_CODE||' **',20) else left(har.SOURCE_CODE,20) end||' '||left(coalesce(jas.SOURCE_DESC,' '),40)||' '||left(char(har.NATIVE_JOBS_COUNT),10)||' '|| left(char(har.TRANSCRIBED_JOBS_COUNT),5) AS STR from HOURLY_APPLICATION_REPORT_TMP har left join JOB_APPLICATION_SOURCE_LOOKUP jas on (har.SOURCE_CODE = jas.SOURCE_CODE) WHERE har.SOURCE_ID =3 with ur

export to /home/datareq/generic_etl/logs/application_by_source.csv of del modified by coldel, datesiso select har.SOURCE_CODE ,jas.SOURCE_DESC,har.NATIVE_JOBS_COUNT,har.TRANSCRIBED_JOBS_COUNT from HOURLY_APPLICATION_REPORT_TMP har left join JOB_APPLICATION_SOURCE_LOOKUP jas on (har.SOURCE_CODE = jas.SOURCE_CODE) with ur
