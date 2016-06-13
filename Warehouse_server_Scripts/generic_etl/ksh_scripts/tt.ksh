#!/bin/bash

set +x
echo "$(date +"%m/%d/%Y %T")"
echo "Delete DWH tables"
printf "Delete DWH tables"
export today=`date +%Y-%m-%d`

printf "$(date +"%m/%d/%Y %T") :> Finished Delete DWH tables ..."
printf "Directory create for the day ..."
mkdir /home/dwhuser/generic_etl/data_archive/jobbuzz/$today
printf "GZIP Flat Files"
gzip /opt/dw_data/data/jobbuzz/*.*
printf "Move Flat Files"
mv /opt/dw_data/data/jobbuzz/*.* /home/dwhuser/generic_etl/data_archive/jobbuzz/$today/

