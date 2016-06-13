#!/bin/bash

set +x

. /tmp/DATAREQUEST/SCPFILES 

echo "Hi,

Please find below files on IMT Server

chandan_email_3Month_IT_0-2Y.txt
chandan_email_3Month_IT_2-99Y.txt
chandan_email_3Month_NonIT_0-2Y.txt
chandan_email_3Month_NonIT_2-99Y.txt
chandan_email_4Month_IT_0-2Y.txt
chandan_email_4Month_IT_2-99Y.txt
chandan_email_4Month_NonIT_0-2Y.txt
chandan_email_4Month_NonIT_2-99Y.txt

Thanks,
DBTeam

" > $HOME/generic_etl/logs/dummy.log
${KSH_SCRIPTS_DIR}/mail $email "$cur_proc_name - Report" $HOME/generic_etl/logs/dummy.log

echo "done"
exit
