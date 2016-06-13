#!/bin/bash

set +x

#tail -n +2 /opt/external_source_data/ga_data/Organic_${FDAY}.csv > /home/dwhuser/generic_etl/wip/Organic.csv
head -n -1 /opt/external_source_data/ga_data/Organic_${FDAY}.csv > /home/dwhuser/generic_etl/wip/Organic.csv

file_date=$(date -d ${FDAY//_/-} +%Y-%m-%d)
#perl -pi -e "s/^/Organic,${file_date},/g" /home/dwhuser/generic_etl/wip/Organic.csv
perl -pi -e "s/^/Organic,/g" /home/dwhuser/generic_etl/wip/Organic.csv
