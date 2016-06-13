#!/bin/bash

set +x

echo "" > ${EMAIL_REP}
  echo "DATA REQUESTED" >> ${EMAIL_REP}
  echo "--------------" >> ${EMAIL_REP}
  echo "" >> ${EMAIL_REP}
  echo "Login ID     : ${REQ_BY}" >> ${EMAIL_REP}
  echo "Data Point   : ${DATA_COUNT}" >> ${EMAIL_REP}
  echo "Req. Desc    : ${REQ_DESC}" >> ${EMAIL_REP}
  echo "Fields Reqd. : $FIELDS" >> ${EMAIL_REP}
  echo "" >> ${EMAIL_REP}
  echo "" >> ${EMAIL_REP}
  echo "OUTPUT" >> ${EMAIL_REP}
  echo "------" >> ${EMAIL_REP}
  echo "FILE : ${FILE_NAME} (DATA POINT: ${avl_data})" >> ${EMAIL_REP}
  echo "" >> ${EMAIL_REP}
  echo ""  >> ${EMAIL_REP}
echo "IMT SERVER LOCATION:$ftp_dir${REQ_BY}" >> ${EMAIL_REP}
echo "" >> ${EMAIL_REP}
echo "" >> ${EMAIL_REP}
echo "Thanks," >> ${EMAIL_REP}
echo "Datawarehouse Team" >> ${EMAIL_REP}
echo "" >> ${EMAIL_REP}
echo "This E-Notification was automatically generated. Please do not reply to this mail." >> ${EMAIL_REP}
echo "" >> ${EMAIL_REP}

email=$(cat $HOME/DATAREQUEST_PROCESS/.email_dl.lst | grep "${REQ_BY}" |cut -d: -f2)
if [[ $email == "" ]]
then 
    email=tjbi@timesgroup.com
fi

${KSH_SCRIPTS_DIR}/mail $email "DATA REQUEST - ${REQ_DESC}" ${EMAIL_REP}
