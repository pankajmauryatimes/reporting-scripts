#!/bin/bash

set +x

#tail -n +2 /opt/external_source_data/ga_data/Aggregated_Result_${FDAY}.csv > /home/dwhuser/generic_etl/wip/Aggregated_Result.csv
head -n -1 /opt/external_source_data/ga_data/Aggregated_Result_${FDAY}.csv > /home/dwhuser/generic_etl/wip/Aggregated_Result.csv
file_date=$(date -d ${FDAY//_/-} +%Y-%m-%d)
#perl -pi -e "s/^/Aggregated,${file_date},/g" /home/dwhuser/generic_etl/wip/Aggregated_Result.csv
perl -pi -e "s/^/Aggregated,/g" /home/dwhuser/generic_etl/wip/Aggregated_Result.csv
