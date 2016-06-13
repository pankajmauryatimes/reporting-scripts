#!/bin/bash

find /home/dwhuser/generic_etl/data_archive/* -mtime +30 -exec rm {} \;
find /home/dwhuser/generic_etl/data_archive/jobbuzz/* -mtime +30 -exec rm {} \;
exit 0;
