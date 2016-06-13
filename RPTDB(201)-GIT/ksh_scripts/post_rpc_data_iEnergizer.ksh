#!/usr/bin/ksh

set +x

cd $HOME/generic_etl/wip/

perl -pi -e 's/"//g' REC_LOADED.txt
export file_type=RPC
export filename=Ienergizer_${file_type}.csv
#mv $filename $HOME/generic_etl/data_archive/$filename_${today}.csv

