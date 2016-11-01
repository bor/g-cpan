package Gentoo::Portage::Ebuild;

=head1 NAME

Gentoo::Portage::Ebuild - Gentoo ebuild representative

=head1 SYNOPSIS

    use Gentoo::Portage::Ebuild;

    my $ebuild = Gentoo::Portage::Ebuild->new($params);

=head1 DESCRIPTION

The module is for Gentoo ebuild representative.

=cut

use strict;
use warnings;

our $VERSION = '0.001';

use Gentoo::Portage::Q;
use Path::Tiny;

=head1 METHODS

=head2 new()

Returns a new C<Gentoo::Portage::Ebuild> object.

=cut

sub new {
    my $class = shift;
    return bless {}, $class;
}

sub read {    ## no critic (Subroutines::ProhibitBuiltinHomonyms)
    my ( $class, $ebuild_file ) = @_;

    return unless -e $ebuild_file;

    my $self = bless {}, $class;

    my $portageq = Gentoo::Portage::Q->new();
    my $gentoo_repo_path = $portageq->get_repo_path( $portageq->envvar('EROOT'), 'gentoo' );

    my @ebuild;
    for my $l ( path($ebuild_file)->lines() ) {
        if ( $l =~ /^inherit (.+)$/ ) {
            my @eclasses = split( / /, $1 );
            push @ebuild, path( $gentoo_repo_path, 'eclass', "$_.eclass" )->lines() for @eclasses;
        }
        else {
            push @ebuild, $l;
        }
    }

    my $ebuild_file_full = Path::Tiny->tempfile();
    $ebuild_file_full->spew_raw( \@ebuild );

    my %ebuild;
    open( my $h, '-|', "bash -norc -noprofile -c '. $ebuild_file_full; set'" ) or die "Can't run bash command: $!";
    while ( defined( my $l = <$h> ) ) {
        # skip already defined ENV vars, since we want only ebuild env
        if ( $l =~ /^(\w+)=(.*?)$/ and not defined $ENV{$1} ) {
            $ebuild{$1} = _strip_env_var($2);
        }
    }
    close $h;

    $self->{HOMEPAGE}    = $ebuild{HOMEPAGE};
    $self->{DESCRIPTION} = $ebuild{DESCRIPTION};

    return $self;
}


# helpers

sub _strip_env_var {
    my $var = shift;
    $var =~ s/\\n|\\t/ /g;
    $var =~ s/\s+/ /g;
    $var =~ s/^\$//g;
    $var =~ s/^'//g;
    $var =~ s/'$//g;
    $var =~ s/^\s//;
    $var =~ s/\s$//;
    return $var;
}

1;

__END__

=head1 TODO

=over

=item Split the module and place onto CPAN as separate one

=back

=head1 AUTHOR

Sergiy Borodych <bor@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2016 by Sergiy Borodych.

Distributed under the terms of the GNU General Public License v2.

=head1 SEE ALSO

L<ebuild>, L<https://wiki.gentoo.org/wiki/Ebuild>

=cut
