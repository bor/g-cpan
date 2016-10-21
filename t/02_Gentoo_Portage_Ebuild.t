#!/usr/bin/env perl

use lib 'lib';
use strict;
use warnings;

use Test::More tests => 2;

use_ok('Gentoo::Portage::Ebuild');

my $ebuild = new_ok('Gentoo::Portage::Ebuild');

