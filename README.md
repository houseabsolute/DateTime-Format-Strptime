# NAME

DateTime::Format::Strptime - Parse and format strp and strf time patterns

# VERSION

version 1.56

# SYNOPSIS

    use DateTime::Format::Strptime;

    my $strp = DateTime::Format::Strptime->new(
        pattern   => '%T',
        locale    => 'en_AU',
        time_zone => 'Australia/Melbourne',
    );

    my $dt = $strp->parse_datetime('23:16:42');

    $strp->format_datetime($dt);

    # 23:16:42

    # Croak when things go wrong:
    my $strp = DateTime::Format::Strptime->new(
        pattern   => '%T',
        locale    => 'en_AU',
        time_zone => 'Australia/Melbourne',
        on_error  => 'croak',
    );

    $newpattern = $strp->pattern('%Q');

    # Unidentified token in pattern: %Q in %Q at line 34 of script.pl

    # Do something else when things go wrong:
    my $strp = DateTime::Format::Strptime->new(
        pattern   => '%T',
        locale    => 'en_AU',
        time_zone => 'Australia/Melbourne',
        on_error  => \&phone_police,
    );

# DESCRIPTION

This module implements most of `strptime(3)`, the POSIX function that
is the reverse of `strftime(3)`, for `DateTime`. While `strftime`
takes a `DateTime` and a pattern and returns a string, `strptime` takes
a string and a pattern and returns the `DateTime` object
associated.

# CONSTRUCTOR

