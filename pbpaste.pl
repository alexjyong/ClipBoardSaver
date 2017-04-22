use strict;
use warnings;



print "Pbcopy is running... Ctrl+C to quit\n";

open (my $fh, ">>", "pbpaste.txt");
my $lastpbpaste;
while (1) {

    sleep(1);
    my $pbpaste = `pbpaste`;
    if ($lastpbpaste and $pbpaste ne $lastpbpaste) {
        $lastpbpaste = $pbpaste;
        print $fh "$pbpaste\n";
    }   

}
