#!/bin/bash

set +x

tail -n +2 /opt/external_source_data/ga_data/Aggregated_Result_${FDAY}.csv > /home/dwhuser/generic_etl/wip/Aggregated_Result_M.csv
perl -pi -e "s/http:\/\///g" /home/dwhuser/generic_etl/wip/Aggregated_Result_M.csv
perl -pi -e "s/^/Aggregated,${FDAY},/g" /home/dwhuser/generic_etl/wip/Aggregated_Result_M.csv


