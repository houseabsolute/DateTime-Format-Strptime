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
        }
    );
}

done_testing();

sub test_days {
    my $locale = shift;

    subtest(
        'days',
        sub {
            my $pattern = "%Y-%m-%d %A";
            foreach my $day ( 1 .. 7 ) {
                my $dt
                    = DateTime->now( locale => $locale )->set( day => $day );
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
                    "Constructor with Day Name"
                );

                my $parsed;
                is(
                    exception { $parsed = $strptime->parse_datetime($input) },
                    undef,
                    "Parsed with Day Name"
                );

                is(
                    $parsed->strftime($pattern), $input,
                    "Matched with Day Name"
                );
            }
        }
    );
}

sub test_months {
    my $locale = shift;

    subtest(
        'months',
        sub {
            my $pattern = "%Y-%m-%d %B";
            foreach my $month ( 1 .. 12 ) {
                my $dt = DateTime->now( locale => $locale )
                    ->truncate( to => 'month' )->set( month => $month );
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
                    "Constructor with Month Name"
                );

                my $parsed;
                is(
                    exception { $parsed = $strptime->parse_datetime($input) },
                    undef,
                    "Parsed with Month Name"
                );

                is(
                    $parsed->strftime($pattern), $input,
                    "Matched with Month Name"
                );
            }
        }
    );
}

sub test_am_pm {
    my $locale = shift;

    subtest(
        'am/pm',
        sub {
            my $pattern = "%Y-%m-%d %H:%M %p";
            foreach my $locale (@locales) {
                foreach my $hour ( 11, 12 ) {
                    my $dt = DateTime->now( locale => $locale )
                        ->set( hour => $hour );
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
                        "Constructor with Meridian"
                    );

                    my $parsed;
                    is(
                        exception {
                            $parsed = $strptime->parse_datetime($input)
                        },
                        undef,
                        "Parsed with Meridian"
                    );

                    is(
                        $parsed->strftime($pattern), $input,
                        "Matched with Meridian"
                    );
                }
            }
        }
    );
}
