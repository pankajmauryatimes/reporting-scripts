#!/usr/bin/perl
use warnings;
use File::Basename;
$backup_folder = '/cognos/cognos_backup/';
my ($day,$month,$date,$hour,$year) = split /\s+/,scalar localtime;
my $folder = "$backup_folder/$year-$month-$date";
#print "$folder\n";
##system "rm -rf $backup_folder/*";
if ( -d "$folder" ) { system "rm -rf $folder";}
mkdir($folder) or die("Cannot create a folder called '$folder'");
##sleep 100;
my $config_file = "/usr/local/script/database_config";
my @databases = removeComments(getFileContents($config_file));
#
foreach my $database (@databases) {
next if ($database eq '');
chomp($database);
`/usr/bin/mysqldump --routines $database | gzip > $folder/$database.sql.gz`;
}
sub getFileContents {
my $file = shift;
open (FILE,$file) || die("Can't open '$file': $!");
my @lines=<FILE>;
close(FILE);
return @lines;
}
sub removeComments {
my @lines = @_;
@cleaned = grep(!/^\s*#/, @lines); #Remove Comments
@cleaned = grep(!/^\s*$/, @cleaned); #Remove Empty lines
return @cleaned;
}
