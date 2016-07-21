#!/usr/bin/env perl

use lib 'lib';
use strict;
use warnings;

use Test::More;

use_ok('Gentoo::Portage::Q');

my $portageq = new_ok('Gentoo::Portage::Q');

my $eroot = $portageq->envvar('EROOT');
is( $eroot, '/', 'envvar("EROOT")' );

is( $portageq->get_repo_path( $eroot, 'gentoo' ), '/usr/portage', 'get_repo_path($eroot,"gentoo")' );

done_testing();
