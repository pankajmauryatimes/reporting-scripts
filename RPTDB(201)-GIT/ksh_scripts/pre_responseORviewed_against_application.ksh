#!/bin/ksh

set +

perl -pi -e 's/       //g' /home/datareq/generic_etl/wip/RESUME_VIEWED_EMPLOYER.csv
perl -pi -e 's/       //g' /home/datareq/generic_etl/wip/RECRUITER_RESPONSE_DETAIL.csv
