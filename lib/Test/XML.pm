package Test::XML;
# @(#) $Id: XML.pm,v 1.2 2003/03/14 15:06:14 dom Exp $

use strict;
use warnings;

use base 'Exporter';

use Carp;
use Test::Builder;
use XML::SemanticDiff;

use vars qw( $VERSION @EXPORT @EXPORT_OK );

$VERSION   = '0.01';
@EXPORT    = qw( is_xml );
@EXPORT_OK = qw( is_xml );

my $Test = Test::Builder->new;

#---------------------------------------------------------------------
# Tool.
#---------------------------------------------------------------------

sub is_xml {
    my ($input, $expected, $test_name) = @_;
    croak "usage: is_xml(input,expected,test_name)"
        unless defined $input && defined $expected;
    local $Test::Builder::Level = $Test::Builder::Level + 1;
    my $differ = XML::SemanticDiff->new;
    #my @diffs = eval { $differ->compare( $input, $expected ) };
    my @diffs = eval { $differ->compare( $expected, $input ) };
    if ( @diffs ) {
        $Test->ok( 0, $test_name );
        $Test->diag( "Found " . scalar(@diffs) . " differences with expected:" );
        $Test->diag( "  $_->{message}" ) foreach @diffs;
        $Test->diag( "in processed XML:\n  $input" );
	return 0;
    } elsif ( $@ ) {
        $Test->ok( 0, $test_name );
        # Make the output a bit more testable.
        $@ =~ s/ at \/.*//;
        $Test->diag( "During compare:$@" );
        return 0;
    } else {
        $Test->ok( 1, $test_name );
	return 1;
    }
}

1;
__END__

=head1 NAME

Test::XML - Compare XML in perl tests

=head1 SYNOPSIS

  use Test::More tests => 2;
  use Test::XML;
  is_xml( '<foo />', '<foo></foo>' );
  is_xml( '<foo />', '<bar />' );

=head1 DESCRIPTION

This module contains generic XML testing tools.  See below for a list of
other modules with functions relating to specific XML modules.

=head1 FUNCTIONS

=over 4

=item is_xml ( GOT, EXPECTED [, TESTNAME ] )

This function compares GOT and EXPECTED, both of which are strings of
XML.  The comparison works semantically and will ignore differences in
syntax which are meaningless in xml, such as different quote characters
for attributes, order of attributes or empty tag styles.

Returns true or false, depending upon test success.

=back

=head1 SEE ALSO

L<Test::XML::SAX>, L<Test::XML::Twig>.

L<Test::More>, L<XML::SemanticDiff>.

=head1 AUTHOR

Dominic Mitchell, E<lt>cpan@semantico.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2002 by semantico

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

# Local Variables:
# mode: cperl
# cperl-indent-level: 4
# indent-tabs-mode: nil
# End:
# vim: set ai et sw=4 :
