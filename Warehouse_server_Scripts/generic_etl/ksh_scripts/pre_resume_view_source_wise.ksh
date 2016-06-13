#!/bin/ksh

set +x

/opt/data-integration/kitchen.sh -user=admin -pass=admin -rep=datamart_repo -job=job_Resume_View_By_Source_Report > $HOME/generic_etl/logs/kettle_job_Resume_View_By_Source_Report.log
s_return=`grep -i "Error" $HOME/generic_etl/logs/kettle_job_Resume_View_By_Source_Report.log |wc -l`
if [ $s_return -gt 0 ]
        then
                exit 0
fi

#cp $HOME/generic_etl/wip/records.txt $HOME/generic_etl/data_archive/records_${today}.txt

#sed '/^$/d' $HOME/generic_etl/wip/records.txt > $HOME/generic_etl/wip/records_tmp.txt
#sed -i '1d' $HOME/generic_etl/wip/records_tmp.txt 
#mv $HOME/generic_etl/wip/records_tmp.txt $HOME/generic_etl/wip/records.txt

#perl -pi -e "s/\|/,/g" $HOME/generic_etl/wip/records.txt

exit
