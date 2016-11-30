#!/usr/bin/env perl
# check code for FIXMEs

use strict;
use warnings;

use Test::More;

# skip if doing a regular tests
plan skip_all => "Developer's tests not required for installation"
  unless $ENV{DEV_TESTING};

eval { require Test::Fixme; };    ## no critic (ErrorHandling::RequireCheckingReturnValueOfEval)
plan skip_all => 'Test::Fixme required' if $@;

Test::Fixme::run_tests(
    filename_match => qr/\/\w+\.?\w+$/,
    match          => qr/FIXME|\bBUG\b|XXX/,
    where          => [qw/ bin lib /]
);
