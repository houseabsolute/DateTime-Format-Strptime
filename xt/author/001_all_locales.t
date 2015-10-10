use strict;
use warnings;

use Test::More 0.96;
use Test::Fatal;

use DateTime::Format::Strptime;
use DateTime::Locale;
use DateTime;

my @locales = sort DateTime::Locale->ids;

foreach my $locale (@locales) {
    subtest(
        $locale,
        sub {
            test_days($locale);
            test_months($locale);
            test_am_pm($locale);
        }
    );
}

done_testing();

sub test_days {
    my $locale = shift;

    subtest(
        'days',
        sub {
            foreach my $day ( 1 .. 7 ) {
                subtest(
                    "Day $day",
                    sub { _test_one_day( $locale, $day ); },
                );
            }
        }
    );
}

sub _test_one_day {
    my $locale = shift;
    my $day    = shift;

    _utf8_output();

    my $pattern = '%Y-%m-%d %A';

    my $dt = DateTime->now( locale => $locale )->set( day => $day );
    my $input = $dt->strftime($pattern);

    my $strptime;
    is(
        exception {
            $strptime = DateTime::Format::Strptime->new(
                pattern  => $pattern,
                locale   => $locale,
                on_error => 'croak',
            );
        },
        undef,
        'constructor with day name in pattern (%A)'
    );

    my $parsed;
    is(
        exception {
            $parsed = $strptime->parse_datetime($input)
        },
        undef,
        "parsed $input"
    );

    is(
        $parsed->strftime($pattern),
        $input,
        'strftime output matches input'
    );
}

sub test_months {
    my $locale = shift;

    subtest(
        'months',
        sub {
            foreach my $month ( 1 .. 12 ) {
                subtest(
                    "Month $month",
                    sub { _test_one_month( $locale, $month ) },
                );
            }
        }
    );
}

sub _test_one_month {
    my $locale = shift;
    my $month  = shift;

    _utf8_output();

    my $pattern = '%Y-%m-%d %B';

    my $dt
        = DateTime->now( locale => $locale )->truncate( to => 'month' )
        ->set( month => $month );
    my $input = $dt->strftime($pattern);
    my $strptime;
    is(
        exception {
            $strptime = DateTime::Format::Strptime->new(
                pattern  => $pattern,
                locale   => $locale,
                on_error => 'croak',
            );
        },
        undef,
        'constructor with month name (%B)'
    );

    my $parsed;
    is(
        exception {
            $parsed = $strptime->parse_datetime($input)
        },
        undef,
        "parsed $input"
    );

    is(
        $parsed->strftime($pattern),
        $input,
        'strftime output matches input'
    );
}

sub test_am_pm {
    my $locale = shift;

    subtest(
        'am/pm',
        sub {
            foreach my $hour ( 0, 11, 12, 23 ) {
                subtest(
                    "Hour $hour",
                    sub { _test_one_hour( $locale, $hour ); },
                );
            }
        }
    );
}

sub _test_one_hour {
    my $locale = shift;
    my $hour   = shift;

    my $pattern = '%Y-%m-%d %H:%M %p';

    _utf8_output();

    my $dt = DateTime->now( locale => $locale )->set( hour => $hour );
    my $input = $dt->strftime($pattern);
    my $strptime;
    is(
        exception {
            $strptime = DateTime::Format::Strptime->new(
                pattern  => $pattern,
                locale   => $locale,
                on_error => 'croak',
            );
        },
        undef,
        'constructor with meridian (%p)'
    );

    my $parsed;
    is(
        exception {
            $parsed = $strptime->parse_datetime($input)
        },
        undef,
        "parsed $input",
    );

    is(
        $parsed->strftime($pattern),
        $input,
        'strftime output matches input'
    );
}

sub _utf8_output {
    binmode $_, ':encoding(UTF-8)'
        for map { Test::Builder->new->$_ }
        qw( output failure_output todo_output );
}
