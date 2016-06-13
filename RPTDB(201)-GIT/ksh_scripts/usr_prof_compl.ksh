#!/usr/bin/ksh

set +x
export today=`date +%d%b%y`
export cutoff=23:50:00
export remind=07:00:00
export remindsent=0


echo "Date: $today"
cd /home/datareq/generic_etl/data_files
if [ -f /candreports/db2inst2/sqllib/db2profile ]; then
        . /candreports/db2inst2/sqllib/db2profile
fi
echo "Start Data INSERT OR UPDATE "
printf "Start Data INSERT OR UPDATE "
/home/datareq/generic_etl/ksh_scripts/usr_prof_compl.csh > /home/datareq/generic_etl/logs/usr_prof_compl_${today}.log

echo "END Data INSERT OR UPDATE "
printf "END Data INSERT OR UPDATE "t

exit

