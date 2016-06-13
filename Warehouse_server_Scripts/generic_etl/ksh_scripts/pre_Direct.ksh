#!/bin/bash

set +x

#tail -n +2 /opt/external_source_data/ga_data/Direct_${FDAY}.csv > /home/dwhuser/generic_etl/wip/Direct.csv
head -n -1 /opt/external_source_data/ga_data/Direct_${FDAY}.csv > /home/dwhuser/generic_etl/wip/Direct.csv

file_date=$(date -d ${FDAY//_/-} +%Y-%m-%d)
#perl -pi -e "s/^/Direct,${file_date},/g" /home/dwhuser/generic_etl/wip/Direct.csv
perl -pi -e "s/^/Direct,/g" /home/dwhuser/generic_etl/wip/Direct.csv
