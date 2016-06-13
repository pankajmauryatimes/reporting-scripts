#!/bin/bash

set +x

tail -n +2 /opt/external_source_data/ga_data/Direct_${FDAY}.csv > /home/dwhuser/generic_etl/wip/Direct_M.csv
perl -pi -e "s/http:\/\///g" /home/dwhuser/generic_etl/wip/Direct_M.csv
perl -pi -e "s/^/Direct,${FDAY},/g" /home/dwhuser/generic_etl/wip/Direct_M.csv
