use 5.006;

use strict;
use warnings;

use Module::Build;

Module::Build->new(
    module_name => 'DateTime::Format::Strptime',
    dist_author => 'Dave Rolsky <autarch@urth.org>',
    license     => 'perl',
    requires    => {
        'DateTime'           => '0.4304',
        'DateTime::Locale'   => '0.45',
        'DateTime::TimeZone' => '0.79',
        'Params::Validate'   => '0.64',
    },
    build_requires     => { 'Module::Build' => 0 },
    sign               => 1,
    create_makefile_pl => 'traditional',
    meta_merge         => {
        resources => {
            homepage => 'http://datetime.perl.org/',
            bugtracker =>
                'http://rt.cpan.org/NoAuth/Bugs.html?Dist=DateTime-Format-Strptime',
            repository => 'http://hg.urth.org/hg/DateTime-Format-Strptime',
        },
    },
)->create_build_script;
