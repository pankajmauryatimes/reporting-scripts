#!/usr/bin/ksh

set +x

cd $HOME/generic_etl/wip/

#echo "\"ID\",\"PARAMETER\",\"YEAR\",\"MONTH\",\"COUNT\"" > $HOME/generic_etl/wip/coverage_alert_H.txt
#cat coverage_alert_H.txt coverage_alert.txt > $HOME/generic_etl/wip/coverage_alert_${month}.csv
#perl -pi -e 's/"//g' $HOME/generic_etl/wip/coverage_alert_${month}.txt
#perl -pi -e 's/,/: /g' $HOME/generic_etl/wip/coverage_alert_${month}.txt
#mv coverage_alert.txt coverage_alert_${month}.txt
#alert_cnt=$(cat $HOME/generic_etl/wip/coverage_alert_${month}.txt)

#zip coverage_alert_${month}.zip coverage_alert_${month}.txt

#txt_body="Hi ,

#Please find Job Alert Coverage below:
#$alert_cnt



#Thanks,
#dbteam
#"

#$mutt coverage_alert_${month} "$tmail" "$cmail" "$cur_proc_name " "$txt_body"
#mv $HOME/generic_etl/wip/coverage_alert_${month}.csv $HOME/generic_etl/data_archive/coverage_alert_${now}.csv
#rm $HOME/generic_etl/wip/coverage_alert_${month}.txt
