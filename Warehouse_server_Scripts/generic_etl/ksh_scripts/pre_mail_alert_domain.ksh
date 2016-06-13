#!/bin/bash

set +x
cp /home/dwhuser/generic_etl/wip/mail_alerts_domain_wise_one_week_${todate}.csv /home/dwhuser/generic_etl/wip/mail_alerts_domain_wise_one_week.csv
perl -pi -e "s/^/${FDAY},/g" /home/dwhuser/generic_etl/wip/mail_alerts_domain_wise_one_week.csv
