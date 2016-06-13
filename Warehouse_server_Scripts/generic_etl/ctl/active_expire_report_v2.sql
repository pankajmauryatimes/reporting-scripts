delete from activeexpire_dbservices ;
delete from activeexpire_jobservices;
delete from activeexpiret_otherservices;
delete from activeexpire_visibilityservices;
delete from activeclient_stage_v2;

load data local infile 'REP_Active_Client_details.txt' into table  activeclient_stage_v2 fields terminated by ',' enclosed by '"' lines terminated by '\n';

load data local infile 'REPActiveClient_Active_paid_Database_service.txt' into table  activeexpire_dbservices fields terminated by ',' enclosed by '"' lines terminated by '\n';

load data local infile 'REPActiveClient_Active_paid_Job_posting_service.txt' into table  activeexpire_jobservices fields terminated by ',' enclosed by '"' lines terminated by '\n';

load data local infile 'REPActiveClient_Active_paid_Visibility_service.txt' into table  activeexpire_visibilityservices fields terminated by ',' enclosed by '"' lines terminated by '\n';

load data local infile 'REPActiveClient_Active_paid_Other_service.txt' into table  activeexpiret_otherservices fields terminated by ',' enclosed by '"' lines terminated by '\n';

update activeclient_stage_v2 mrs,activeexpire_dbservices mrd set mrs.AP_Db_Service =mrd.Db_Service,     mrs.AP_db_Expiry_Date=mrd.db_Expiry_Date,     mrs.AP_db_Start_Date=mrd.db_Start_Date where mrs.admin_login_id = mrd.admin_login_id  ;

update activeclient_stage_v2 mrs,activeexpire_jobservices mrj set mrs.AP_job_Service = mrj.job_Service,  mrs.AP_job_Expiry_Date = mrj.job_Expiry_Date, mrs.AP_job_Start_Date = mrj.job_Start_Date where mrs.admin_login_id = mrj.admin_login_id  ;

update activeclient_stage_v2 mrs,activeexpire_visibilityservices mrv  set mrs.AP_visible_Service = mrv.visible_Service, mrs.AP_visible_Expiry_Date = mrv.visible_Expiry_Date, mrs.AP_visible_Start_Date = mrv.visible_Start_Date  where mrs.admin_login_id = mrv.admin_login_id  ;

update activeclient_stage_v2 mrs,activeexpiret_otherservices mro  set mrs.AP_oth_Service = mro.oth_Service, mrs.AP_oth_Expiry_Date = mro.oth_Expiry_Date, mrs.AP_oth_Start_Date = mro.oth_Start_Date where mrs.admin_login_id = mro.admin_login_id ;

update activeclient_stage_v2 mrs set mrs.AP_flag = 'AP' where length(trim(mrs.AP_db_Service)) > 0 ;
update activeclient_stage_v2 mrs set mrs.AP_flag = 'AP' where length(trim(mrs.AP_job_Service)) > 0;
update activeclient_stage_v2 mrs set mrs.AP_flag = 'AP' where length(trim(mrs.AP_visible_Service)) > 0;
update activeclient_stage_v2 mrs set mrs.AP_flag = 'AP' where length(trim(mrs.AP_oth_Service)) > 0 ;

delete from activeexpire_dbservices ;
delete from activeexpire_jobservices;
delete from activeexpire_visibilityservices;
delete from activeexpiret_otherservices;

load data local infile 'REPActiveClient_Active_trial_Database_service.txt' into table  activeexpire_dbservices fields terminated by ',' enclosed by '"' lines terminated by '\n';

load data local infile 'REPActiveClient_Active_trial_Job_posting_service.txt' into table  activeexpire_jobservices fields terminated by ',' enclosed by '"' lines terminated by '\n';

load data local infile 'REPActiveClient_Active_trial_Visibility_service.txt' into table  activeexpire_visibilityservices fields terminated by ',' enclosed by '"' lines terminated by '\n';

