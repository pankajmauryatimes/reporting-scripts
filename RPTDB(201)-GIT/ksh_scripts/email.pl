#!/usr/bin/perl

use strict;
#use DBI;
#use DBD::DB2::Constants;
#use DBD::DB2;
use MIME::Lite;
use Net::SMTP;

my $MAX_SIZE = 999999;

if($#ARGV < 3) {
  print "Usage $0 [DB KEY] [\"SQL\"] [\"To Mail Id comma seprated\"] [\"CC Mail Id comma seprated\"] [Subject]\n";
  exit;
}

#my $dbKey = shift;
my $fileName = shift;
#my $sql = shift;
my $toAdd= shift;
my $ccAdd= shift;
my $subject=shift;
my $msgBody=shift;
#&cleanup;
#my $config = &loadConfig($dbKey);

#if(!$config) {
#   print "Invalid DB Key !";
#   exit;
#}

#my ($dbName,$hostName,$port,$user,$pass) = @$config;
#my $status = &fnDbResults ($dbName,$hostName,$port,$user,$pass,$sql);
#if($status == 1) { 
  my $toMail = compressAndCalculateSize();
  if($toMail == 1) {
       print "Mailing";
       dbFileMail($toAdd,$ccAdd,$subject,$msgBody);
  }  
#}

#---------------------------------------------------------
sub cleanup {
    system "rm -rf $fileName.*";
}


sub fnDbResults {
	my($dbName,$hostName,$port,$user,$pass,$sql)=@_;
	my $conString = "dbi:DB2:DATABASE=$dbName;HOSTNAME=$hostName;PORT=$port;PROTOCOL=TCPIP;UID=$user;PWD=$pass;";
	my $dbConHandle = DBI->connect($conString,$user,$pass) || die "Connection failed with error:$DBI::errstr";
	my $dbStatement = "$sql";
	my $preStatement = $dbConHandle->prepare($dbStatement);
	$preStatement->execute();

	my $fdbOutput = "${fileName}.csv";
	open (SQL,">>$fdbOutput")||die("This file will not open!");

	my @cols = @{$preStatement->{NAME}};

	for my $name (@cols) {
    		print SQL $name,",";
	}

	print SQL "\n";
	my $rows = $preStatement->fetchall_arrayref();
	
  	for my $row (@$rows) {
       		for my $col (@$row) {
         		print SQL "$col,";
       		}
       	print SQL "\n";
  	}
  	warn "Data fetching terminated early by error: $DBI::errstr\n"
      	if $DBI::err;
		$preStatement->finish();
		$dbConHandle->disconnect();
	close(SQL);
        return 1;
} 
sub compressAndCalculateSize {
    #system "zip $fileName.csv.zip $fileName.csv";
    my $filesize = -s "/home/datareq/generic_etl/wip/$fileName.zip";
    print "Size: $filesize bytes\n";
    if($filesize > $MAX_SIZE) {
        print "File too big to mail !";
    	return 0;
    }
    return 1;
}

sub dbFileMail {
    my $to = shift;
    my $cc = shift;
    my $msubject = shift;
    my $mbody = shift;

    # Adjust sender, recipient and your SMTP mailhost
    my $mail_host = 'ranchi.tbsl.in';
    my $from_address = 'dbteam@timesjobs.com';
    my $to_address = $to;
    my $cc_address = $cc;
    
    # Adjust subject and body message
    my $subject = $msubject;
    my $message_body = $mbody;
    
    # Adjust the filenames
    my $my_file_zip = "$fileName.zip";
    my $your_file_zip = "$fileName.zip";
    
    # Create the multipart container
    my $msg = MIME::Lite->new (
      From => $from_address,
      To => $to_address,
      Cc => $cc_address,
      Subject => $subject,
      Type =>'multipart/mixed'
    ) or die "Error creating multipart container: $!\n";

    # Add the text message part
    $msg->attach (
      Type => 'TEXT',
      Data => $message_body
      ) or die "Error adding the text message part: $!\n";

    # Add the ZIP file
    $msg->attach (
       Type => 'application/zip',
       Path => $my_file_zip,
       Filename => $your_file_zip,
       Disposition => 'attachment'
    ) or die "Error adding $my_file_zip: $!\n";
    
    # Send the Message
    $msg->send('smtp', $mail_host, Timeout=>500);
}

