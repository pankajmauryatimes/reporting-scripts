#/bin/bash

set +x

cd /opt/external_source_data/ga_data
find . -mtime +14 -exec rm -f {} \;

exit

