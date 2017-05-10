use strict;
use warnings;
print "Pbcopy is running... Ctrl+C to quit\n";
open (my $fh, ">>", "pbpaste.txt");
my $lastpbpaste;
my $command;

#get the user's OS
my $os = $^O;

#if they are using a Mac
if ($^O =~ /darwin/) {
    $command = `pbpaste`;
}
#if they are using windows
elsif ($^O =~ /MSWin32/) {
    $command = `paste`;
}
else {
    #apologize for not supporting linux
    print "Unsupported operating system. Yes, I know I'm a bad person\n";
    print "for not supporting Linux. I'll get to it!\n";
    exit(1);
}

while (1) {

    #wait a second before checking clipboard
    sleep(1);
    #get the command with the OS's clipboard command
    my $pbpaste = `$command`;
    #if the clipboard contents don't match what we have previously
    if ($lastpbpaste and ($pbpaste ne $lastpbpaste)) {
        $lastpbpaste = $pbpaste;
        print $fh "$pbpaste\n";
    }   
    #if nothing has been logged yet, post to file   
    elsif (!$lastpbpaste) {
        print $fh "$pbpaste\n";
        $lastpbpaste = $pbpaste;
    }   
}
