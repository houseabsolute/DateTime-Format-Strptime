use ExtUtils::MakeMaker;

print <<'EOF';
-----------------------------------------
  __                ___
 (_   _|_  ._  ._    |   o  ._ _    _
 __)   |_  |   |_)   |   |  | | |  (/_
               |
-----------------------------------------

To run thousands of other tests (mainly
for developers) then after running 'make'
and 'make test' run 'make test_more':

perl MakeFile.PL
make
make test
make test_more

EOF

WriteMakefile(
    NAME         => 'DateTime::Format::Strptime',
    VERSION_FROM => 'lib/DateTime/Format/Strptime.pm', # finds $VERSION
    AUTHOR       => 'Rick Measham (rickm@cpan.org)',
    ABSTRACT     => 'Parse and format strp and strf time patterns',
    PREREQ_PM    => {
       'DateTime'           => '0.1402',
       'DateTime::Locale'   => '0.35',
       'DateTime::TimeZone' => '0.25',
       'Params::Validate'   => '0.64',
    },
);

sub MY::postamble {
	return <<'MAKE_FRAG';
test_more :: pure_all
	PERL_DL_NONLAZY=1 $(FULLPERLRUN) "-MExtUtils::Command::MM" "-e" "test_harness($(TEST_VERBOSE), '$(INST_LIB)', '$(INST_ARCHLIB)')" t/more/*.t
MAKE_FRAG

}
