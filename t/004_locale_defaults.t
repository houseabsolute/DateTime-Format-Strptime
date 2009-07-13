#!perl -w

# t/004_locale_defaults.t - check module dates in various formats

use Test::More tests => 48;
use DateTime::Format::Strptime;
use DateTime;
use DateTime::TimeZone;
use DateTime::Locale;

my $object = DateTime::Format::Strptime->new(
	pattern => '%c',
	diagnostic => 0,
	on_error => 'undef',
);

# Use whatever the current locale is and use DateTime's strftime to get the input data
my $test_datetime = new DateTime(
	year => 1998, month => 12, day => 31,
	hour => 12, minute => 34, second => 56 
);

foreach my $locale ( 'en_AU', 'en_US', 'en_GB', 'fr' ){
	foreach my $pattern ( '%x', '%X', '%c' ){

		$test_datetime->set_locale( $locale );
		my $data = $test_datetime->strftime( $pattern );

		$object->locale( $locale );
		$object->pattern( $pattern );
		
		my $datetime = $object->parse_datetime( $data );

		if ($pattern eq '%x' or $pattern eq '%c') {
			is($datetime->year,  1998, $locale. ' : ' . $pattern . ' : year'  );
			is($datetime->month,   12, $locale. ' : ' . $pattern . ' : month' );
			is($datetime->day,     31, $locale. ' : ' . $pattern . ' : day'   );
		}
		if ($pattern eq '%X' or $pattern eq '%c') {
			is($datetime->hour,    12, $locale. ' : ' . $pattern . ' : hour'  );
			is($datetime->minute,  34, $locale. ' : ' . $pattern . ' : minute');
			is($datetime->second,  56, $locale. ' : ' . $pattern . ' : second');
		}
	}
}


