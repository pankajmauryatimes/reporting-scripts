#!/usr/bin/ksh

set +x
mv $LOAD_DIR/${cur_proc}.csv $LOAD_DIR/${cur_proc}_${today}.csv
echo "All Files are created successfully"
