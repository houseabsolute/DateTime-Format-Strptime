use strict;
use warnings;
use Test::More;

use DateTime::Format::Strptime;

my $parse_test = sub {
    my ($pattern, $subject, $expect) = @_;
    my $parser = DateTime::Format::Strptime->new( pattern => $pattern );
    is(
        $parser->parse_datetime( $subject )->strftime( $pattern ),
        $expect,
        "$subject is parsed as $expect",
    );
};

subtest 'With suffix' => sub {
    my @subjects = (
        { pattern => '%Y', string => '2016.log', expect => '2016' },
        { pattern => '%F', string => '2015-03-31.log', expect => '2015-03-31' },
    );
    for my $sbj (@subjects) {
        $parse_test->( @$sbj{qw/ pattern string expect /} )
    }
};

subtest 'With prefix' => sub {
    my @subjects = (
        { pattern => '%Y', string => 'pref.2016', expect => '2016' },
        { pattern => '%Y%m%d_%H', string => 'access_log.20150331_23', expect => '20150331_23' },
    );
    for my $sbj (@subjects) {
        $parse_test->( @$sbj{qw/ pattern string expect /} )
    }
};

subtest 'With prefix and suffix' => sub {
    my @subjects = (
        { pattern => '%Y', string => 'cron.2016.log', expect => '2016' },
        { pattern => '%Y%m%d_%H', string => 'access_log.20150331_23.txt', expect => '20150331_23' },
    );
    for my $sbj (@subjects) {
        $parse_test->( @$sbj{qw/ pattern string expect /} )
    }
};

done_testing;
