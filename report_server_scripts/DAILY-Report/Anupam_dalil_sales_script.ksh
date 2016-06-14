#!/bin/ksh

set +x
No_of_days=10
i=1
echo "Start Looping"
curr_dt=`date +%d%b%y`
No_of_days=`expr $No_of_days + 1`
while [[ ${i} -le ${No_of_days} ]]; do
  fr_date2=`expr $i - 1`
  FDAY=`date --date="${fr_date2} day ago" +%d%b%y`
  echo "$FDAY"
  cp /ndata-archive/DAILY-REPORT/${FDAY}/corp/Anupam_daily_sales_leads.txt /ndata-archive/DAILY-REPORT/${curr_dt}/Anupam_daily_sales_leads_${FDAY}.csv
  i=`expr $i + 1`
done
echo "Finish"
