delete from crm_lead_de_dupe_data_fact where source_desc = 'adhoc_mail';
truncate table crm_lead_de_dupe_data_fact_rm_duplicate;

insert into crm_lead_de_dupe_data_fact_rm_duplicate (email_id,source_desc,modified_date,lead_flg,del_flg)  ( select email_id,source_desc, max(modified_date) as modified_date,lead_flg,del_flg from (select email_id,source_desc, modified_date, case when (lead_flg = 'D' or del_flg = 'D') then 'D' else 'A' end as lead_flg, case when (lead_flg = 'D' or del_flg = 'D') then 'D' else 'A' end as del_flg from crm_lead_de_dupe_data_fact ) lvw group by email_id,source_desc,lead_flg,del_flg having count(1) > 1) ;

delete from crm_lead_de_dupe_data_fact  where (email_id,source_desc) in (select distinct email_id,source_desc from crm_lead_de_dupe_data_fact_rm_duplicate );

insert into crm_lead_de_dupe_data_fact(email_id,source_desc,modified_date,lead_flg,del_flg) (select email_id,source_desc,modified_date,lead_flg,del_flg from crm_lead_de_dupe_data_fact_rm_duplicate);

ALTER TABLE crm_lead_de_dupe_data_fact ENGINE=MyISAM;

REPAIR TABLE crm_lead_de_dupe_data_fact; 
