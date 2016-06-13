delete from weekly_report_stage;

delete from weekly_report_stage_1;

delete from weekly_report_dbservices;

delete from weekly_report_jobservices;

delete from weekly_report_visibilityservices;

delete from weekly_report_otherservices;

load data local infile 'ALL_Weekely_REPActiveClient_Details_NEW_changed.txt' into table  weekly_report_stage_1 fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

insert into weekly_report_stage(Client_Name,Account_Id,Vertical_Id,Industry,Admin_Login_Id,Acc_User_DB_access,Last_activation_date,Last_expiry_date,Online_products_active,logins_per_day_in_last_week,logins_per_day_in_last_month,Active_Jobs,New_Jobs_posted_in_last_week,New_Jobs_posted_in_last_month,Total_Expired_Jobs,Jobs_expired_in_last_week,Jobs_expired_in_last_month,searches_per_day_in_last_week,searches_per_day_in_last_month,resume_views_per_day_in_last_week,resume_views_per_day_in_last_month,Excel_Download_Last_Week,Excel_Download_Last_Month,Location,Contact_Person,Designation,Contact_Landline,Contact_Mobile,Client_Email_Id,Sales_Person_Email_ID,ZM_Email_ID,col1,col2,col3,col4,col5,col6,col7,col8,col9,col10,col11,col12,col13,col14,col15,col16,col17,col18,col19,col20,col21,col22,col23,col24,col25,col26) select * from weekly_report_stage_1;

load data local infile 'ALL_Weekely_REPActiveClient_Active_paid_Database_service.txt' into table  weekly_report_dbservices fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

load data local infile 'ALL_Weekely_REPActiveClient_Active_paid_Job_posting_service.txt' into table  weekly_report_jobservices fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

load data local infile 'ALL_Weekely_REPActiveClient_Active_paid_Visibility_service.txt' into table  weekly_report_visibilityservices fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

load data local infile 'ALL_Weekely_REPActiveClient_Active_paid_Other_service.txt' into table  weekly_report_otherservices fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

update weekly_report_stage wrs,weekly_report_otherservices wro  set wrs.pd_oth_Service = wro.oth_Service,     wrs.pd_oth_Expiry_Date = wro.oth_Expiry_Date,     wrs.pd_oth_Start_Date = wro.oth_Start_Date where wrs.admin_login_id = wro.admin_login_id  ;

update weekly_report_stage wrs,weekly_report_visibilityservices wrv  set wrs.pd_visible_Service = wrv.visible_Service,     wrs.pd_visible_Expiry_Date = wrv.visible_Expiry_Date,     wrs.pd_visible_Start_Date = wrv.visible_Start_Date where wrs.admin_login_id = wrv.admin_login_id  ;

update weekly_report_stage wrs,weekly_report_jobservices wrj  set wrs.pd_job_Service = wrj.job_Service,     wrs.pd_job_Expiry_Date = wrj.job_Expiry_Date,     wrs.pd_job_Start_Date = wrj.job_Start_Date where wrs.admin_login_id = wrj.admin_login_id  ;

update weekly_report_stage wrs,weekly_report_dbservices wrd  set wrs.pd_Db_Service =wrd.Db_Service,     wrs.pd_db_Expiry_Date=wrd.db_Expiry_Date,     wrs.pd_db_Start_Date=wrd.db_Start_Date where wrs.admin_login_id = wrd.admin_login_id  ;

update weekly_report_stage wrs,weekly_report_dbservices wrd  set wrs.pd_flag = 'AP' where wrs.admin_login_id = wrd.admin_login_id and length(trim(wrs.pd_Db_Service)) > 0  ;

update weekly_report_stage wrs,weekly_report_otherservices wro  set wrs.pd_flag = 'AP' where wrs.admin_login_id = wro.admin_login_id and length(trim(wrs.pd_oth_Service)) > 0   ;

update weekly_report_stage wrs,weekly_report_visibilityservices wrv  set wrs.pd_flag = 'AP' where wrs.admin_login_id = wrv.admin_login_id and length(trim(wrs.pd_visible_Service)) > 0  ;

update weekly_report_stage wrs,weekly_report_jobservices wrj  set wrs.pd_flag = 'AP' where wrs.admin_login_id = wrj.admin_login_id and length(trim(wrs.pd_job_Service)) > 0 ;

delete from weekly_report_dbservices;

delete from weekly_report_jobservices;

delete from weekly_report_visibilityservices;

delete from weekly_report_otherservices;