load data local infile 'REPActiveClient_Active_trial_Other_service.txt' into table  activeexpiret_otherservices fields terminated by ',' enclosed by '"' lines terminated by '\n';

update activeclient_stage_v2 mrs,activeexpire_dbservices mrd  set mrs.AT_Db_Service =mrd.Db_Service,mrs.AT_db_Expiry_Date=mrd.db_Expiry_Date,mrs.AT_db_Start_Date=mrd.db_Start_Date where mrs.admin_login_id = mrd.admin_login_id  ;

update activeclient_stage_v2 mrs,activeexpire_jobservices mrj set mrs.AT_job_Service = mrj.job_Service, mrs.AT_job_Expiry_Date = mrj.job_Expiry_Date, mrs.AT_job_Start_Date = mrj.job_Start_Date where mrs.admin_login_id = mrj.admin_login_id  ;

update activeclient_stage_v2 mrs,activeexpire_visibilityservices mrv  set mrs.AT_visible_Service = mrv.visible_Service, mrs.AT_visible_Expiry_Date = mrv.visible_Expiry_Date, mrs.AT_visible_Start_Date = mrv.visible_Start_Date where mrs.admin_login_id = mrv.admin_login_id  ;

update activeclient_stage_v2 mrs,activeexpiret_otherservices mro  set mrs.AT_oth_Service = mro.oth_Service,mrs.AT_oth_Expiry_Date = mro.oth_Expiry_Date, mrs.AT_oth_Start_Date = mro.oth_Start_Date where mrs.admin_login_id = mro.admin_login_id ;

update activeclient_stage_v2 mrs set mrs.AT_flag = 'AT' where length(trim(mrs.AT_db_Service)) > 0 ;
update activeclient_stage_v2 mrs set mrs.AT_flag = 'AT' where length(trim(mrs.AT_job_Service)) > 0;
update activeclient_stage_v2 mrs set mrs.AT_flag = 'AT' where length(trim(mrs.AT_visible_Service)) > 0;
update activeclient_stage_v2 mrs set mrs.AT_flag = 'AT' where length(trim(mrs.AT_oth_Service)) > 0;

delete from activeexpire_dbservices ;
delete from activeexpire_jobservices;
delete from activeexpire_visibilityservices;
delete from activeexpiret_otherservices;

load data local infile 'REPActiveClient_Deactive_paid_Database_service.txt' into table  activeexpire_dbservices fields terminated by ',' enclosed by '"' lines terminated by '\n';

load data local infile 'REPActiveClient_Deactive_paid_Job_posting_service.txt' into table  activeexpire_jobservices fields terminated by ',' enclosed by '"' lines terminated by '\n';

load data local infile 'REPActiveClient_Deactive_paid_Visibility_service.txt' into table  activeexpire_visibilityservices fields terminated by ',' enclosed by '"' lines terminated by '\n';

load data local infile 'REPActiveClient_Deactive_paid_Other_service.txt' into table  activeexpiret_otherservices fields terminated by ',' enclosed by '"' lines terminated by '\n';


update activeclient_stage_v2 mrs,activeexpire_dbservices mrd  set mrs.DP_Db_Service =mrd.Db_Service, mrs.DP_db_Expiry_Date=mrd.db_Expiry_Date, mrs.DP_db_Start_Date=mrd.db_Start_Date where mrs.admin_login_id = mrd.admin_login_id  ;

update activeclient_stage_v2 mrs,activeexpire_jobservices mrj set mrs.DP_job_Service = mrj.job_Service,  mrs.DP_job_Expiry_Date = mrj.job_Expiry_Date, mrs.DP_job_Start_Date = mrj.job_Start_Date where mrs.admin_login_id = mrj.admin_login_id  ;

update activeclient_stage_v2 mrs,activeexpire_visibilityservices mrv  set mrs.DP_visible_Service = mrv.visible_Service, mrs.DP_visible_Expiry_Date = mrv.visible_Expiry_Date, mrs.DP_visible_Start_Date = mrv.visible_Start_Date  where mrs.admin_login_id = mrv.admin_login_id  ;

