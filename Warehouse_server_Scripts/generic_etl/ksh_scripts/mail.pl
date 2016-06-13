#!/usr/bin/perl

use strict;
use POSIX;
use File::Basename;

use SendMail;

#my $status = shift;
my $config;
my $tomail = shift;
#my $ccmail = shift;
my $sub = shift;
my $message = shift;
    $config = {
	          TO => $tomail,
		  #CC => $ccmail,
                  FROM => 'edw@timesjobs.com',
                  SUBJECT => $sub,
                  #MAILHOST => 'delhi.tbsl.in'
                  #MAILHOST => 'Kolkata.tbsl.in'
                  MAILHOST => '172.16.84.186'
	          };
   
SendMail::sendMail($config,$message);

