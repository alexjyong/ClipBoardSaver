use strict;
use warnings;
print "ClipBoardSaver is running... Ctrl+C to quit\n";
open (my $fh, ">>", "ClipBoardSaver.txt");
my $last_clipboard_contents;
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
    my $clipboard_contents = `$command`;
    #if the clipboard contents don't match what we have previously
    if ($last_clipboard_contents and ($clipboard_contents ne $last_clipboard_contents)) {
        $last_clipboard_contents = $clipboard_contents;
        print $fh "$clipboard_contents\n";
    }   
    #if nothing has been logged yet, post to file   
    elsif (!$last_clipboard_contents) {
        print $fh "$clipboard_contents\n";
        $last_clipboard_contents = $clipboard_contents;
    }   
}
