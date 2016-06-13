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
                  FROM => 'RPD_DB@timesjobs.com',
                  SUBJECT => $sub,
                  #MAILHOST => 'delhi.tbsl.in'
                  #MAILHOST => 'Kolkata.tbsl.in'
                  MAILHOST => 'ranchi.tbsl.in'
	          };
   
SendMail::sendMail($config,$message);

