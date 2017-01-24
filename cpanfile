requires "Carp" => "0";
requires "DateTime" => "1.00";
requires "DateTime::Locale" => "0.45";
requires "DateTime::Locale::Base" => "0";
requires "DateTime::TimeZone" => "0.79";
requires "Exporter" => "0";
requires "Package::DeprecationManager" => "0.15";
requires "Params::ValidationCompiler" => "0";
requires "Specio" => "0.18";
requires "Specio::Declare" => "0";
requires "Specio::Exporter" => "0";
requires "Specio::Library::Builtins" => "0";
requires "Specio::Library::String" => "0";
requires "Try::Tiny" => "0";
requires "constant" => "0";
requires "parent" => "0";
requires "strict" => "0";
requires "warnings" => "0";

on 'test' => sub {
  requires "ExtUtils::MakeMaker" => "0";
  requires "File::Spec" => "0";
  requires "Test::Builder" => "0";
  requires "Test::Fatal" => "0";
  requires "Test::More" => "0.96";
  requires "Test::Warnings" => "0";
  requires "lib" => "0";
  requires "utf8" => "0";
};

on 'test' => sub {
  recommends "CPAN::Meta" => "2.120900";
};

on 'configure' => sub {
  requires "ExtUtils::MakeMaker" => "0";
};

on 'configure' => sub {
  suggests "JSON::PP" => "2.27300";
};

on 'develop' => sub {
  requires "Code::TidyAll::Plugin::Test::Vars" => "0.02";
  requires "Cwd" => "0";
  requires "DateTime::Locale" => "1.03";
  requires "File::Spec" => "0";
  requires "IO::Handle" => "0";
  requires "IPC::Open3" => "0";
  requires "Parallel::ForkManager" => "1.19";
  requires "Perl::Critic" => "1.126";
  requires "Perl::Tidy" => "20160302";
  requires "Pod::Coverage::TrustPod" => "0";
  requires "Pod::Wordlist" => "0";
  requires "Test::CPAN::Meta::JSON" => "0.16";
  requires "Test::Code::TidyAll" => "0.50";
  requires "Test::DependentModules" => "0";
  requires "Test::EOL" => "0";
  requires "Test::Fatal" => "0";
  requires "Test::Mojibake" => "0";
  requires "Test::More" => "0.96";
  requires "Test::NoTabs" => "0";
  requires "Test::Pod" => "1.41";
  requires "Test::Pod::Coverage" => "1.08";
  requires "Test::Portability::Files" => "0";
  requires "Test::Spelling" => "0.12";
  requires "Test::Vars" => "0.009";
  requires "Test::Version" => "2.05";
  requires "blib" => "1.01";
  requires "perl" => "5.006";
};
