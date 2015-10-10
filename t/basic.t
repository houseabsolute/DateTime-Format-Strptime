use strict;
use warnings;

use Test::More 0.96;

use DateTime::Format::Strptime;

my $parser = DateTime::Format::Strptime->new(
    pattern  => '%Y-%m-%dT%H:%M:%s',
    on_error => 'croak',
);

my %tests = (
    '2015-10-08T15:39:44' => {
        year   => 2015,
        month  => 10,
        day    => 8,
        hour   => 15,
        minute => 39,
        second => 44,
    },
);

for my $string ( sort keys %tests ) {
    my $dt   = $parser->parse_datetime($string);
    my $case = $tests{$string};
    for my $meth ( sort keys %{$case} ) {
        is( $dt->$meth, $case->{$meth}, "$meth is $case->{$meth}" );
    }
}

done_testing();
