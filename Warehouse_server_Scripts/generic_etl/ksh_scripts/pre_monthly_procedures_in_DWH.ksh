#!/bin/bash

set +x

echo "call tjsitestats.prc_generate_monthly_stat_master(${last_month});" > ${HOME}/generic_etl/sql_scripts/monthly_procedures_in_DWH.sql 
