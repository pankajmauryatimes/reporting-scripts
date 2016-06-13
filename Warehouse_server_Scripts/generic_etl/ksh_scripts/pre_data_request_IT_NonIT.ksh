#!/bin/bash

set +x

cd /tmp
mkdir DATAREQUEST
chmod 777 DATAREQUEST
cp /home/dwhuser/generic_etl/ksh_scripts/SCPFILES /tmp/DATAREQUEST/
chmod 777 /tmp/DATAREQUEST/SCPFILES
cd -
cd /home/dwhuser/IT_NONIT/
#rm ./data/*
#./IT_NonIT_Data.sh > IT_NonIT_Data_${today}.log
cd -