update activeclient_stage_v2 mrs,activeexpiret_otherservices mro  set mrs.DP_oth_Service = mro.oth_Service, mrs.DP_oth_Expiry_Date = mro.oth_Expiry_Date, mrs.DP_oth_Start_Date = mro.oth_Start_Date  where mrs.admin_login_id = mro.admin_login_id ;

update activeclient_stage_v2 mrs set mrs.DP_flag = 'DP' where length(trim(mrs.DP_db_Service)) > 0;
update activeclient_stage_v2 mrs set mrs.DP_flag = 'DP' where length(trim(mrs.DP_job_Service)) > 0;
update activeclient_stage_v2 mrs set mrs.DP_flag = 'DP' where length(trim(mrs.DP_visible_Service)) > 0;
update activeclient_stage_v2 mrs set mrs.DP_flag = 'DP' where length(trim(mrs.DP_oth_Service)) > 0;

delete from activeexpire_dbservices ;
delete from activeexpire_jobservices;
delete from activeexpire_visibilityservices;
delete from activeexpiret_otherservices;

load data local infile 'REPActiveClient_Deactive_trial_Database_service.txt' into table  activeexpire_dbservices fields terminated by ',' enclosed by '"' lines terminated by '\n';

load data local infile 'REPActiveClient_Deactive_trial_Job_posting_service.txt' into table  activeexpire_jobservices fields terminated by ',' enclosed by '"' lines terminated by '\n';

load data local infile 'REPActiveClient_Deactive_trial_Visibility_service.txt' into table  activeexpire_visibilityservices fields terminated by ',' enclosed by '"' lines terminated by '\n';

load data local infile 'REPActiveClient_Deactive_trial_Other_service.txt' into table  activeexpiret_otherservices fields terminated by ',' enclosed by '"' lines terminated by '\n';

update activeclient_stage_v2 mrs,activeexpire_dbservices mrd  set mrs.DT_Db_Service =mrd.Db_Service, mrs.DT_db_Expiry_Date=mrd.db_Expiry_Date, mrs.DT_db_Start_Date=mrd.db_Start_Date where mrs.admin_login_id = mrd.admin_login_id  ; 

update activeclient_stage_v2 mrs,activeexpire_jobservices mrj set mrs.DT_job_Service = mrj.job_Service,  mrs.DT_job_Expiry_Date = mrj.job_Expiry_Date, mrs.DT_job_Start_Date = mrj.job_Start_Date where mrs.admin_login_id = mrj.admin_login_id  ;

update activeclient_stage_v2 mrs,activeexpire_visibilityservices mrv  set mrs.DT_visible_Service = mrv.visible_Service, mrs.DT_visible_Expiry_Date = mrv.visible_Expiry_Date, mrs.DT_visible_Start_Date = mrv.visible_Start_Date  where mrs.admin_login_id = mrv.admin_login_id  ;

update activeclient_stage_v2 mrs,activeexpiret_otherservices mro  set mrs.DT_oth_Service = mro.oth_Service, mrs.DT_oth_Expiry_Date = mro.oth_Expiry_Date, mrs.DT_oth_Start_Date = mro.oth_Start_Date  where mrs.admin_login_id = mro.admin_login_id ;

update activeclient_stage_v2 mrs set mrs.DT_flag = 'DT' where length(trim(mrs.DT_db_Service)) > 0;
update activeclient_stage_v2 mrs set mrs.DT_flag = 'DT' where length(trim(mrs.DT_job_Service)) > 0;
update activeclient_stage_v2 mrs set mrs.DT_flag = 'DT' where length(trim(mrs.DT_visible_Service)) > 0;
update activeclient_stage_v2 mrs set mrs.DT_flag = 'DT' where length(trim(mrs.DT_oth_Service)) > 0;

