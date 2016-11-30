#!/usr/bin/env perl
# check for pod coverage

use strict;
use warnings;

use Test::More;

# skip if doing a regular tests
plan skip_all => "Developer's tests not required for installation"
  unless $ENV{DEV_TESTING};

eval {    ## no critic (ErrorHandling::RequireCheckingReturnValueOfEval)
    require Pod::Coverage;
    Pod::Coverage->VERSION(0.18);
    require Test::Pod::Coverage;
    Test::Pod::Coverage->VERSION(1.08);
};

plan skip_all => 'Test::Pod::Coverage (>=1.08) and Pod::Coverage (>=0.18) are required' if $@;

Test::Pod::Coverage::all_pod_coverage_ok();
