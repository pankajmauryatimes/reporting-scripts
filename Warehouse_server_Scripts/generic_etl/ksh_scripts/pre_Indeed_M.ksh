#!/bin/bash

set +x

tail -n +2 /opt/external_source_data/ga_data/Indeed_${FDAY}.csv > /home/dwhuser/generic_etl/wip/Indeed_M.csv
perl -pi -e "s/http:\/\///g" /home/dwhuser/generic_etl/wip/Indeed_M.csv
perl -pi -e "s/^/Indeed,${FDAY},/g" /home/dwhuser/generic_etl/wip/Indeed_M.csv
