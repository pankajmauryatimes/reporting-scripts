#!/usr/bin/perl

#-----------------------------------------------------------------
# This Perl script is used to Test Mail
#-----------------------------------------------------------------

use strict;
use POSIX;
use File::Basename;

use SendMail; 

my $status = shift;
my $config;
my $message;

if($status eq "T") {
    $config = {TO => 'tjbi@timesgroup.com',
                  FROM => 'edw@timesjos.com',
                  SUBJECT => 'Process Success',
                  MAILHOST => '172.16.84.186:25'};
    $message = 'Warehouse Load Completed Successfully...';
} else {
    $config = {TO =>'tjbi@timesgroup.com',
                  FROM => 'edw@timesjobs.com',
                  SUBJECT => 'Process Failed',
                  MAILHOST => '172.16.84.186:25'};
    $message = 'Alert! Warehouse Load Failed. Please Re-Run Processg.....';

}    
     
    
    SendMail::sendMail($config,$message);
    

