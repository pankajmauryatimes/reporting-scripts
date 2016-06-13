#!/bin/bash

set +x

export today=`date +%m%d%Y`
export ftp_dir=/ndata-archive/DAILY-REPORT/generic_etl/data_archive
export ip=172.16.84.221
export user=datareq
export pswd=datareq

cd $LOAD_DIR
perl -pi -e 's/"//g' rpc_data_updates.txt
perl -pi -e 's/"//g' rpc_data_cand_mobile_verification_track.txt
zip rpc_data_updates_${last_day}.zip rpc_data_updates.txt
zip rpc_data_cand_mobile_verification_track_${last_day}.zip rpc_data_cand_mobile_verification_track.txt
#sql_txt=`cat rpc_data_updates.txt`
txt_body="Hi Team,

Please execute attached script \"rpc_data_updates_${last_day}.zip\" on both TJ LIVE HIRE and CAND DB.


Thanks,
DB Team.

"

$mutt rpc_data_updates_${last_day} "$tomail" "$email" "$cur_proc_name USR" "$txt_body"


txt_body="Hi Team,

Please execute attached script \"rpc_data_cand_mobile_verification_track_${last_day}.zip\" on LIVE CAND DB.


Thanks,
DB Team.

"

$mutt rpc_data_cand_mobile_verification_track_${last_day} "$tomail" "$email" "$cur_proc_name CMVT" "$txt_body"

rm -f $LOAD_DIR/rpc_data_scp_221.ftp
ftp_file=$LOAD_DIR/rpc_data_scp_221.ftp
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
echo "del rpc_data_updates_${last_day}.zip" >> $ftp_file
echo "del rpc_data_cand_mobile_verification_track_${last_day}.zip" >> $ftp_file
echo "put rpc_data_updates_${last_day}.zip" >> $ftp_file
echo "put rpc_data_cand_mobile_verification_track_${last_day}.zip" >> $ftp_file
echo "quit" >> $ftp_file
echo "EOF" >> $ftp_file
#execute FTP script
chmod 755 ${ftp_file}
${ftp_file}

rm -f rpc_data_updates.txt
rm -f rpc_data_cand_mobile_verification_track.txt
rm -f ${LOAD_DIR}/RPC_JUNK_DATA_${last_day}.csv
mv rpc_data_updates_${last_day}.zip $HOME/generic_etl/data_archive/
mv rpc_data_cand_mobile_verification_track_${last_day}.zip $HOME/generic_etl/data_archive/
cd -

