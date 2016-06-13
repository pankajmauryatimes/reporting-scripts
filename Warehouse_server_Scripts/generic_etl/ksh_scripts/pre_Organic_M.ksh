#!/bin/bash

set +x

tail -n +2 /opt/external_source_data/ga_data/Organic_${FDAY}.csv > /home/dwhuser/generic_etl/wip/Organic_M.csv
perl -pi -e "s/http:\/\///g" /home/dwhuser/generic_etl/wip/Organic_M.csv
perl -pi -e "s/^/Organic,${FDAY},/g" /home/dwhuser/generic_etl/wip/Organic_M.csv