insert into activeclient_fact_v2(Admin_Login_Id,Company_Name,Company_Cons_Internal,Address,Location_Key,Location,Contact_Person,Designation ,Contact_Alt ,Contact_Off ,Email_Id,Industry,Expiry_Month,Expiry_Date ,Start_Date,Sales_Person_Email ,Vertical_ID ,Account_ID,ZMEmailID ,DB_Search ,Resume_Viewed ,Active_Jobs ,New_Jobs,Expired_Jobs,Excel_download ,DB_LSC_ALLOCATED,WORD_RESUME_DOWNLOAD,AP_Db_Service ,AP_DB_Expiry_Date,AP_DB_Start_Date ,AP_job_Service,AP_job_Expiry_Date ,AP_job_Start_Date,AP_visible_Service ,AP_visible_Expiry_Date	,AP_visible_Start_Date,AP_oth_Service,AP_oth_Expiry_Date ,AP_oth_Start_Date,AP_flag,AT_Db_Service ,AT_DB_Expiry_Date,AT_DB_Start_Date ,AT_job_Service,AT_job_Expiry_Date ,AT_job_Start_Date,AT_visible_Service ,AT_visible_Expiry_Date	,AT_visible_Start_Date,AT_oth_Service,AT_oth_Expiry_Date ,AT_oth_Start_Date,AT_flag ,DP_Db_Service ,DP_DB_Expiry_Date,DP_DB_Start_Date ,DP_job_Service,DP_job_Expiry_Date ,DP_job_Start_Date,DP_visible_Service ,DP_visible_Expiry_Date	,DP_visible_Start_Date,DP_oth_Service,DP_oth_Expiry_Date ,DP_oth_Start_Date,DP_flag ,DT_Db_Service ,DT_DB_Expiry_Date,DT_DB_Start_Date ,DT_job_Service,DT_job_Expiry_Date ,DT_job_Start_Date,DT_visible_Service ,DT_visible_Expiry_Date	,DT_visible_Start_Date,DT_oth_Service,DT_oth_Expiry_Date ,DT_oth_Start_Date,DT_flag,PAY_MODE,create_date) select Admin_Login_Id,Company_Name,Company_Cons_Internal,Address,Location_Key,Location,Contact_Person,Designation ,Contact_Alt ,Contact_Off ,Email_Id,Industry,Expiry_Month,Expiry_Date ,Start_Date,Sales_Person_Email ,Vertical_ID ,Account_ID,ZMEmailID ,DB_Search ,Resume_Viewed ,Active_Jobs ,New_Jobs,Expired_Jobs,Excel_download ,DB_LSC_ALLOCATED,WORD_RESUME_DOWNLOAD,AP_Db_Service ,AP_DB_Expiry_Date,AP_DB_Start_Date ,AP_job_Service,AP_job_Expiry_Date ,AP_job_Start_Date,AP_visible_Service ,AP_visible_Expiry_Date	,AP_visible_Start_Date,AP_oth_Service,AP_oth_Expiry_Date ,AP_oth_Start_Date,AP_flag,AT_Db_Service ,AT_DB_Expiry_Date,AT_DB_Start_Date ,AT_job_Service,AT_job_Expiry_Date ,AT_job_Start_Date,AT_visible_Service ,AT_visible_Expiry_Date	,AT_visible_Start_Date,AT_oth_Service,AT_oth_Expiry_Date ,AT_oth_Start_Date,AT_flag ,DP_Db_Service ,DP_DB_Expiry_Date,DP_DB_Start_Date ,DP_job_Service,DP_job_Expiry_Date ,DP_job_Start_Date,DP_visible_Service ,DP_visible_Expiry_Date	,DP_visible_Start_Date,DP_oth_Service,DP_oth_Expiry_Date ,DP_oth_Start_Date,DP_flag ,DT_Db_Service ,DT_DB_Expiry_Date,DT_DB_Start_Date ,DT_job_Service,DT_job_Expiry_Date ,DT_job_Start_Date,DT_visible_Service ,DT_visible_Expiry_Date	,DT_visible_Start_Date,DT_oth_Service,DT_oth_Expiry_Date ,DT_oth_Start_Date,DT_flag,PAY_MODE,date(now()) from activeclient_stage_v2;

