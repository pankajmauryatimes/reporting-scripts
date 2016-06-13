#!/bin/bash

set +x

tail -n +2 /opt/external_source_data/ga_data/Paid_${FDAY}.csv > /home/dwhuser/generic_etl/wip/Paid_M.csv
perl -pi -e "s/http:\/\///g" /home/dwhuser/generic_etl/wip/Paid_M.csv
perl -pi -e "s/^/Paid,${FDAY},/g" /home/dwhuser/generic_etl/wip/Paid_M.csv
