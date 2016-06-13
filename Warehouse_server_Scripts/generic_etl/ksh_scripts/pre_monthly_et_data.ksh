#!/bin/bash

set +x

echo "call tjdwh_db.prc_generate_et_month(${last_month});" > ${HOME}/generic_etl/sql_scripts/monthly_et_data.sql