delete from activeexpire_dbservices ;
delete from activeexpire_jobservices;
delete from activeexpiret_otherservices;
delete from activeexpire_visibilityservices;
delete from expireclient_stage_v2;

load data local infile 'REP_Expired_Client_details.txt' into table  expireclient_stage_v2 fields terminated by ',' enclosed by '"' lines terminated by '\n';

load data local infile 'REP_Expired_Client_Active_paid_Database_service.txt' into table  activeexpire_dbservices fields terminated by ',' enclosed by '"' lines terminated by '\n';

load data local infile 'REP_Expired_Client_Active_paid_Job_posting_service.txt' into table  activeexpire_jobservices fields terminated by ',' enclosed by '"' lines terminated by '\n';

load data local infile 'REP_Expired_Client_Active_paid_Visibility_service.txt' into table  activeexpire_visibilityservices fields terminated by ',' enclosed by '"' lines terminated by '\n';

load data local infile 'REP_Expired_Client_Active_paid_Other_service.txt' into table  activeexpiret_otherservices fields terminated by ',' enclosed by '"' lines terminated by '\n';

update expireclient_stage_v2 mrs,activeexpire_dbservices mrd set mrs.AP_Db_Service =mrd.Db_Service,     mrs.AP_db_Expiry_Date=mrd.db_Expiry_Date,     mrs.AP_db_Start_Date=mrd.db_Start_Date where mrs.admin_login_id = mrd.admin_login_id  ;

update expireclient_stage_v2 mrs,activeexpire_jobservices mrj set mrs.AP_job_Service = mrj.job_Service,  mrs.AP_job_Expiry_Date = mrj.job_Expiry_Date, mrs.AP_job_Start_Date = mrj.job_Start_Date where mrs.admin_login_id = mrj.admin_login_id  ;

update expireclient_stage_v2 mrs,activeexpire_visibilityservices mrv  set mrs.AP_visible_Service = mrv.visible_Service, mrs.AP_visible_Expiry_Date = mrv.visible_Expiry_Date, mrs.AP_visible_Start_Date = mrv.visible_Start_Date  where mrs.admin_login_id = mrv.admin_login_id  ;

update expireclient_stage_v2 mrs,activeexpiret_otherservices mro  set mrs.AP_oth_Service = mro.oth_Service, mrs.AP_oth_Expiry_Date = mro.oth_Expiry_Date, mrs.AP_oth_Start_Date = mro.oth_Start_Date where mrs.admin_login_id = mro.admin_login_id ;

update expireclient_stage_v2 mrs set mrs.AP_flag = 'AP' where length(trim(mrs.AP_db_Service)) > 0 ;
update expireclient_stage_v2 mrs set mrs.AP_flag = 'AP' where length(trim(mrs.AP_job_Service)) > 0;
update expireclient_stage_v2 mrs set mrs.AP_flag = 'AP' where length(trim(mrs.AP_visible_Service)) > 0;
update expireclient_stage_v2 mrs set mrs.AP_flag = 'AP' where length(trim(mrs.AP_oth_Service)) > 0 ;

delete from activeexpire_dbservices ;
delete from activeexpire_jobservices;
delete from activeexpire_visibilityservices;
delete from activeexpiret_otherservices;

load data local infile 'REP_Expired_Client_Active_trial_Database_service.txt' into table  activeexpire_dbservices fields terminated by ',' enclosed by '"' lines terminated by '\n';

load data local infile 'REP_Expired_Client_Active_trial_Job_posting_service.txt' into table  activeexpire_jobservices fields terminated by ',' enclosed by '"' lines terminated by '\n';

load data local infile 'REP_Expired_Client_Active_trial_Visibility_service.txt' into table  activeexpire_visibilityservices fields terminated by ',' enclosed by '"' lines terminated by '\n';

