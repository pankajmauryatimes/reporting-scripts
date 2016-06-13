export to /home/datareq/generic_etl/wip/apps_status_till_date_daily_load.csv of del modified by coldel, datesiso select 1,T.source, sum(T.Native_counts) as Native_counts ,sum(Trans_counts) as Trans_counts from ( select feature_name as source, count(1) as Native_counts,0 as Trans_counts from SITE_INBOX_RESPONSE where date_responded = current date -1 day and trim(feature_name) in ('APLCNF_REC', 'TJPFSRP', 'TJMLR', 'TJJD', 'TJSEO', 'TJ_INBOX', 'TJAJD', 'TJPFBJ', 'TJPF', 'RECJOB', 'REC_RPN_JD', 'TJCAND_SJM', 'SIMJ_JD', 'TG', 'TJSRP', 'TJSRP_MULTI', 'TJPFRV', 'TJMLR_HIRE', 'JB', 'TJPFSJ', 'EJM', 'TJJD_LKD_LOG', 'TJJD_LKD_REG', 'WALKIN', 'EMAIL', 'JBAD', 'Others') group by feature_name  union select trim(SIR.FEATURE_NAME) as source,0 as Native_counts, count(1) as Trans_counts from (select UA.AD_ID from USER_AD UA, ADMIN_GROUPUSER_MAP agm where UA.SUB_CAT_ID = 2710 and agm.LOGIN_SRL_NO = ua.LOGIN_SRL_NO and agm.ADMIN_LOGIN_ID =  'tj_externaljobs_2' ) T, EXTERNAL_JOB_RESPONSE SIR where SIR.JOB_ID = T.AD_ID and SIR.DATE_RESPONDED between char(current date -1 day,ISO)||' 00:00:00.00' and char(current date -1 day,ISO)||' 23:59:59.99' and trim(SIR.FEATURE_NAME) in ('APLCNF_REC', 'TJPFSRP', 'TJMLR', 'TJJD', 'TJSEO', 'TJ_INBOX', 'TJAJD', 'TJPFBJ', 'TJPF', 'RECJOB', 'REC_RPN_JD', 'TJCAND_SJM', 'SIMJ_JD', 'TG', 'TJSRP', 'TJSRP_MULTI', 'TJPFRV', 'TJMLR_HIRE', 'JB', 'TJPFSJ', 'EJM', 'TJJD_LKD_LOG', 'TJJD_LKD_REG', 'WALKIN', 'EMAIL', 'JBAD', 'Others') group by trim(SIR.FEATURE_NAME) ) T group by T.source union select 2,T.source, sum(T.Native_counts) as Native_counts ,sum(Trans_counts) as Trans_counts from ( select feature_name as source, count(1) as Native_counts,0 as Trans_counts from SITE_INBOX_RESPONSE where date_responded = current date -1 day and trim(feature_name) in ('TJIOS_SRP','TJIOS_RECO','TJIOS_JOBDET','TJIOS_JOBDET_SIMJOB','TJIOS_JA_EMPLOYER','TJIOS_JA_NOTIFI','TJIOS_JOB_LOC','TJIOS_JOB_SKILL','TJIOS_JOB_FA','TJMOB_JA_EMPLOYER','TJMOB_JOB_INDUSTRY','TJMOB_RECO','TJMOB','TJMOB_JOBDET','TJMOB_JOBDET_SIMJOB','TJMOB_SRP','TJIOS','TJMOB_JOB_SKILL','TJMOB_JA_NOTIFI','TJMOB_JOB_LOC','TJMOB_JOB_FA','TJMOB_LAST_SR','TJ_J2ME','TJMOB (Others)','TJANDRD','TJANDRD_SRP','TJANDRD_JOBDET','TJANDRD_SIMJOB','TJANDRD_LAST_SR','TJANDRD_RECO','TJANDRD_JA_NOTIFI','TJANDRD_JA_EMPLOYER','TJANDRD_JOB_LOC','TJANDRD_JOB_SKILL','TJANDRD_JOB_FA','TJANDRD_JOB_INDUSTRY','TJANDRD_JOBDET_SIMJOB') group by feature_name union select trim(SIR.FEATURE_NAME) as source, 0 as Native_counts, count(1) as trans_counts from (select UA.AD_ID from USER_AD UA, ADMIN_GROUPUSER_MAP agm where UA.SUB_CAT_ID = 2710 and agm.LOGIN_SRL_NO = ua.LOGIN_SRL_NO and agm.ADMIN_LOGIN_ID =  'tj_externaljobs_2') T, EXTERNAL_JOB_RESPONSE SIR where SIR.JOB_ID = T.AD_ID and SIR.DATE_RESPONDED between char(current date -1 day,ISO)||' 00:00:00.00' and char(current date -1 day,ISO)||' 23:59:59.99' and trim(SIR.FEATURE_NAME) in ('TJIOS_SRP','TJIOS_RECO','TJIOS_JOBDET','TJIOS_JOBDET_SIMJOB','TJIOS_JA_EMPLOYER','TJIOS_JA_NOTIFI','TJIOS_JOB_LOC','TJIOS_JOB_SKILL','TJIOS_JOB_FA','TJMOB_JA_EMPLOYER','TJMOB_JOB_INDUSTRY','TJMOB_RECO','TJMOB','TJMOB_JOBDET','TJMOB_JOBDET_SIMJOB','TJMOB_SRP','TJIOS','TJMOB_JOB_SKILL','TJMOB_JA_NOTIFI','TJMOB_JOB_LOC','TJMOB_JOB_FA','TJMOB_LAST_SR','TJ_J2ME','TJMOB (Others)','TJANDRD','TJANDRD_SRP','TJANDRD_JOBDET','TJANDRD_SIMJOB','TJANDRD_LAST_SR','TJANDRD_RECO','TJANDRD_JA_NOTIFI','TJANDRD_JA_EMPLOYER','TJANDRD_JOB_LOC','TJANDRD_JOB_SKILL','TJANDRD_JOB_FA','TJANDRD_JOB_INDUSTRY','TJANDRD_JOBDET_SIMJOB') group by trim(SIR.FEATURE_NAME)  ) T group by T.source union select 3,T.source, sum(T.Native_counts) as Native_counts ,sum(Trans_counts) as Trans_counts from ( select feature_name as source,     count(1) as Native_counts,0 as trans_counts from SITE_INBOX_RESPONSE where date_responded = current date -1 day and trim(feature_name) not in ('TJIOS_SRP','TJIOS_RECO','TJIOS_JOBDET','TJIOS_JOBDET_SIMJOB','TJIOS_JA_EMPLOYER','TJIOS_JA_NOTIFI','TJIOS_JOB_LOC','TJIOS_JOB_SKILL','TJIOS_JOB_FA','TJMOB_JA_EMPLOYER','TJMOB_JOB_INDUSTRY','TJMOB_RECO','TJMOB','TJMOB_JOBDET','TJMOB_JOBDET_SIMJOB','TJMOB_SRP','TJIOS','TJMOB_JOB_SKILL','TJMOB_JA_NOTIFI','TJMOB_JOB_LOC','TJMOB_JOB_FA','TJMOB_LAST_SR','TJ_J2ME','TJMOB (Others)','TJANDRD','TJANDRD_SRP','TJANDRD_JOBDET','TJANDRD_SIMJOB','TJANDRD_LAST_SR','TJANDRD_RECO','TJANDRD_JA_NOTIFI','TJANDRD_JA_EMPLOYER','TJANDRD_JOB_LOC','TJANDRD_JOB_SKILL','TJANDRD_JOB_FA','TJANDRD_JOB_INDUSTRY','TJANDRD_JOBDET_SIMJOB','APLCNF_REC', 'TJPFSRP', 'TJMLR', 'TJJD', 'TJSEO', 'TJ_INBOX', 'TJAJD', 'TJPFBJ', 'TJPF', 'RECJOB', 'REC_RPN_JD', 'TJCAND_SJM', 'SIMJ_JD', 'TG', 'TJSRP', 'TJSRP_MULTI', 'TJPFRV', 'TJMLR_HIRE', 'JB', 'TJPFSJ', 'EJM', 'TJJD_LKD_LOG', 'TJJD_LKD_REG', 'WALKIN', 'EMAIL', 'JBAD', 'Others') group by feature_name union select trim(SIR.FEATURE_NAME) as source,0 as Native_counts, count(1) as trans_counts from (select UA.AD_ID from USER_AD UA, ADMIN_GROUPUSER_MAP agm where UA.SUB_CAT_ID = 2710 and agm.LOGIN_SRL_NO = ua.LOGIN_SRL_NO and agm.ADMIN_LOGIN_ID =  'tj_externaljobs_2') T, EXTERNAL_JOB_RESPONSE SIR where SIR.JOB_ID = T.AD_ID and SIR.DATE_RESPONDED between char(current date -1 day,ISO)||' 00:00:00.00' and char(current date -1 day,ISO)||' 23:59:59.99' and trim(SIR.FEATURE_NAME) not in ('TJIOS_SRP','TJIOS_RECO','TJIOS_JOBDET','TJIOS_JOBDET_SIMJOB','TJIOS_JA_EMPLOYER','TJIOS_JA_NOTIFI','TJIOS_JOB_LOC','TJIOS_JOB_SKILL','TJIOS_JOB_FA','TJMOB_JA_EMPLOYER','TJMOB_JOB_INDUSTRY','TJMOB_RECO','TJMOB','TJMOB_JOBDET','TJMOB_JOBDET_SIMJOB','TJMOB_SRP','TJIOS','TJMOB_JOB_SKILL','TJMOB_JA_NOTIFI','TJMOB_JOB_LOC','TJMOB_JOB_FA','TJMOB_LAST_SR','TJ_J2ME','TJMOB (Others)','TJANDRD','TJANDRD_SRP','TJANDRD_JOBDET','TJANDRD_SIMJOB','TJANDRD_LAST_SR','TJANDRD_RECO','TJANDRD_JA_NOTIFI','TJANDRD_JA_EMPLOYER','TJANDRD_JOB_LOC','TJANDRD_JOB_SKILL','TJANDRD_JOB_FA','TJANDRD_JOB_INDUSTRY','TJANDRD_JOBDET_SIMJOB','APLCNF_REC', 'TJPFSRP', 'TJMLR', 'TJJD', 'TJSEO', 'TJ_INBOX', 'TJAJD', 'TJPFBJ', 'TJPF', 'RECJOB', 'REC_RPN_JD', 'TJCAND_SJM', 'SIMJ_JD', 'TG', 'TJSRP', 'TJSRP_MULTI', 'TJPFRV', 'TJMLR_HIRE', 'JB', 'TJPFSJ', 'EJM', 'TJJD_LKD_LOG', 'TJJD_LKD_REG', 'WALKIN', 'EMAIL', 'JBAD', 'Others') group by trim(SIR.FEATURE_NAME) ) T group by T.source with ur

