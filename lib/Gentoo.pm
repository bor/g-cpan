package Gentoo;

use 5.008007;
use strict;
use warnings;
use Data::Dumper;
use Gentoo::Config;
use Gentoo::Ebuild;
use Gentoo::CPAN;

# These libraries were influenced and largely written by
# Christian Harmann <ian@gentoo.org> originally. All of the good
# parts are ian's - the rest is mcummings messing around.

require Exporter;

our @ISA = qw(Exporter UNIVERSAL );

#our @EXPORT = qw( getAvailableEbuilds 
	#getCPANPackages	
#);

our $VERSION = '0.01';
sub _init {
	my ($self, %args ) = @_;
	return if $self->{_init}{__PACKAGE__}++;
	$self->Gentoo::Ebuild::_init(%args);
	$self->Gentoo::Config::_init(%args);
}

sub UNIVERSAL::debug
{
	my ($package, $file, $line ) = caller();
	my $subroutine = (caller(1))[3] || $package;
	print STDERR "In $subroutine ($file:$line):\n",
				Data::Dumper->Dump( [$_[0]] );
}
sub new {
	 my $proto = shift;
	 my %args = @_;
	 my $class = ref($proto) || $proto;
	 my $self = {};

	 $self->{modules} = {};
	 if ($args{portage_categories}) 
	 { $self->{portage_categories} = @{$args{portage_categories}}; }
	 $self->{DEBUG} = $args{debug};
	 $self->{packagelist} = [];

	 bless( $self, $class );
	 return $self;
}

sub DESTROY
{
	my ($self) = @_;
	return if $self->{DESTROY}{__PACKAGE__}++;

	$self->Gentoo::Config::DESTROY();
	$self->Gentoo::Ebuild::DESTROY();
}


1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Gentoo - Perl extension for blah blah blah

=head1 SYNOPSIS

  use Gentoo;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for Gentoo, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

A. U. Thor, E<lt>mcummings@datanode.netE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2006 by A. U. Thor

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.


=cut