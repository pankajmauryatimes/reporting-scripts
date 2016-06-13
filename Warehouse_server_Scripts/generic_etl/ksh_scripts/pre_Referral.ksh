#!/bin/bash

set +x

#tail -n +2 /opt/external_source_data/ga_data/Referral_${FDAY}.csv > /home/dwhuser/generic_etl/wip/Referral.csv
head -n -1 /opt/external_source_data/ga_data/Referral_${FDAY}.csv > /home/dwhuser/generic_etl/wip/Referral.csv
file_date=$(date -d ${FDAY//_/-} +%Y-%m-%d)
#perl -pi -e "s/^/Referral,${file_date},/g" /home/dwhuser/generic_etl/wip/Referral.csv
perl -pi -e "s/^/Referral,/g" /home/dwhuser/generic_etl/wip/Referral.csv
