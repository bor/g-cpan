#!/usr/bin/env perl
# check for test code coverage

use strict;
use warnings;

use File::Glob ':glob';
use Test::More;

# skip if doing a regular tests
plan skip_all => "Developer's tests not required for installation"
  unless $ENV{DEV_TESTING};

eval { require Test::Strict; };    ## no critic (ErrorHandling::RequireCheckingReturnValueOfEval)
plan skip_all => 'Test::Strict required' if $@;

{
    no warnings 'once';            ## no critic (TestingAndDebugging::ProhibitNoWarnings)

    # skip dev. tests
    $Test::Strict::TEST_SKIP = [ glob('t/9?_*.t') ];
    # ignore 't/' dir
    $Test::Strict::DEVEL_COVER_OPTIONS .= ',+inc,"t/\b"';
    # shut up warnings from Devel::Cover
    $Test::Strict::DEVEL_COVER_OPTIONS .= ',-silent,1';
}

# arg is a overage acceptance level
Test::Strict::all_cover_ok(60);
