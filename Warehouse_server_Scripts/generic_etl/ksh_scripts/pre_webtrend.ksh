#!/bin/bash

set +x

#export cur_proc=webtrend
#export today=`date +%Y-%m-%d`
#export LOAD_DIR=/opt/external_source_data/webtrend_data
#export LOAD_FILE=webtrend_$todate.csv
echo "delete from tj_web_trend_data_stage;" > $HOME/generic_etl/ctl/${cur_proc}.sql
echo "load data local infile '${LOAD_DIR}/${LOAD_FILE}' into table tj_web_trend_data_stage fields terminated by ',' enclosed by '\"' lines terminated by '\n';" >> $HOME/generic_etl/ctl/${cur_proc}.sql
exit
