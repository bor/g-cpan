#!/usr/bin/env perl
# check code for according to Perl::Critic rules

use strict;
use warnings;

use Test::More;

# skip if doing a regular tests
plan skip_all => "Developer's tests not required for installation"
  unless $ENV{DEV_TESTING};

eval { require Test::Perl::Critic; };    ## no critic (ErrorHandling::RequireCheckingReturnValueOfEval)
plan skip_all => "Test::Perl::Critic required for testing PBP compliance" if $@;

if ( -e '.perlcriticrc' ) {
    Test::Perl::Critic->import( -profile => '.perlcriticrc' );
}
else {
    diag 'warning: can\'t found .perlcriticrc profile, use default';
}

Test::Perl::Critic::all_critic_ok(qw( bin lib t ));
