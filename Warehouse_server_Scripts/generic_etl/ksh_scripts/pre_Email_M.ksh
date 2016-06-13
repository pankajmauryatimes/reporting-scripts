#!/bin/bash

set +x

tail -n +2 /opt/external_source_data/ga_data/Email_${FDAY}.csv > /home/dwhuser/generic_etl/wip/Email_M.csv
perl -pi -e "s/http:\/\///g" /home/dwhuser/generic_etl/wip/Email_M.csv
perl -pi -e "s/^/Email,${FDAY},/g" /home/dwhuser/generic_etl/wip/Email_M.csv
