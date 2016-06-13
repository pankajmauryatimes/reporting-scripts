#!/bin/bash

set +x

#tail -n +2 /opt/external_source_data/ga_data/Paid_${FDAY}.csv > /home/dwhuser/generic_etl/wip/Paid.csv
head -n -1 /opt/external_source_data/ga_data/Paid_${FDAY}.csv > /home/dwhuser/generic_etl/wip/Paid.csv
file_date=$(date -d ${FDAY//_/-} +%Y-%m-%d)
#perl -pi -e "s/^/Paid,${file_date},/g" /home/dwhuser/generic_etl/wip/Paid.csv
perl -pi -e "s/^/Paid,/g" /home/dwhuser/generic_etl/wip/Paid.csv
