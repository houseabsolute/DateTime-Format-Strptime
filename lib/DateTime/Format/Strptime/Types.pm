package DateTime::Format::Strptime::Types;

use strict;
use warnings;

our $VERSION = '1.80';

use parent 'Specio::Exporter';

use DateTime;
use DateTime::Locale::Base;
use DateTime::Locale::FromData;
use DateTime::TimeZone;
use Specio 0.33;
use Specio::Declare;
use Specio::Library::Builtins -reexport;
use Specio::Library::String -reexport;

union(
    'Locale',
    of => [
        object_isa_type('DateTime::Locale::Base'),
        object_isa_type('DateTime::Locale::FromData'),
    ],
);

coerce(
    t('Locale'),
    from   => t('NonEmptyStr'),
    inline => sub {"DateTime::Locale->load( $_[1] )"},
);

object_isa_type('DateTime');

my $time_zone_object = object_can_type(
    'TZObject',
    methods => [
        qw(
            is_floating
            is_utc
            name
            offset_for_datetime
            short_name_for_datetime
        )
    ],
);

declare(
    'TimeZone',
    of => [ t('NonEmptySimpleStr'), $time_zone_object ],
);

coerce(
    t('TimeZone'),
    from   => t('NonEmptyStr'),
    inline => sub {"DateTime::TimeZone->new( name => $_[1] )"},
);

union(
    'OnError',
    of => [
        enum( values => [ 'croak', 'undef' ] ),
        t('CodeRef'),
    ],
);

1;

# ABSTRACT: Types used for parameter checking in DateTime::Format::Strptime

__END__

=pod

=for Pod::Coverage .*

=head1 DESCRIPTION

This module has no user-facing parts.

=cut
