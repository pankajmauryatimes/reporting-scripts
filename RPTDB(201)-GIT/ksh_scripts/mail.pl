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
                  FROM => 'data_engineering@timesjobs.com',
                  SUBJECT => $sub,
                  #MAILHOST => 'delhi.tbsl.in'
                  #MAILHOST => 'Kolkata.tbsl.in'
                  MAILHOST => 'ranchi.tbsl.in'
		  #MAILHOST => 'Mumbai.tbsl.in'
	          };
   
SendMail::sendMail($config,$message);

