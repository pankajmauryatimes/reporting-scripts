#!/bin/bash

cd /home/dwhuser/generic_etl/wip

find . -type f -name "*.need" -mtime +10 -exec rm '{}' ';'
find . -type f -name "*.csv" -mtime +10 -exec rm '{}' ';'
find . -type f -name "*.zip" -mtime +10 -exec rm '{}' ';'
find . -type f -name "*.gz" -mtime +10 -exec rm '{}' ';'
find . -type f -name "*.done" -mtime +10 -exec rm '{}' ';'
find . -type f -name "*.txt" -mtime +10 -exec rm '{}' ';'

exit