load data local infile 'REP_Expired_Client_Active_trial_Other_service.txt' into table  activeexpiret_otherservices fields terminated by ',' enclosed by '"' lines terminated by '\n';

update expireclient_stage_v2 mrs,activeexpire_dbservices mrd  set mrs.AT_Db_Service =mrd.Db_Service,mrs.AT_db_Expiry_Date=mrd.db_Expiry_Date,mrs.AT_db_Start_Date=mrd.db_Start_Date where mrs.admin_login_id = mrd.admin_login_id  ;

update expireclient_stage_v2 mrs,activeexpire_jobservices mrj set mrs.AT_job_Service = mrj.job_Service, mrs.AT_job_Expiry_Date = mrj.job_Expiry_Date, mrs.AT_job_Start_Date = mrj.job_Start_Date where mrs.admin_login_id = mrj.admin_login_id  ;

update expireclient_stage_v2 mrs,activeexpire_visibilityservices mrv  set mrs.AT_visible_Service = mrv.visible_Service, mrs.AT_visible_Expiry_Date = mrv.visible_Expiry_Date, mrs.AT_visible_Start_Date = mrv.visible_Start_Date where mrs.admin_login_id = mrv.admin_login_id  ;

update expireclient_stage_v2 mrs,activeexpiret_otherservices mro  set mrs.AT_oth_Service = mro.oth_Service,mrs.AT_oth_Expiry_Date = mro.oth_Expiry_Date, mrs.AT_oth_Start_Date = mro.oth_Start_Date where mrs.admin_login_id = mro.admin_login_id ;

update expireclient_stage_v2 mrs set mrs.AT_flag = 'AT' where length(trim(mrs.AT_db_Service)) > 0 ;
update expireclient_stage_v2 mrs set mrs.AT_flag = 'AT' where length(trim(mrs.AT_job_Service)) > 0;
update expireclient_stage_v2 mrs set mrs.AT_flag = 'AT' where length(trim(mrs.AT_visible_Service)) > 0;
update expireclient_stage_v2 mrs set mrs.AT_flag = 'AT' where length(trim(mrs.AT_oth_Service)) > 0;

delete from activeexpire_dbservices ;
delete from activeexpire_jobservices;
delete from activeexpire_visibilityservices;
delete from activeexpiret_otherservices;

load data local infile 'REP_Expired_Client_Deactive_paid_Database_service.txt' into table  activeexpire_dbservices fields terminated by ',' enclosed by '"' lines terminated by '\n';

load data local infile 'REP_Expired_Client_Deactive_paid_Job_posting_service.txt' into table  activeexpire_jobservices fields terminated by ',' enclosed by '"' lines terminated by '\n';

load data local infile 'REP_Expired_Client_Deactive_paid_Visibility_service.txt' into table  activeexpire_visibilityservices fields terminated by ',' enclosed by '"' lines terminated by '\n';

load data local infile 'REP_Expired_Client_Deactive_paid_Other_service.txt' into table  activeexpiret_otherservices fields terminated by ',' enclosed by '"' lines terminated by '\n';


update expireclient_stage_v2 mrs,activeexpire_dbservices mrd  set mrs.DP_Db_Service =mrd.Db_Service, mrs.DP_db_Expiry_Date=mrd.db_Expiry_Date, mrs.DP_db_Start_Date=mrd.db_Start_Date where mrs.admin_login_id = mrd.admin_login_id  ;

update expireclient_stage_v2 mrs,activeexpire_jobservices mrj set mrs.DP_job_Service = mrj.job_Service,  mrs.DP_job_Expiry_Date = mrj.job_Expiry_Date, mrs.DP_job_Start_Date = mrj.job_Start_Date where mrs.admin_login_id = mrj.admin_login_id  ;

update expireclient_stage_v2 mrs,activeexpire_visibilityservices mrv  set mrs.DP_visible_Service = mrv.visible_Service, mrs.DP_visible_Expiry_Date = mrv.visible_Expiry_Date, mrs.DP_visible_Start_Date = mrv.visible_Start_Date  where mrs.admin_login_id = mrv.admin_login_id  ;

