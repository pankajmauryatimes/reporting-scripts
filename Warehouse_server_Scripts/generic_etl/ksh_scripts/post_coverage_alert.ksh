#!/bin/ksh

set +x

mv $HOME/generic_etl/wip/coverage_alert.txt $HOME/generic_etl/data_archive/coverage_alert_{$today}.txt
mv $HOME/generic_etl/wip/coverage_alert_jaDB.txt $HOME/generic_etl/data_archive/coverage_alert_jaDB{$today}.txt

