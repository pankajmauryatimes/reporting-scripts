#!/usr/bin/ksh

set +x

cd $HOME/generic_etl/wip/
rm -f $HOME/generic_etl/wip/scp_file.ftp

export file_type=DNC_daily
export filename=Ienergizer_${file_type}.csv
mv $filename $HOME/generic_etl/data_archive/$filename_${today}.csv

