#!/usr/bin/ksh

set +x

cd $HOME/generic_etl/wip/
rm -f $HOME/generic_etl/wip/scp_file.ftp
export file_type=DNC_daily
export filename=Ienergizer_${file_type}_${today}.csv
file_1=$filename

file_type=DNC_daily
mv Ienergizer_${file_type}.csv $HOME/generic_etl/data_archive/Ienergizer_${file_type}_${today}.csv

file_type=RPC
mv Ienergizer_${file_type}.csv $HOME/generic_etl/data_archive/Ienergizer_${file_type}_${today}.csv

