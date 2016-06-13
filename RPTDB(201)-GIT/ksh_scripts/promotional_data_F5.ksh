#!/bin/ksh

set +x

cd $HOME/generic_etl/wip/

if [[ $curr_proc == "" ]]
then
    echo ""
    echo "WARNING :Parameter need to pass for Promotional Mailer Data"
    echo ""
    exit
fi


if [[ $curr_proc == F5 ]]
then
    echo "$curr_proc Process begin"
    export proc=5
    limit=50000
    work_exp="1-3"
fi

echo "Checking for file which has to be load "
echo "File Name :$HOME/generic_etl/wip/promotional_data_${curr_proc}.txt "
if [ -r $HOME/generic_etl/wip/promotional_data_${curr_proc}.txt ]
then

echo "Data Loading ....."
echo "------------------"
echo "Truncate table promotion_data_stage_${curr_proc}"
echo ""
       db2 "alter table promotion_data_stage_${curr_proc} activate not logged initially with empty table"
echo "Delete already shared promotion_data ${curr_proc}"
echo ""
       db2 "delete from promotion_data_${curr_proc} where FRESSNESS = $proc and (SENT ='Y' or (SENT ='N' and POST_DATE < current date - 20 days)) "
echo "Import Data into promotion_data_stage_${curr_proc}"
echo ""
       db2 "import from $HOME/generic_etl/wip/promotional_data_${curr_proc}.txt of del insert into promotion_data_stage_${curr_proc}"
echo "Load Data into promotional_data_${curr_proc}"
echo ""
       db2 "INSERT INTO promotion_data_${curr_proc} (EMAIL,CAND_NAME,MOBILE,WORK_EXP,SENT,FRESSNESS,POST_DATE) (select stage.EMAIL,stage.CAND_NAME,max(stage.MOBILE) as MOBILE,max(stage.WORK_EXP) as WORK_EXP,'N',${proc} ,current date from promotion_data_stage_${curr_proc} stage group by stage.EMAIL,stage.CAND_NAME)"
       db2 "delete from promotion_data_${curr_proc} where length(trim(EMAIL)) < 1 and FRESSNESS = ${proc}"

       db2 "commit"
echo "Moving Files ...."
echo "---------- LOADING PROCESS END  ---------"
else
     echo "No File for load"
fi
      
echo "Data availability"

     db2 "select count(1) as total from promotion_data_${curr_proc} pdf where not exists (select 1 from fake_email fe where fe.EMAILID = pdf.EMAIL) and pdf.sent='N' and pdf.FRESSNESS = ${proc} and length(pdf.EMAIL) > 0  and length(pdf.CAND_NAME) >0 and length(pdf.MOBILE) >0 with ur" > $HOME/generic_etl/wip/data_point_count.txt

data_count=`head -4 $HOME/generic_etl/wip/data_point_count.txt |tail -1 |cut -d',' -f1 | bc`
echo "Data available for ${curr_proc}: $data_count"

if [ $data_count -gt $limit ]
then
     echo "Data is Sufficient for the day"


     echo "      Pre-determine data for next day"
     echo "      -------------------------------"
     rest_data_point=`expr $data_count - 2 \* $limit`
     if [ $rest_data_point -lt 100000 ]
     then
         echo "       Be Ready to Load Fresh Data for One Year Freshness(${curr_proc})"
         echo "Hi,

Data is available for this process:$data_count
-Be ready to load fresh data for ${curr_proc}

