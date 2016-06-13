#!/usr/bin/ksh

today=`date +%d%b%y`

dos2unix /home/datareq/generic_etl/wip/Spam_$today.txt
sed -i '/^$/d' /home/datareq/generic_etl/wip/Spam_$today.txt

echo "alter table TEMP_RESUME_FEATURE_EMAIL activate not logged initially with empty table" > /home/datareq/generic_etl/sql_scripts/resume_feature_spam.sql
echo "import from /home/datareq/generic_etl/wip/Spam_$today.txt of del insert into TEMP_RESUME_FEATURE_EMAIL" >> /home/datareq/generic_etl/sql_scripts/resume_feature_spam.sql
echo "MERGE INTO ECM_RECRUITER_SPAM AS ers USING (select trfe.EMAIL_ID from  TEMP_RESUME_FEATURE_EMAIL trfe ) AS cmp ON (ers.FROM_EMAIL = cmp.EMAIL_ID) WHEN MATCHED THEN UPDATE SET ers.spam_status='Y', ers.updated=current timestamp WHEN NOT MATCHED THEN INSERT (ers.FROM_EMAIL,ers.SPAM_STATUS,ers.created,ers.updated) VALUES(cmp.email_id,'Y',current timestamp,CURRENT TIMESTAMP)" >> /home/datareq/generic_etl/sql_scripts/resume_feature_spam.sql
