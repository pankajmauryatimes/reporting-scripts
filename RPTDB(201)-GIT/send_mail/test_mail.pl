#!/usr/bin/perl
use warnings;
use MIME::Lite;
use Net::SMTP;


#Blocks to create to cc and filename variables

my $to = 'sanjay.biswas@timesgroup.com';
my $cc = 'datarequest@timesgroup.com';
my $zipfile = 'test.zip';
my $zippath = 'test.zip';

# Function instances for passing to cc and filename
sendMailFunc($to,$cc,$zipfile,$zippath);

# Function Declaration for sending mail
sub sendMailFunc {

	my $to_address = shift;
	my $cc_address = shift;
	my $my_file_zip = shift;
	my $your_file_zip = shift;

	my $mail_host = 'pune.tbsl.in';
	my $from_address = 'saints@magicbricks.com';
	my $subject = "And Requirement Data - Based On Budget";
	my $message_body = "Hi,\nPlease find the attachment.\n\n\n\n--\nThanks & Regards\nGovind Singh\n9818681532";

	$msg = MIME::Lite->new (
	  From => $from_address,
	  To => $to_address,
	  Cc => $cc_address,
	  Subject => $subject,
	  Type =>'multipart/mixed'
	) or die "Error creating multipart container: $!\n";

	$msg->attach (
  	  Type => 'TEXT',
  	  Data => $message_body
	) or die "Error adding the text message part: $!\n";

	$msg->attach (
	   Type => 'application/zip',
	   Path => $my_file_zip,
	   Filename => $your_file_zip,
	   Disposition => 'attachment'
	) or die "Error adding $my_file_zip: $!\n";

	MIME::Lite->send('smtp', $mail_host, Timeout=>500);
	$msg->send;
}
