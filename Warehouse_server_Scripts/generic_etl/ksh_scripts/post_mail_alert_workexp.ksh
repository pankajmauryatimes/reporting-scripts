#!/bin/bash

set +x
mv /home/dwhuser/generic_etl/wip/mail_alerts_exp_wise_one_week_${todate}.csv /home/dwhuser/generic_etl/data_archive/mail_alerts_exp_wise_one_week_${todate}.csv
rm /home/dwhuser/generic_etl/wip/mail_alerts_exp_wise_one_week_${todate}.csv
rm /home/dwhuser/generic_etl/wip/mail_alerts_exp_wise_one_week.csv