update expireclient_stage_v2 mrs,activeexpiret_otherservices mro  set mrs.DP_oth_Service = mro.oth_Service, mrs.DP_oth_Expiry_Date = mro.oth_Expiry_Date, mrs.DP_oth_Start_Date = mro.oth_Start_Date  where mrs.admin_login_id = mro.admin_login_id ;

update expireclient_stage_v2 mrs set mrs.DP_flag = 'DP' where length(trim(mrs.DP_db_Service)) > 0;
update expireclient_stage_v2 mrs set mrs.DP_flag = 'DP' where length(trim(mrs.DP_job_Service)) > 0;
update expireclient_stage_v2 mrs set mrs.DP_flag = 'DP' where length(trim(mrs.DP_visible_Service)) > 0;
update expireclient_stage_v2 mrs set mrs.DP_flag = 'DP' where length(trim(mrs.DP_oth_Service)) > 0;

delete from activeexpire_dbservices ;
delete from activeexpire_jobservices;
delete from activeexpire_visibilityservices;
delete from activeexpiret_otherservices;

load data local infile 'REP_Expired_Client_Deactive_trial_Database_service.txt' into table  activeexpire_dbservices fields terminated by ',' enclosed by '"' lines terminated by '\n';

load data local infile 'REP_Expired_Client_Deactive_trial_Job_posting_service.txt' into table  activeexpire_jobservices fields terminated by ',' enclosed by '"' lines terminated by '\n';

load data local infile 'REP_Expired_Client_Deactive_trial_Visibility_service.txt' into table  activeexpire_visibilityservices fields terminated by ',' enclosed by '"' lines terminated by '\n';

load data local infile 'REP_Expired_Client_Deactive_trial_Other_service.txt' into table  activeexpiret_otherservices fields terminated by ',' enclosed by '"' lines terminated by '\n';

update expireclient_stage_v2 mrs,activeexpire_dbservices mrd  set mrs.DT_Db_Service =mrd.Db_Service, mrs.DT_db_Expiry_Date=mrd.db_Expiry_Date, mrs.DT_db_Start_Date=mrd.db_Start_Date where mrs.admin_login_id = mrd.admin_login_id  ; 

update expireclient_stage_v2 mrs,activeexpire_jobservices mrj set mrs.DT_job_Service = mrj.job_Service,  mrs.DT_job_Expiry_Date = mrj.job_Expiry_Date, mrs.DT_job_Start_Date = mrj.job_Start_Date where mrs.admin_login_id = mrj.admin_login_id  ;

update expireclient_stage_v2 mrs,activeexpire_visibilityservices mrv  set mrs.DT_visible_Service = mrv.visible_Service, mrs.DT_visible_Expiry_Date = mrv.visible_Expiry_Date, mrs.DT_visible_Start_Date = mrv.visible_Start_Date  where mrs.admin_login_id = mrv.admin_login_id  ;

update expireclient_stage_v2 mrs,activeexpiret_otherservices mro  set mrs.DT_oth_Service = mro.oth_Service, mrs.DT_oth_Expiry_Date = mro.oth_Expiry_Date, mrs.DT_oth_Start_Date = mro.oth_Start_Date  where mrs.admin_login_id = mro.admin_login_id ;

update expireclient_stage_v2 mrs set mrs.DT_flag = 'DT' where length(trim(mrs.DT_db_Service)) > 0;
update expireclient_stage_v2 mrs set mrs.DT_flag = 'DT' where length(trim(mrs.DT_job_Service)) > 0;
update expireclient_stage_v2 mrs set mrs.DT_flag = 'DT' where length(trim(mrs.DT_visible_Service)) > 0;
update expireclient_stage_v2 mrs set mrs.DT_flag = 'DT' where length(trim(mrs.DT_oth_Service)) > 0;

