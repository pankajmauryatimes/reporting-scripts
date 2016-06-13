#!/bin/bash

set +x

cp /home/dwhuser/generic_etl/data_archive/dial_bpo/dial_bpo_corp_${corp_file_date}.csv /home/dwhuser/generic_etl/wip/dial_bpo_corp.csv
cp /home/dwhuser/generic_etl/data_archive/dial_bpo/dial_bpo_cand_${cand_file_date}.csv /home/dwhuser/generic_etl/wip/dial_bpo_cand.csv
exit
