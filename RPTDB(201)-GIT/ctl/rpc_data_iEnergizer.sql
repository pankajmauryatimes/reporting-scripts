alter table CALLING_RPC_DATA_STAGE activate not logged initially with empty table

IMPORT FROM  /home/datareq/generic_etl/wip/Ienergizer_RPC.csv  OF DEL insert into CALLING_RPC_DATA_STAGE(UPDATED_DATE,CENTER_NAME,CAMPAIGN_NAME,MOBILE_NO,RESPONSE,DISPOSITION_STATUS)

