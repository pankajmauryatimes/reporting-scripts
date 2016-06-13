#!/bin/ksh

set +x

#env_file=$1
for env_file in $(ls *.env)
do
kettle_found=$(cat $env_file | grep 'ktl_totaljobs' | grep '#')
if [[ $kettle_found == "" ]]
then

   echo "FOUND: $env_file"
   ENV_FILE=$env_file
   REPO=$(cat $env_file  | grep 'ktl_rep')
   JOB=$(cat $env_file  | grep 'ktl_jobarr')
   echo "ENV_FILE :$ENV_FILE"
   echo "REPO     :$REPO"
   echo "JOB      :$JOB"
   echo ""

#else
#    echo "NOT FOUND: $env_file"
fi

done
exit

