#!/usr/bin/ksh

set +x

cd $HOME/generic_etl/wip/

export file_type=RPC
export filename=Effort_${file_type}.csv
mv $filename $HOME/generic_etl/data_archive/$filename_${today}.csv