- new( pattern => $strptime\_pattern )

    Creates the format object. You must specify a pattern, you can also
    specify a `time_zone` and a `locale`. If you specify a time zone
    then any resulting `DateTime` object will be in that time zone. If you
    do not specify a `time_zone` parameter, but there is a time zone in the
    string you pass to `parse_datetime`, then the resulting `DateTime` will
    use that time zone.

    You can optionally use an on\_error parameter. This parameter has three
    valid options:

    - 'undef'

        (not undef, 'undef', it's a string not an undefined value)

        This is the default behavior. The module will return undef whenever it gets
        upset. The error can be accessed using the `$object->errmsg` method.
        This is the ideal behaviour for interactive use where a user might provide an
        illegal pattern or a date that doesn't match the pattern.

    - 'croak'

        (not croak, 'croak', it's a string, not a function)

        This used to be the default behaviour. The module will croak with an
        error message whenever it gets upset.

    - sub{...} or \\&subname

        When given a code ref, the module will call that sub when it gets upset.
        The sub receives two parameters: the object and the error message. Using
        these two it is possible to emulate the 'undef' behavior. (Returning a
        true value causes the method to return undef. Returning a false value
        causes the method to bravely continue):

            sub { $_[0]->{errmsg} = $_[1]; 1 },

# METHODS

This class offers the following methods.

- parse\_datetime($string)

    Given a string in the pattern specified in the constructor, this method
    will return a new `DateTime` object.

    If given a string that doesn't match the pattern, the formatter will
    croak or return undef, depending on the setting of on\_error in the constructor.

- format\_datetime($datetime)

    Given a `DateTime` object, this methods returns a string formatted in
    the object's format. This method is synonymous with `DateTime`'s
    strftime method.

- locale($locale)

    When given a locale or `DateTime::Locale` object, this method sets
    its locale appropriately. If the locale is not understood, the method
    will croak or return undef (depending on the setting of on\_error in
    the constructor)

    If successful this method returns the current locale. (After
    processing as above).

- pattern($strptime\_pattern)

    When given a pattern, this method sets the object's pattern. If the
    pattern is invalid, the method will croak or return undef (depending on
    the value of the `on_error` parameter)

    If successful this method returns the current pattern. (After processing
    as above)

- time\_zone($time\_zone)

    When given a name, offset or `DateTime::TimeZone` object, this method
    sets the object's time zone. This effects the `DateTime` object
    returned by parse\_datetime

    If the time zone is invalid, the method will croak or return undef
    (depending on the value of the `on_error` parameter)

    If successful this method returns the current time zone. (After processing
    as above)

- errmsg

    If the on\_error behavior of the object is 'undef', error messages with
    this method so you can work out why things went wrong.

    This code emulates a `$DateTime::Format::Strptime` with
    the `on_error` parameter equal to `'croak'`:

    `$strp->pattern($pattern) or die $DateTime::Format::Strptime::errmsg`

# EXPORTS

There are no methods exported by default, however the following are
available:

- strptime( $strptime\_pattern, $string )

    Given a pattern and a string this function will return a new `DateTime`
    object.

- strftime( $strftime\_pattern, $datetime )

    Given a pattern and a `DateTime` object this function will return a
    formatted string.

# STRPTIME PATTERN TOKENS

The following tokens are allowed in the pattern string for strptime
(parse\_datetime):

- %%

    The % character.

- %a or %A

    The weekday name according to the current locale, in abbreviated form or
    the full name.

- %b or %B or %h

    The month name according to the current locale, in abbreviated form or
    the full name.

- %C

    The century number (0-99).

- %d or %e

    The day of month (01-31). This will parse single digit numbers as well.

- %D

    Equivalent to %m/%d/%y. (This is the American style date, very confusing
    to non-Americans, especially since %d/%m/%y is	widely used in Europe.
    The ISO 8601 standard pattern is %F.)

- %F

    Equivalent to %Y-%m-%d. (This is the ISO style date)

- %g

    The year corresponding to the ISO week number, but without the century
    (0-99).

- %G

    The year corresponding to the ISO week number.

- %H

    The hour (00-23). This will parse single digit numbers as well.

- %I

    The hour on a 12-hour clock (1-12).

- %j

    The day number in the year (1-366).

- %m

    The month number (01-12). This will parse single digit numbers as well.

- %M

    The minute (00-59). This will parse single digit numbers as well.

- %n

    Arbitrary whitespace.

- %N

    Nanoseconds. For other sub-second values use `%[number]N`.

- %p

    The equivalent of AM or PM according to the locale in use. (See
    [DateTime::Locale](https://metacpan.org/pod/DateTime::Locale))

- %r

    Equivalent to %I:%M:%S %p.

- %R

    Equivalent to %H:%M.

- %s

    Number of seconds since the Epoch.

- %S

    The second (0-60; 60 may occur for leap seconds. See
    [DateTime::LeapSecond](https://metacpan.org/pod/DateTime::LeapSecond)).

- %t

    Arbitrary whitespace.

- %T

    Equivalent to %H:%M:%S.

- %U

    The week number with Sunday the first day of the week (0-53). The first
    Sunday of January is the first day of week 1.

- %u

    The weekday number (1-7) with Monday = 1. This is the `DateTime` standard.

- %w

    The weekday number (0-6) with Sunday = 0.

- %W

    The week number with Monday the first day of the week (0-53). The first
    Monday of January is the first day of week 1.

- %y

    The year within century (0-99). When a century is not otherwise specified
    (with a value for %C), values in the range 69-99 refer to years in the
    twentieth century (1969-1999); values in the range 00-68 refer to years in the
    twenty-first century (2000-2068).

- %Y

    The year, including century (for example, 1991).

- %z

    An RFC-822/ISO 8601 standard time zone specification. (For example
    \+1100) \[See note below\]

- %Z

    The timezone name. (For example EST -- which is ambiguous) \[See note
    below\]

- %O

    This extended token allows the use of Olson Time Zone names to appear
    in parsed strings. **NOTE**: This pattern cannot be passed to `DateTime`'s
    `strftime()` method, but can be passed to `format_datetime()`.

# AUTHOR EMERITUS

This module was created by Rick Measham.

# BUGS

Please report any bugs or feature requests to
`bug-datetime-format-strptime@rt.cpan.org`, or through the web interface at
[http://rt.cpan.org](http://rt.cpan.org). I will be notified, and then you'll automatically be
notified of progress on your bug as I make changes.

# SEE ALSO

`datetime@perl.org` mailing list.

http://datetime.perl.org/

[perl](https://metacpan.org/pod/perl), [DateTime](https://metacpan.org/pod/DateTime), [DateTime::TimeZone](https://metacpan.org/pod/DateTime::TimeZone), [DateTime::Locale](https://metacpan.org/pod/DateTime::Locale)

# AUTHORS

- Dave Rolsky <autarch@urth.org>
- Rick Measham <rickm@cpan.org>

# COPYRIGHT AND LICENSE

This software is Copyright (c) 2014 by Dave Rolsky.

This is free software, licensed under:

    The Artistic License 2.0 (GPL Compatible)
