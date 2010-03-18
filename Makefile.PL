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

sub MY::postamble {
    return $^O eq 'MSWin32'
        ? <<'MAKE_FRAG'
test_more :: pure_all
	set PERL_DL_NON_LAZY=1 & $(FULLPERLRUN) "-MExtUtils::Command::MM" "-e" "test_harness($(TEST_VERBOSE), '$(INST_LIB)', '$(INST_ARCHLIB)')" t/more/*.t
MAKE_FRAG
        : <<'MAKE_FRAG';
test_more :: pure_all
	PERL_DL_NONLAZY=1 $(FULLPERLRUN) "-MExtUtils::Command::MM" "-e" "test_harness($(TEST_VERBOSE), '$(INST_LIB)', '$(INST_ARCHLIB)')" t/more/*.t
MAKE_FRAG
}
