use ExtUtils::MakeMaker;

print <<'EOF';
-----------------------------------------
 __ _              _   _
/ _\ |_ _ __ _ __ | |_(_)_ __ ___   ___
\ \| __| '__| '_ \| __| | '_ ` _ \ / _ \
_\ \ |_| |  | |_) | |_| | | | | | |  __/
\__/\__|_|  | .__/ \__|_|_| |_| |_|\___|
            |_|
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
       'DateTime'           => '0.4304',
       'DateTime::Locale'   => '0.41',
       'DateTime::TimeZone' => '0.79',
       'Params::Validate'   => '0.64',
    },
);

sub MY::postamble {
return $^O eq 'MSWin32'?
<<'MAKE_FRAG'
test_more :: pure_all
SET PERL_DL_NONLAZY=1
$(FULLPERLRUN) "-MExtUtils::Command::MM" "-e"
"test_harness($(TEST_VERBOSE), '$(INST_LIB)', '$(INST_ARCHLIB)')" t/more/*.t
MAKE_FRAG
:
<<'MAKE_FRAG';
test_more :: pure_all
	PERL_DL_NONLAZY=1 $(FULLPERLRUN) "-MExtUtils::Command::MM" "-e" "test_harness($(TEST_VERBOSE), '$(INST_LIB)', '$(INST_ARCHLIB)')" t/more/*.t
MAKE_FRAG
}