Thanks,
RPT SERVER
" > $HOME/generic_etl/wip/mail_body.txt

         ${KSH_SCRIPTS_DIR}/mail2 $email "Be Ready to Load Fresh Data for One Year Freshness(${curr_proc})" $HOME/generic_etl/wip/mail_body.txt
         touch $HOME/generic_etl/wip/promotional_data_script_${curr_proc}_${today}.need
         echo "************ FTP FILE FOR DATA REQUEST ************"
         $HOME/generic_etl/ksh_scripts/promotional_data.ftp DWH  promotional_data_script_${curr_proc}_${today}.need    
     
     else
         echo "         Data is Sufficient for the next day" 
     fi
     echo "Pre-determination process has been finished"
     echo "-------------------------------------------"

     echo "Process begin for Promotional data file creation"
     echo "------------------------------------------------"

     db2 "export to $HOME/generic_etl/wip/promotional_data_${curr_proc}.ixf of ixf select pdf.EMAIL,pdf.CAND_NAME,pdf.MOBILE,pdf.EMAIL,pdf.WORK_EXP from promotion_data_${curr_proc} pdf where not exists (select 1 from fake_email fe where fe.EMAILID = pdf.EMAIL) and not exists (select 1 from user u where u.email2 = pdf.EMAIL and u.net_status = 3 and pdf.EMAIL is not null)  and pdf.sent='N' and pdf.FRESSNESS = ${proc} and length(pdf.EMAIL) > 0 and length(pdf.CAND_NAME) > 0 and length(pdf.MOBILE) > 0 order by pdf.POST_DATE desc fetch first $limit rows only with ur"
     db2 "alter table promotion_data_sent_${curr_proc} activate not logged initially with empty table"
     db2 "import from $HOME/generic_etl/wip/promotional_data_${curr_proc}.ixf of ixf insert into promotion_data_sent_${curr_proc}"
     db2 "export to $HOME/generic_etl/wip/PD_${today}_${curr_proc}.txt of del modified by coldel, datesiso select EMAIL,CAND_NAME from promotion_data_sent_${curr_proc} with ur"
     db2 "update promotion_data_${curr_proc} pdf set pdf.sent='Y' , POST_DATE=current date  where exists (select 1 from promotion_data_sent_${curr_proc} pds where pds.EMAIL = pdf.EMAIL) and pdf.FRESSNESS = ${proc}"

     perl -pi -e 's/"//g' $HOME/generic_etl/wip/PD_${today}_${curr_proc}.txt
     #mv $HOME/generic_etl/wip/promotional_data_${curr_proc}.txt $HOME/generic_etl/wip/promotional_data_${curr_proc}-${today}.txt
     echo "************ FTP FILE FOR DATA REQUEST ************"
     $HOME/generic_etl/ksh_scripts/promotional_data.ftp IMT PD_${today}_${curr_proc}.txt
     echo "************ FTP COMPLETED ************"

     echo "Hi,

Data has been sent for work exp ${work_exp}:(Sent ${limit} data point)

Thanks,
RPT SERVER
" > $HOME/generic_etl/wip/mail_body.txt

     ${KSH_SCRIPTS_DIR}/mail2 $email "Promotional Data has been sent for Process (${curr_proc})- FA BANKING " $HOME/generic_etl/wip/mail_body.txt

     echo "Process Completed for process ${curr_proc}"
     echo "------------------------------------------------"

else
     echo "Promotional Data(${curr_proc}) has been failed -Load Data immediately"
     echo "Hi,

Data Shortage for ${curr_proc}
-Data needed: $limit
-Data Available :$data_count

Thanks,
RPT SERVER
" > $HOME/generic_etl/wip/mail_body.txt

        ${KSH_SCRIPTS_DIR}/mail2 $email "Promotional Data(${curr_proc}) has been failed -Load Data immediately " $HOME/generic_etl/wip/mail_body.txt

fi

mv $HOME/generic_etl/wip/PD_${today}_${curr_proc}.txt  $HOME/generic_etl/data_archive/PD_${today}_${curr_proc}.txt
#mv $HOME/generic_etl/wip/promotional_data_${curr_proc}.txt $HOME/generic_etl/data_archive/promotional_data_${curr_proc}-${today}.txt
rm -f $HOME/generic_etl/wip/promotional_data_${curr_proc}.ixf
rm -f $HOME/generic_etl/wip/mail_body.txt
rm -f $HOME/generic_etl/wip/data_point_count.txt


