#!/bin/ksh

set +x

cd /tmp/

export ftp_file=/tmp/scp_file.ftp
#execute FTP script
chmod 755 ${ftp_file}
${ftp_file}

