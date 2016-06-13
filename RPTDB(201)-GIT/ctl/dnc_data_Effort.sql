alter table CALLING_DNC_DATA_STAGE activate not logged initially with empty table

IMPORT FROM  /home/datareq/generic_etl/wip/Effort_DNC_daily.csv OF DEL insert into CALLING_DNC_DATA_STAGE(MOBILE_NO)

update CALLING_DNC_DATA_STAGE  set MOBILE_NO ='91'||MOBILE_NO

