use strict;
use warnings;

use Test::More 0.96;
use Test::Fatal;

use DateTime::Format::Strptime;
use DateTime;

my $strptime = DateTime::Format::Strptime->new(
    pattern  => '%B %Y',
    locale   => 'pt',
    on_error => 'croak',
);


eval { $strptime->format_datetime('somestring') };
like($@, qr/format_datetime\(\) expects parameter an object of type DateTime/);

done_testing();
