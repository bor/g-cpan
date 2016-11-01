#!/usr/bin/env perl

use lib 'lib';
use strict;
use warnings;

use Test::More tests => 4;

use_ok('Gentoo::Portage::Ebuild');

my $ebuild = new_ok('Gentoo::Portage::Ebuild');

$ebuild = Gentoo::Portage::Ebuild->read('/usr/portage/dev-perl/YAML/YAML-1.180.0.ebuild');
#is( $ebuild->{HOMEPAGE},    'http://' );
is( $ebuild->{DESCRIPTION}, "YAML Ain't Markup Language (tm)" );
