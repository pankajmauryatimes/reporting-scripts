#!/bin/bash

perl -pi -e 's/"//g' $HOME/generic_etl/wip/JB_KPI_FACT_${today}.txt
cp $HOME/generic_etl/wip/JB_KPI_FACT_${today}.txt $HOME/generic_etl/wip/JB_KPI_FACT.txt
mv $HOME/generic_etl/wip/JB_KPI_FACT_${today}.txt $HOME/generic_etl/data_archive/


