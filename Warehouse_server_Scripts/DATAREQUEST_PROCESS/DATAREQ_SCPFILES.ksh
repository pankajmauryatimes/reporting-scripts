#!/bin/bash

set +x
data_file=$HOME/DATAREQUEST_PROCESS/DATA_FILES
cd $data_file
ip=192.168.206.142
user=dwhuser
pswd=dwh@123
ftp_dir=/opt/dwhdata/
ftp_file=imt_file.ftp
str_whoami=`whoami`

echo "tbsl2013@gmail.com
jaintimesjobs@gmail.com
rams77051@gmail.com
shyamjain1978@gmail.com
jayhindjain@gmail.com
tbsl20131@yahoo.in
jaintimesjobs@yahoo.com
rams770511@yahoo.in
shyamjain19781@yahoo.in
jayhindjain1@yahoo.in
tbsl2013@rediffmail.com
jaintimesjobs@rediffmail.com
rams77051@rediffmail.com
shyamjain1978@rediffmail.com
jayhindjain@rediffmail.com" > $data_file/OfficialIds.lst

if [[ -r $data_file/OfficialIds.lst ]]
then
    printf "\n Special Containment Procedures" >> $HOME/DATAREQUEST_PROCESS/log/DATAREQ_PROCESSOR_${now}.log
else
    printf "\n " >> $HOME/DATAREQUEST_PROCESS/log/DATAREQ_PROCESSOR_${now}.log
    printf "\n File Missing :OfficialIds.lst " >> $HOME/DATAREQUEST_PROCESS/log/DATAREQ_PROCESSOR_${now}.log
    printf "\n ------------------------------" >> $HOME/DATAREQUEST_PROCESS/log/DATAREQ_PROCESSOR_${now}.log
   exit
fi

Search_String=`head -2 $data_file/${FILE_NAME} | egrep -i [a-z]`
if [[ $Search_String != '' ]]
then
     cat $data_file/OfficialIds.lst $data_file/${FILE_NAME} > $data_file/${FILE_NAME}-apnd
     mv $data_file/${FILE_NAME}-apnd $data_file/${FILE_NAME}
     sed '/\\N/d' $data_file/${FILE_NAME} > $data_file/${FILE_NAME}.log
     mv $data_file/${FILE_NAME}.log $data_file/${FILE_NAME}
     rm -f $data_file/${FILE_NAME}.log
     perl -pi -e "s/\\t//g" $data_file/${FILE_NAME}
else
     perl -pi -e "s/^/a/g" $data_file/${FILE_NAME}
     perl -pi -e "s/a91//g" $data_file/${FILE_NAME}
     perl -pi -e "s/ay//g" $data_file/${FILE_NAME}
     perl -pi -e "s/a//g" $data_file/${FILE_NAME}
     sed '/^$/d' $data_file/${FILE_NAME} > $data_file/${FILE_NAME}_tmp
     mv $data_file/${FILE_NAME}_tmp $data_file/${FILE_NAME}
fi

echo "#!/bin/ksh" > $ftp_file
echo "HOST=$ip" >> $ftp_file
echo "USER=$user" >> $ftp_file
echo "PASSWD=$pswd" >> $ftp_file
echo "ftp -in \$HOST <<EOF" >> $ftp_file
echo "quote USER \$USER" >> $ftp_file
echo "quote PASS \$PASSWD" >> $ftp_file
echo "binary" >> $ftp_file
echo "cd $ftp_dir" >> $ftp_file
echo "dir" >> $ftp_file 
echo "quit" >> $ftp_file
echo "EOF" >> $ftp_file
 #execute FTP script
chmod 755 ${ftp_file}
./${ftp_file} > dir_available_imt.log

cr_dir=`cat dir_available_imt.log | grep $REQ_BY`
echo "#!/bin/ksh" > $ftp_file
echo "HOST=$ip" >> $ftp_file
echo "USER=$user" >> $ftp_file
echo "PASSWD=$pswd" >> $ftp_file
echo "ftp -in \$HOST <<EOF" >> $ftp_file
echo "quote USER \$USER" >> $ftp_file
echo "quote PASS \$PASSWD" >> $ftp_file
echo "binary" >> $ftp_file
echo "cd $ftp_dir" >> $ftp_file
if [[ $cr_dir == '' ]]
then
     echo "mkdir $REQ_BY" >> $ftp_file
fi
echo "cd $REQ_BY"  >> $ftp_file
echo "put ${FILE_NAME}" >> $ftp_file
echo "quit" >> $ftp_file
echo "EOF" >> $ftp_file

 #execute FTP script
 chmod 755 ${ftp_file}
./${ftp_file}

printf "\n \n SCP File :${FILE_NAME}. \n" >> $HOME/DATAREQUEST_PROCESS/log/DATAREQ_PROCESSOR_${now}.log
mv ${FILE_NAME} $HOME/DATAREQUEST_PROCESS/DATA_ARCHIVE
gunzip $HOME/DATAREQUEST_PROCESS/DATA_ARCHIVE/${FILE_NAME}

rm -f dir_available_imt.log
#rm -f imt_file.ftp

