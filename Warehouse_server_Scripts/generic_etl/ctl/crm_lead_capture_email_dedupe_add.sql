truncate table crm_lead_de_dupe_data_load;
load data local infile '/home/dwhuser//generic_etl/wip/lead/tmp_leadcompdata.txt' into table crm_lead_de_dupe_data_load fields terminated by ',' enclosed by '"' lines terminated by '\n';
insert into crm_lead_de_dupe_data_fact (select email_id,source_desc,date(now()),'A','A' from crm_lead_de_dupe_data_load);
