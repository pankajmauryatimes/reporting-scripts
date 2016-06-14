#!/bin/ksh

set +x 

DAYOFWEEK=$(date +"%a")
echo "DAYOFWEEK: $DAYOFWEEK"
if [[ $DAYOFWEEK == "Mon" ]] 
then   
   last_day_of_week=$(date -dlast-monday +%Y-%m-%d) 
   echo $last_day_of_week
else
   export day=$(date -dlast-monday +%Y-%m-%d)
   last_day_of_week=$(date -d "$day -$(date -d $day +%w) days - 6 day" +%Y-%m-%d)
   echo $last_day_of_week
fi

