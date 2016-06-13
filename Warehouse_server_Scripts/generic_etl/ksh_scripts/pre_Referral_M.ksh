#!/bin/bash

set +x

tail -n +2 /opt/external_source_data/ga_data/Referral_${FDAY}.csv > /home/dwhuser/generic_etl/wip/Referral_M.csv
perl -pi -e "s/http:\/\///g" /home/dwhuser/generic_etl/wip/Referral_M.csv
perl -pi -e "s/^/Referral,${FDAY},/g" /home/dwhuser/generic_etl/wip/Referral_M.csv
