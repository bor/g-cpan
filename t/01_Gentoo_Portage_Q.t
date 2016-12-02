#!/usr/bin/env perl

use lib 'lib';
use strict;
use warnings;

use Cwd 'cwd';
use File::Spec ();
use Test::More tests => 5;

use_ok('Gentoo::Portage::Q');

my $portageq = new_ok('Gentoo::Portage::Q');
my ( $portageq_prefix, $portageq_real );

subtest 'envvar($variable)', sub {
    is( $portageq->envvar('EROOT'), '/', 'EROOT' );
    ok( $portageq->envvar('DISTDIR'), 'DISTDIR' );
    like( $portageq->envvar('USE'), qr/^\w[\w\s\-]*$/, 'USE' );
    ok( !$portageq->envvar('SOME_BOGUS_VAR'), 'fake var' );

    subtest 'with EPREFIX = t/data', sub {
        local $ENV{EPREFIX} = File::Spec->catdir( cwd(), 't', 'data' );
        $portageq_prefix = new_ok('Gentoo::Portage::Q');
        is( $portageq_prefix->envvar('EROOT'), $ENV{EPREFIX}, 'EROOT' );
    };

    subtest 'real Gentoo Linux', sub {
        plan skip_all => 'nope' unless -e '/etc/gentoo-release';
        $portageq_real = new_ok('Gentoo::Portage::Q');
        like( $portageq_real->envvar('ARCH'),            qr/^~?[\w\-]+$/, 'ARCH' );
        like( $portageq_real->envvar('ACCEPT_KEYWORDS'), qr/^~?[\w\-]+$/, 'ACCEPT_KEYWORDS' );
        ok( $portageq_real->envvar('MAKEOPTS'), 'MAKEOPTS' );
    };
};

subtest 'get_repo_path( $eroot, $repo_id )', sub {
    my $eroot = 't/data';
    is( $portageq->get_repo_path( $eroot, 'gentoo' ), '/usr/portage',       "trying for ('$eroot','gentoo')" );
    is( $portageq->get_repo_path( $eroot, 'local' ),  '/usr/local/portage', "trying for ('$eroot','local')" );
    is( $portageq->get_repo_path( $eroot, 'bogus' ),  undef,                "trying for ('$eroot','bogus')" );

    subtest 'real Gentoo Linux', sub {
        plan skip_all => 'nope' unless $portageq_real;
        $eroot = '/';
        is( $portageq_real->get_repo_path( $eroot, 'gentoo' ), '/usr/portage', "trying for ('$eroot','gentoo')" );
    };
};

subtest 'get_repos($eroot)', sub {
    my $eroot = 't/data';
    is_deeply( $portageq->get_repos($eroot), [ 'local', 'gentoo' ], "trying for ('$eroot')" );
};