export to /home/datareq/generic_etl/wip/apps_status_till_date_daily.csv of del modified by coldel, datesiso select DATE_RESPONDED,SOURCE ,COUNTS from (select date_responded,feature_name as source, count(1) as counts from SITE_INBOX_RESPONSE where date_responded = current date -1 day group by date_responded,feature_name UNION select date(SIR.DATE_RESPONDED) as DATE_RESPONDED,'TRANSCRIBED JOBS' as source, count(sir.RESUME_ID) as counts from USER_AD UA, EXTERNAL_JOB_RESPONSE SIR ,ADMIN_GROUPUSER_MAP agm where agm.LOGIN_SRL_NO = ua.LOGIN_SRL_NO and agm.ADMIN_LOGIN_ID =  'tj_externaljobs_2' and SIR.JOB_ID = UA.AD_ID and SIR.DATE_RESPONDED between char(current date -1 day,ISO)||' 00:00:00.00' and char(current date -1 day,ISO)||' 23:59:59.99' group by date(SIR.DATE_RESPONDED) UNION select date(SIR.DATE_RESPONDED) as DATE_RESPONDED, case upper(trim(SIR.FEATURE_NAME)) when 'TJANDRD' then 'TRANSCRIBED JOBS' || ' - TJANDRD' when 'TJMOB' then 'TRANSCRIBED JOBS' || ' - TJMOB' when 'TJIOS' then 'TRANSCRIBED JOBS' || ' - TJIOS' else 'TRANSCRIBED JOBS' || ' - OTHER' end as source, count(sir.RESUME_ID) as counts from USER_AD UA, EXTERNAL_JOB_RESPONSE SIR ,ADMIN_GROUPUSER_MAP agm where agm.LOGIN_SRL_NO = ua.LOGIN_SRL_NO and agm.ADMIN_LOGIN_ID =  'tj_externaljobs_2' and SIR.JOB_ID = UA.AD_ID and SIR.DATE_RESPONDED between char(current date -1 day,ISO)||' 00:00:00.00' and char(current date -1 day,ISO)||' 23:59:59.99' group by date(SIR.DATE_RESPONDED), case upper(trim(SIR.FEATURE_NAME)) when 'TJANDRD' then 'TRANSCRIBED JOBS' || ' - TJANDRD' when 'TJMOB' then 'TRANSCRIBED JOBS' || ' - TJMOB' when 'TJIOS' then 'TRANSCRIBED JOBS' || ' - TJIOS' else 'TRANSCRIBED JOBS' || ' - OTHER' end ) A with ur