#!/usr/bin/perl

use strict;
use POSIX;
use File::Basename;

use SendMail;

my $status = shift;
my $config;
my $message;



if($status eq "T") {
    $config = {
	          TO => 'sanjay.biswas@timesgroup.com',
                  FROM => 'data_engineering@timesjobs.com',
                  SUBJECT => 'JOBBUZZ DATA EXPORT Report',
                  MAILHOST => 'delhi.tbsl.in'
	          };
    $message = `cat jobbuzz_extract.cron`;
		} else {
    $config = {
	          TO => 'sanjay.biswas@timesgroup.com',
		  CC => 'sanjay.biswas@timesgroup.com',
                  FROM => 'data_engineering@timesjobs.com',
                  SUBJECT => 'JOBBUZZ DATA EXPORT Process Failed',
                  MAILHOST => 'delhi.tbsl.in'
			  };

    $message =  `cat jobbuzz_extract.cron`;
}    
    
SendMail::sendMail($config,$message);

