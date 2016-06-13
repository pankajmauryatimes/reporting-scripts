#!/bin/ksh

set +x

cd ${LOAD_DIR}
scp root@115.112.206.86:/var/ftp-rpc-dat/wyzmindz-download-data/${DATA_FILE} .
if [[ -r ${DATA_FILE} ]]
  then
      grep 'E+' ${DATA_FILE} > RPC_JUNK_DATA_${last_day}.csv
      sed -i '/E+/d' ${DATA_FILE}
      grep '-' ${DATA_FILE} > RPC_DATA.csv
      sed -i '/Phone,/d'  RPC_DATA.csv
      mv  RPC_JUNK_DATA_${last_day}.csv $HOME/generic_etl/data_archive/
      
else
      txt_body="Hi All,

Source RPC File did not found for Databse update on location
Server: 115.112.206.86
Location: /var/ftp-rpc-dat/wyzmindz-download-data/
File Name: ${DATA_FILE}

Regards & Thanks,
RPT Databse Server."
  
     #$mutt APPLICATION_STATUS_TILL_DATE_v2 "$tmail" "$cmail" "$cur_proc_name" "$txt_body"
     ${KSH_SCRIPTS_DIR}/mail $email "$cur_proc_name -WARNING --Time: $now"  "${txt_body}"
     exit 0
fi

cd -