insert into expireclient_fact_v2(Admin_Login_Id,Company_Name,Company_Cons_Internal,Address,Location_Key,Location,Contact_Person,Designation ,Contact_Alt ,Contact_Off ,Email_Id,Industry,Expiry_Month,Expiry_Date ,Start_Date,Sales_Person_Email ,Vertical_ID ,Account_ID,ZMEmailID ,DB_Search ,Resume_Viewed ,Active_Jobs ,New_Jobs,Expired_Jobs,AP_Db_Service ,AP_DB_Expiry_Date,AP_DB_Start_Date ,AP_job_Service,AP_job_Expiry_Date ,AP_job_Start_Date,AP_visible_Service ,AP_visible_Expiry_Date	,AP_visible_Start_Date,AP_oth_Service,AP_oth_Expiry_Date ,AP_oth_Start_Date,AP_flag,AT_Db_Service ,AT_DB_Expiry_Date,AT_DB_Start_Date ,AT_job_Service,AT_job_Expiry_Date ,AT_job_Start_Date,AT_visible_Service ,AT_visible_Expiry_Date	,AT_visible_Start_Date,AT_oth_Service,AT_oth_Expiry_Date ,AT_oth_Start_Date,AT_flag ,DP_Db_Service ,DP_DB_Expiry_Date,DP_DB_Start_Date ,DP_job_Service,DP_job_Expiry_Date ,DP_job_Start_Date,DP_visible_Service ,DP_visible_Expiry_Date	,DP_visible_Start_Date,DP_oth_Service,DP_oth_Expiry_Date ,DP_oth_Start_Date,DP_flag ,DT_Db_Service ,DT_DB_Expiry_Date,DT_DB_Start_Date ,DT_job_Service,DT_job_Expiry_Date ,DT_job_Start_Date,DT_visible_Service ,DT_visible_Expiry_Date	,DT_visible_Start_Date,DT_oth_Service,DT_oth_Expiry_Date ,DT_oth_Start_Date,DT_flag,PAY_MODE,create_date) select Admin_Login_Id,Company_Name,Company_Cons_Internal,Address,Location_Key,Location,Contact_Person,Designation ,Contact_Alt ,Contact_Off ,Email_Id,Industry,Expiry_Month,Expiry_Date ,Start_Date,Sales_Person_Email ,Vertical_ID ,Account_ID,ZMEmailID ,DB_Search ,Resume_Viewed ,Active_Jobs ,New_Jobs,Expired_Jobs,AP_Db_Service ,AP_DB_Expiry_Date,AP_DB_Start_Date ,AP_job_Service,AP_job_Expiry_Date ,AP_job_Start_Date,AP_visible_Service ,AP_visible_Expiry_Date	,AP_visible_Start_Date,AP_oth_Service,AP_oth_Expiry_Date ,AP_oth_Start_Date,AP_flag,AT_Db_Service ,AT_DB_Expiry_Date,AT_DB_Start_Date ,AT_job_Service,AT_job_Expiry_Date ,AT_job_Start_Date,AT_visible_Service ,AT_visible_Expiry_Date	,AT_visible_Start_Date,AT_oth_Service,AT_oth_Expiry_Date ,AT_oth_Start_Date,AT_flag ,DP_Db_Service ,DP_DB_Expiry_Date,DP_DB_Start_Date ,DP_job_Service,DP_job_Expiry_Date ,DP_job_Start_Date,DP_visible_Service ,DP_visible_Expiry_Date	,DP_visible_Start_Date,DP_oth_Service,DP_oth_Expiry_Date ,DP_oth_Start_Date,DP_flag ,DT_Db_Service ,DT_DB_Expiry_Date,DT_DB_Start_Date ,DT_job_Service,DT_job_Expiry_Date ,DT_job_Start_Date,DT_visible_Service ,DT_visible_Expiry_Date	,DT_visible_Start_Date,DT_oth_Service,DT_oth_Expiry_Date ,DT_oth_Start_Date,DT_flag,PAY_MODE,date(now()) from expireclient_stage_v2;

