#!/usr/bin/perl -w

package SendMail;

use strict;
use Net::SMTP;

sub sendMail {
   my $args  = shift;
   my $body  = shift;

   my $mailHost = $args->{MAILHOST};
   my @to       = split(",",$args->{TO});
   my @cc       = split(",",$args->{CC});
   my $from     = $args->{FROM};
   my $subject  = $args->{SUBJECT};

   my $smtp = Net::SMTP->new("$mailHost",
                           Hello => "$mailHost",
                           Timeout => 2,
                           Debug   => 4,
                          );
   if(!$smtp) {
      print "\nError Connecting $mailHost";
      return -1;
   }

   if($smtp) {

      $smtp->mail($from);
      $smtp->to(@to);
	  $smtp->to(@cc);

      $smtp->data();
      $smtp->datasend("From: $from\n");
      $smtp->datasend("To: $args->{TO}\n");
	  $smtp->datasend("To: $args->{CC}\n");
      $smtp->datasend("Subject: $subject\n");
      $smtp->datasend("\n");

      $smtp->datasend("$body\n");
      $smtp->datasend("\n");
      $smtp->dataend();
      $smtp->quit;
    }

    return 0;
}
1;


