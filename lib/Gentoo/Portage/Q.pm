package Gentoo::Portage::Q;

=head1 NAME

Gentoo::Portage::Q - Portage information query tool

=head1 SYNOPSIS

    use Gentoo::Portage::Q;

    my $portageq = Gentoo::Portage::Q->new();
    my $eroot = $portageq->envvar('EROOT');
    my $repo_path = $portageq->get_repo_path( $eroot, 'gentoo' );

=head1 DESCRIPTION

The module provides interface for portage information query (mimic of L<portageq>)
Trying to keep the same interface as L<portageq> (part of L<portage>).

=cut

use strict;
use warnings;

=head1 METHODS

=cut

sub new { return bless {}, $_[0]; }

=head2 envvar($variable)

Returns a specific environment variable as exists prior to ebuild.sh.

=cut

sub envvar {
    my ( $self, $varname ) = @_;
    chomp( my $ret = qx/portageq envvar $varname/ );
    return $ret;
}

=head2 get_repo_path( $eroot, $repo_id )

Returns the path to the C<repo>.

=cut

sub get_repo_path {
    my ( $self, $eroot, $repo_id ) = @_;
    chomp( my $ret = qx/portageq get_repo_path $eroot $repo_id/ );
    return $ret;
}

1;

__END__

=head1 TODO

Provide pure Perl interface, and do not use F<portageq> under hood.

=head1 SEE ALSO

L<portageq>

=cut
