#!/bin/bash

set +x

#tail -n +2 /opt/external_source_data/ga_data/ga_applications_crawled_jobs_${FDAY}.csv > /home/dwhuser/generic_etl/wip/ga_applications_crawled_jobs.csv

head -n -1 /opt/external_source_data/ga_data/ga_applications_crawled_jobs_${FDAY}.csv > /home/dwhuser/generic_etl/wip/ga_applications_crawled_jobs.csv

#file_date=$(date -d ${FDAY//_/-} +%Y-%m-%d)
#perl -pi -e "s/^/Email,${file_date},/g" /home/dwhuser/generic_etl/wip/Email.csv
#perl -pi -e "s/^/Email,/g" /home/dwhuser/generic_etl/wip/Email.csv
