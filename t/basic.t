use strict;
use warnings;

use Test::More 0.96;

use DateTime::Format::Strptime;

for my $test ( _tests_from_data() ) {
    subtest(
        qq{$test->{name} - $test->{pattern} parses "$test->{input}"},
        sub {
            my $parser = DateTime::Format::Strptime->new(
                pattern  => $test->{pattern},
                on_error => 'croak',
            );

            my $dt = $parser->parse_datetime( $test->{input} );

            my $expect = $test->{expect};
            for my $meth ( sort keys %{$expect} ) {
                is(
                    $dt->$meth,
                    $expect->{$meth},
                    "$meth is $expect->{$meth}"
                );
            }
        }
    );
}


sub _tests_from_data {
    my @tests;

    my $d = do { local $/; <DATA> };
    while ( $d =~ /\[(.+?)\]\n(.+?)\n(.+?)\n(.+?)\n\n/sg ) {
        push @tests, {
            name    => $1,
            pattern => $2,
            input   => $3,
            expect  => {
                map { split /\s+=>\s+/ } split /\n/, $4,
            },
        };
    }

    return @tests;
}

# my @tests = (

#     # Simple times
#     [ '%H:%M:%S',    '23:45:56' ],
#     [ '%l:%M:%S %p', '11:34:56 PM' ],

#     # With Nanoseconds
#     [ '%H:%M:%S.%N',  '23:45:56.123456789' ],
#     [ '%H:%M:%S.%6N', '23:45:56.123456' ],
#     [ '%H:%M:%S.%3N', '23:45:56.123' ],

#     # Complex dates
#     [ '%Y;%j = %Y-%m-%d',      '2003;056 = 2003-02-25' ],
#     [ q|%d %b '%y = %Y-%m-%d|, q|25 Feb '03 = 2003-02-25| ],

#     # Leading spaces
#     [ '%e-%b-%Y %T %z', '13-Jun-2010 09:20:47 -0400' ],
#     [ '%e-%b-%Y %T %z', ' 3-Jun-2010 09:20:47 -0400' ],
# );

done_testing();

__DATA__
[ISO8601]
%Y-%m-%dT%H:%M:%S
2015-10-08T15:39:44
year   => 2015
month  => 10
day    => 8
hour   => 15
minute => 39
second => 44

[date with 4-digit year]
%Y-%m-%d
1998-12-31
year  => 1998
month => 12
day   => 31

[date with 2-digit year]
%y-%m-%d
98-12-31
year  => 1998
month => 12
day   => 31

[date with leading space on month]
%e-%b-%Y
 3-Jun-2010
year  => 2010
month => 6
day   => 3

[year and day of year]
%Y years %j days
1998 years 312 days
year  => 1998
month => 11
day   => 8

[date with abbreviated month]
%b %d %Y
Jan 24 2003
year  => 2003
month => 1
day   => 24

[date with abbreviated month is case-insensitive]
%b %d %Y
jAN 24 2003
year  => 2003
month => 1
day   => 24

[date with full month]
%B %d %Y
January 24 2003
year  => 2003
month => 1
day   => 24

[date with full month is case-insensitive]
%B %d %Y
jAnUAry 24 2003
year  => 2003
month => 1
day   => 24

[24 hour time]
%H:%M:%S
23:45:56
year   => 1
month  => 1
day    => 1
hour   => 23
minute => 45
second => 56

[12 hour time (PM)]
%l:%M:%S %p
11:45:56 PM
year   => 1
month  => 1
day    => 1
hour   => 23
minute => 45
second => 56

[12 hour time (am) and am/pm is case insensitive]
%l:%M:%S %p
11:45:56 am
year   => 1
month  => 1
day    => 1
hour   => 11
minute => 45
second => 56
