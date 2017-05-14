use strict;
use warnings;
use Data::Dumper;
use POSIX qw(strftime);
open (my $fh, ">>", "output_clipboard.txt");
my $last_clipboard_contents;
my $command;
my $salt;
#get the user's OS
my $os = $^O;
#if they are using a Mac
if ($^O =~ /darwin/) {
    $command = "pbpaste";
}
#if they are using windows
elsif ($^O =~ /MSWin32/) {
    $command = "paste";
}
else {
    #apologize for not supporting linux
    print "Unsupported operating system. Yes, I know I'm a bad person\n";
    print "for not supporting Linux. I'll get to it!\n";
    exit(1);
}

open (my $secret_file, "<", "secrets.txt") or die "Could not open file!\n";

my $encrypt;
if (-e "salt") {
    $encrypt = 1;
}
if ($encrypt) { 
    open (my $salt_file, "<", "salt") or die "Could not open file!\n";
    #get salt.
    while (my $row = <$salt_file>) {
        chomp $row;
        $salt = $row;
    }
}




if ($encrypt) {
    #get encrypted strings;
    my @secrets;
    while (my $row = <$secret_file>) {
        chomp $row;
        push(@secrets, $row);
    }

    if (!$salt || $salt eq '') {
        print "Yo, make a salt in the 'salt' file.\n";
        print "Just type in some random characters on one line\n";
        print "only and boom, there is your salt.\n";
        exit(1);
    }
}

print "ClipBoardSaver is running... Ctrl+C to quit\n";
while (1) {

    #wait a second before checking clipboard
    sleep(1);
    #get the command with the OS's clipboard command
    my $clipboard_contents = `$command`;
    my $time = time;
    my $temp = strftime("%m/%d/%Y %H:%M:%S",localtime($time));
    #if the clipboard contents don't match what we have previously
    if ($last_clipboard_contents and ($clipboard_contents ne $last_clipboard_contents)) {
        $last_clipboard_contents = $clipboard_contents;

        if ($encrypt) {
            $clipboard_contents = _check_if_encrypted($clipboard_contents);
        }
        print $fh "$clipboard_contents  ||  Saved at: $temp\n";
    }   
    #if nothing has been logged yet, post to file   
    elsif (!$last_clipboard_contents) {

        $last_clipboard_contents = $clipboard_contents;
        if ($encrypt) {
            $clipboard_contents = _check_if_encrypted($clipboard_contents);
        }
        print $fh "$clipboard_contents  ||  Saved at: $temp\n";
    }   
}


sub _check_if_encrypted {

    my $clip = shift;

    #encrypt with the given salt.
    my $encrypt = crypt($clip, $salt); 
    foreach my $secret (@secrets) {
        if ($secret eq $encrypt) { #if we found an encrypted match, return that
            return $encrypt;
        }
    }

    #otherwise, return what it was.
    return $clip;
}