load data local infile 'ALL_Weekely_REPActiveClient_Active_trial_Database_service.txt' into table  weekly_report_dbservices fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

load data local infile 'ALL_Weekely_REPActiveClient_Active_trial_Job_posting_service.txt' into table  weekly_report_jobservices fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

load data local infile 'ALL_Weekely_REPActiveClient_Active_trial_Visibility_service.txt' into table  weekly_report_visibilityservices fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

load data local infile 'ALL_Weekely_REPActiveClient_Active_paid_Other_service.txt' into table  weekly_report_otherservices fields terminated by ',' enclosed by '"' lines terminated by '\r\n';


update weekly_report_stage wrs,weekly_report_otherservices wro  set wrs.tr_oth_Service = wro.oth_Service,     wrs.tr_oth_Expiry_Date = wro.oth_Expiry_Date,     wrs.tr_oth_Start_Date = wro.oth_Start_Date where wrs.admin_login_id = wro.admin_login_id  ;

update weekly_report_stage wrs,weekly_report_visibilityservices wrv  set wrs.tr_visible_Service = wrv.visible_Service,     wrs.tr_visible_Expiry_Date = wrv.visible_Expiry_Date,     wrs.tr_visible_Start_Date = wrv.visible_Start_Date where wrs.admin_login_id = wrv.admin_login_id  ;

update weekly_report_stage wrs,weekly_report_jobservices wrj  set wrs.tr_job_Service = wrj.job_Service,     wrs.tr_job_Expiry_Date = wrj.job_Expiry_Date,     wrs.tr_job_Start_Date = wrj.job_Start_Date where wrs.admin_login_id = wrj.admin_login_id  ;

update weekly_report_stage wrs,weekly_report_dbservices wrd  set wrs.tr_Db_Service =wrd.Db_Service,     wrs.tr_db_Expiry_Date=wrd.db_Expiry_Date,     wrs.tr_db_Start_Date=wrd.db_Start_Date where wrs.admin_login_id = wrd.admin_login_id  ;

update weekly_report_stage wrs,weekly_report_jobservices wrj  set wrs.tr_flag = 'AT' where wrs.admin_login_id = wrj.admin_login_id and length(trim(wrs.tr_job_Service)) > 0  ;

update weekly_report_stage wrs,weekly_report_dbservices wrd  set wrs.tr_flag = 'AT' where wrs.admin_login_id = wrd.admin_login_id and length(trim(wrs.tr_db_Service)) > 0  ;

update weekly_report_stage wrs,weekly_report_visibilityservices wrv  set wrs.tr_flag = 'AT' where wrs.admin_login_id = wrv.admin_login_id and length(trim(wrs.tr_visible_Service)) > 0  ;

update weekly_report_stage wrs,weekly_report_otherservices wro  set wrs.tr_flag = 'AT' where wrs.admin_login_id = wro.admin_login_id and length(trim(wrs.tr_oth_Service)) > 0   ;

