use strict;
use warnings;
my $salt;

open (my $fh, "<", "salt")  or die "Could not open file! $!\n";

while (my $row = <$fh>) {
  chomp $row;
    $salt = $row;
}

if (!$salt || $salt eq '') {
    print "Yo, make a salt in the 'salt' file.\n";
    print "Just type in some random characters on one line\n";
    print "only and boom, there is your salt.\n";
    exit(1);
}

print "This little script will encrypt certain phrases typed into the text\n";
print "file at this location. If you haven't already, you wil need to make \n";
print "a salt in a file called salt in the same directory as this file.\n";


print "\nWarning! Echo is on! So make sure you don't have people over your\n";
print "shoulder when you type stuff in!\n";
print "Press Ctrl+D when you're done encrypting stuffs.\n";

open (my $fh2, ">>", "secrets.txt") or die "Could not open file! $!";
while (1) {
    my $phrase = <STDIN>;

    if (!$phrase) {
        exit(1);
    }   
    chomp($phrase);
    $phrase = crypt($phrase, $salt);
    print $fh2 $phrase;
    print $fh2 "\n";
}
