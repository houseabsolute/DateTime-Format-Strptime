use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'DateTime::Format::Strptime',
    VERSION_FROM => 'lib/DateTime/Format/Strptime.pm',    # finds $VERSION
    AUTHOR       => 'Rick Measham (rickm@cpan.org)',
    ABSTRACT  => 'Parse and format strp and strf time patterns',
    PREREQ_PM => {
        'DateTime'           => '0.4304',
        'DateTime::Locale'   => '0.45',
        'DateTime::TimeZone' => '0.79',
        'Params::Validate'   => '0.64',
    },
);
