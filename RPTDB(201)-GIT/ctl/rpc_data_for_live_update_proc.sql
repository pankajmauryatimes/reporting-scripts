alter table rpc_data_for_live_update_stage activate not logged initially with empty table

IMPORT FROM  /home/datareq/generic_etl/wip/RPC_DATA.csv  OF DEL insert into rpc_data_for_live_update_stage(mobile_no,rpc_date,source_flag)

