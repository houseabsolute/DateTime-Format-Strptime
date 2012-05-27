use strict;
use warnings;

use Test::More 0.88;

eval "use Test::Pod 1.14";
plan skip_all => "Test::Pod 1.14 required for testing POD" if $@;

all_pod_files_ok();