insert into weekly_report_fact(Client_Name,Account_Id,Vertical_Id,Industry,Admin_Login_Id,Acc_User_DB_access,Last_activation_date,Last_expiry_date,Online_products_active,logins_per_day_in_last_week,logins_per_day_in_last_month,Active_Jobs,New_Jobs_posted_in_last_week,New_Jobs_posted_in_last_month,Total_Expired_Jobs,Jobs_expired_in_last_week,Jobs_expired_in_last_month,searches_per_day_in_last_week,searches_per_day_in_last_month,resume_views_per_day_in_last_week,resume_views_per_day_in_last_month,Excel_Download_Last_Week,Excel_Download_Last_Month,Location,Contact_Person,Designation,Contact_Landline,Contact_Mobile,Client_Email_Id,Sales_Person_Email_ID,ZM_Email_ID,col1,col2,col3,col4,col5,col6,col7,col8,col9,col10,col11,col12,col13,col14,col15,col16,col17,col18,col19,col20,col21,col22,col23,col24,col25,col26,pd_Db_Service,pd_db_Expiry_Date,pd_db_Start_Date,pd_job_Service,pd_job_Expiry_Date,pd_job_Start_Date,pd_visible_Service,pd_visible_Expiry_Date,pd_visible_Start_Date,pd_oth_Service,pd_oth_Expiry_Date,pd_oth_Start_Date,pd_flag,tr_Db_Service,tr_db_Expiry_Date,tr_db_Start_Date,tr_job_Service,tr_job_Expiry_Date,tr_job_Start_Date,tr_visible_Service,tr_visible_Expiry_Date,tr_visible_Start_Date,tr_oth_Service,tr_oth_Expiry_Date,tr_oth_Start_Date,tr_flag,create_date) select Client_Name,Account_Id,Vertical_Id,Industry,Admin_Login_Id,Acc_User_DB_access,Last_activation_date,Last_expiry_date,Online_products_active,logins_per_day_in_last_week,logins_per_day_in_last_month,Active_Jobs,New_Jobs_posted_in_last_week,New_Jobs_posted_in_last_month,Total_Expired_Jobs,Jobs_expired_in_last_week,Jobs_expired_in_last_month,searches_per_day_in_last_week,searches_per_day_in_last_month,resume_views_per_day_in_last_week,resume_views_per_day_in_last_month,Excel_Download_Last_Week,Excel_Download_Last_Month,Location,Contact_Person,Designation,Contact_Landline,Contact_Mobile,Client_Email_Id,Sales_Person_Email_ID,ZM_Email_ID,col1,col2,col3,col4,col5,col6,col7,col8,col9,col10,col11,col12,col13,col14,col15,col16,col17,col18,col19,col20,col21,col22,col23,col24,col25,col26,pd_Db_Service,pd_db_Expiry_Date,pd_db_Start_Date,pd_job_Service,pd_job_Expiry_Date,pd_job_Start_Date,pd_visible_Service,pd_visible_Expiry_Date,pd_visible_Start_Date,pd_oth_Service,pd_oth_Expiry_Date,pd_oth_Start_Date,pd_flag,tr_Db_Service,tr_db_Expiry_Date,tr_db_Start_Date,tr_job_Service,tr_job_Expiry_Date,tr_job_Start_Date,tr_visible_Service,tr_visible_Expiry_Date,tr_visible_Start_Date,tr_oth_Service,tr_oth_Expiry_Date,tr_oth_Start_Date,tr_flag,date(now()) from weekly_report_stage;

--select '"',Client_Name,'","',Account_Id,'","',Vertical_Id,'","',Industry,'","',Admin_Login_Id,'","',Acc_User_DB_access,'","',Last_activation_date,'","',Last_expiry_date,'","',Online_products_active,'","',logins_per_day_in_last_week,'","',logins_per_day_in_last_month,'","',Active_Jobs,'","',New_Jobs_posted_in_last_week,'","',New_Jobs_posted_in_last_month,'","',Total_Expired_Jobs,'","',Jobs_expired_in_last_week,'","',Jobs_expired_in_last_month,'","',searches_per_day_in_last_week,'","',searches_per_day_in_last_month,'","',resume_views_per_day_in_last_week,'","',resume_views_per_day_in_last_month,'","',Excel_Download_Last_Week,'","',Excel_Download_Last_Month,'","',pd_Db_Service,'","',pd_db_Expiry_Date,'","',pd_db_Start_Date,'","',pd_job_Service,'","',pd_job_Expiry_Date,'","',pd_job_Start_Date,'","',pd_visible_Service,'","',pd_visible_Expiry_Date,'","',pd_visible_Start_Date,'","',pd_oth_Service,'","',pd_oth_Expiry_Date,'","',pd_oth_Start_Date,'","',pd_flag,'","',tr_Db_Service,'","',tr_db_Expiry_Date,'","',tr_db_Start_Date,'","',tr_job_Service,'","',tr_job_Expiry_Date,'","',tr_job_Start_Date,'","',tr_visible_Service,'","',tr_visible_Expiry_Date,'","',tr_visible_Start_Date,'","',tr_oth_Service,'","',tr_oth_Expiry_Date,'","',tr_oth_Start_Date,'","',tr_flag,'","',Location,'","',Contact_Person,'","',Designation,'","',Contact_Landline,'","',Contact_Mobile,'","',Client_Email_Id,'","',Sales_Person_Email_ID,'","',ZM_Email_ID,'","',col1,'","',col2,'","',col3,'","',col4,'","',col5,'","',col6,'","',col7,'","',col8,'","',col9,'","',col10,'","',col11,'","',col12,'","',col13,'","',col14,'","',col15,'","',col16,'","',col17,'","',col18,'","',col19,'","',col20,'","',col21,'","',col22,'","',col23,'","',col24,'","',col25,'","',col26,'"'  into outfile '/tmp/weeklyReport_30May12.csv' from weekly_report_fact where create_date='2012-05-30';

