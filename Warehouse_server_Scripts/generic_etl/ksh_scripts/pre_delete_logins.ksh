#!/bin/bash

set +x

cd $HOME/generic_etl/wip
rm $HOME/generic_etl/sql_scripts/delete_logins.sql
sort deleted_account_list_EWD_${todate}.txt | uniq  > $HOME/generic_etl/sql_scripts/delete_logins.sql

exit
