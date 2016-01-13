use strict;
use warnings;
use strict;
use warnings;
use utf8;

use lib 't/lib';

use T qw( run_tests_from_data test_datetime_object );
use Test::More 0.96;
use Test::Fatal;

use DateTime::Format::Strptime;

run_tests_from_data( \*DATA );

done_testing();

__DATA__
[Leading and trailing space]
%Y%m%d
  20151222
skip round trip
year => 2015
month => 12
day => 22

[Olson time zone in upper case]
%Y %O
2015 AMERICA/NEW_YORK
skip round trip
year => 2015
time_zone_long_name => America/New_York

[Olson time zone in lower case]
%Y %O
2015 america/new_york
skip round trip
year => 2015
time_zone_long_name => America/New_York

[Olson time zone in random case]
%Y %O
2015 amERicA/new_YORK
skip round trip
year => 2015
time_zone_long_name => America/New_York

[Month name match is not too greedy]
%d%b%y
15Aug07
year  => 2007
month => 8
day   => 15

[Trailing text after match]
%Y-%m-%d
2016-01-13 in the afternoon
skip round trip
year  => 2016
month => 1
day   => 13
