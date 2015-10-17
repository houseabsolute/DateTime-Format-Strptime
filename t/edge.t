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

run_tests_from_data(\*DATA);

done_testing();

__DATA__
[Leading and trailing space]
%Y%m%d
  20151222
skip round trip
year => 2015
month => 12
day => 22
