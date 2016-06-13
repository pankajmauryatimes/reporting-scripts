#!/bin/bash

set +x

echo ""
echo "SCP IXF files to DB2 STAGING SERVER "
echo "DateTime: $(date +'%d%b%y-%T')"
scp /opt/dw_data/data/cand_ixf/* dwhuser@172.16.85.205:/opt/dw_data/data/cand_ixf 
scp /opt/dw_data/data/corp_ixf/* dwhuser@172.16.85.205:/opt/dw_data/data/corp_ixf
echo "SCP complete"
echo "DateTime: $(date +'%d%b%y-%T')"

echo ""
echo "Truncate Table of DB2 STAGING SERVER"
ssh dwhuser@172.16.85.205 '/opt/dw_data/bin/trunc_table_ixf.csh'
echo "Truncate Completed"
echo "DateTime: $(date +'%d%b%y-%T')"

echo "Loading Cand IXF File"
echo "DateTime: $(date +'%d%b%y-%T')"
ssh dwhuser@172.16.85.205 '/opt/dw_data/bin/loadcand_ixf.csh'
echo "Load Completed"
echo "DateTime: $(date +'%d%b%y-%T')"

echo "Loading Corp IXF on DB2 STAGING SERVER"
echo "DateTime: $(date +'%d%b%y-%T')"
ssh dwhuser@172.16.85.205 '/opt/dw_data/bin/loadcorp_ixf.csh'
echo "Load Completed"
echo "DateTime: $(date +'%d%b%y-%T')"

echo "SCP LOG Files from DB2 STAGING SERVER"
echo "DateTime: $(date +'%d%b%y-%T')"
ssh dwhuser@172.16.85.205 '/opt/dw_data/bin/scp_sql_queries.csh'
echo "SCP Completed"
echo "DateTime: $(date +'%d%b%y-%T')"
exit

