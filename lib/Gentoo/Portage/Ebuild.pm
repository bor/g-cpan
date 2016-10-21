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

=head1 METHODS

=head2 new()

Returns a new C<Gentoo::Portage::Ebuild> object.

=cut

sub new {
    my $class = shift;
    return bless {}, $class;
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
