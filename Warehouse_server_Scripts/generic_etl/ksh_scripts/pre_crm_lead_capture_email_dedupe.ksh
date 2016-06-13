#!/bin/ksh

set +x

cd $HOME/generic_etl/wip/
export today=`date +%d%b%Y`

rm -f /tmp/crm_lead_souce_file_${today}.txt
rm -f /tmp/scp_file.ftp


#ADD NEW LEADS
$HOME/generic_etl/ksh_scripts/crm_lead_capture_email_dedupe_221_add.ksh > $HOME/generic_etl/logs/crm_lead_capture_email_dedupe_221_add1.log
$HOME/generic_etl/ksh_scripts/crm_lead_capture_email_dedupe_221_add2.ksh > $HOME/generic_etl/logs/crm_lead_capture_email_dedupe_221_add2.log
#De-Dupe 
$HOME/generic_etl/ksh_scripts/crm_lead_capture_email_dedupe_221_del.ksh > $HOME/generic_etl/logs/crm_lead_capture_email_dedupe_221_del.log

echo "select distinct source_desc into outfile '/tmp/crm_lead_souce_file_${today}.txt' from crm_lead_de_dupe_data_fact ; 

update crm_lead_de_dupe_data_fact cl set del_flg = 'D' where exists (select 1 from login_dimension ld where ld.mail_primary = trim(cl.email_id) and  (ld.isFakeEmail = 1 or ld.is_unsubscribed_promo =1));

update crm_lead_de_dupe_data_fact cl set del_flg = 'D' where exists (select 1 from EMP_UNSUBMAIL_TABLE_FACT eut where eut.EMAIL_ID =  cl.email_id and eut.PROMO_STATUS = 'N' ) ;

update crm_lead_de_dupe_data_fact cl set del_flg = 'A' where exists (select 1 from EMP_UNSUBMAIL_TABLE_FACT eut where  eut.EMAIL_ID =  cl.email_id and eut.PROMO_STATUS = 'Y' ) ;" > $HOME/generic_etl/ctl/crm_lead_capture_email_dedupe.sql

cd $LOAD_DIR
${CONFIG_DIR}/_run_sqlldr.ksh ${MYSQL_USER} ${MYSQL_DB} ${CTL_FILE} ${LOG_DIR}/${LOG_FILE} MYSQL
cd -

rm -f $HOME/generic_etl/ctl/crm_lead_capture_email_dedupe.sql

export ftp_file=/tmp/scp_file.ftp
echo "#!/bin/ksh" > $ftp_file
echo "HOST=$ip" >> $ftp_file
echo "USER=$user" >> $ftp_file
echo "PASSWD=$pswd" >> $ftp_file
echo "ftp -in \$HOST <<EOF" >> $ftp_file
echo "quote USER \$USER" >> $ftp_file
echo "quote PASS \$PASSWD" >> $ftp_file
echo "binary" >> $ftp_file
echo "cd $ftp_dir" >> $ftp_file
echo "pwd" >> $ftp_file
#echo "del *" >> $ftp_file
for i in `cat /tmp/crm_lead_souce_file_${today}.txt`
do
   echo "select distinct trim(email_id) into outfile '/tmp/${i}.txt' from crm_lead_de_dupe_data_fact where source_desc='${i}' and lead_flg = 'A' and del_flg = 'A' ;" >> $HOME/generic_etl/ctl/crm_lead_capture_email_dedupe.sql
   echo "del ${i}.txt" >> $ftp_file
   echo "put ${i}.txt" >> $ftp_file
   rm -f /tmp/${i}.txt
done

echo "quit" >> $ftp_file
echo "EOF" >> $ftp_file

echo "delete from crm_lead_de_dupe_data_fact where source_desc = 'adhoc_mail';
truncate table crm_lead_de_dupe_data_fact_rm_duplicate;

insert into crm_lead_de_dupe_data_fact_rm_duplicate (email_id,source_desc,modified_date,lead_flg,del_flg)  ( select email_id,source_desc, max(modified_date) as modified_date,lead_flg,del_flg from (select email_id,source_desc, modified_date, case when (lead_flg = 'D' or del_flg = 'D') then 'D' else 'A' end as lead_flg, case when (lead_flg = 'D' or del_flg = 'D') then 'D' else 'A' end as del_flg from crm_lead_de_dupe_data_fact ) lvw group by email_id,source_desc,lead_flg,del_flg having count(1) > 1) ;

delete from crm_lead_de_dupe_data_fact  where (email_id,source_desc) in (select distinct email_id,source_desc from crm_lead_de_dupe_data_fact_rm_duplicate );

insert into crm_lead_de_dupe_data_fact(email_id,source_desc,modified_date,lead_flg,del_flg) (select email_id,source_desc,modified_date,lead_flg,del_flg from crm_lead_de_dupe_data_fact_rm_duplicate);

ALTER TABLE crm_lead_de_dupe_data_fact ENGINE=MyISAM;

REPAIR TABLE crm_lead_de_dupe_data_fact; " > $HOME/generic_etl/sql_scripts/crm_lead_capture_email_dedupe.sql

