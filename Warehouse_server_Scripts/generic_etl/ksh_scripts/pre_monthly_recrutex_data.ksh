#!/bin/bash

set +x

echo "call tjdwh_db.prc_generate_recrutex_month(${last_month});" > ${HOME}/generic_etl/sql_scripts/monthly_recrutex_data.sql
