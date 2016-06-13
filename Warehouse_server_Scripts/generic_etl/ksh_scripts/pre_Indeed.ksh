#!/bin/bash

set +x

tail -n +2 /opt/external_source_data/ga_data/Indeed_${FDAY}.csv > /home/dwhuser/generic_etl/wip/Indeed.csv
file_date=$(date -d ${FDAY//_/-} +%Y-%m-%d)
perl -pi -e "s/^/Indeed,${file_date},/g" /home/dwhuser/generic_etl/wip/Indeed.csv
