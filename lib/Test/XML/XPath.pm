package Test::XML::XPath;
# @(#) $Id: XPath.pm,v 1.3 2003/05/14 23:36:56 dom Exp $

use strict;
use warnings;

use Carp;
use Test::More;
use Test::XML;
use Test::Builder;
use XML::XPath;

use vars qw( $VERSION );

$VERSION = '0.02';

my $Test = Test::Builder->new;

#---------------------------------------------------------------------
# Import shenanigans.  Copied from Test::Pod...
#---------------------------------------------------------------------

sub import {
    my $self = shift;
    my $caller = caller;

    no strict 'refs';
    *{ $caller . '::like_xpath' }   = \&like_xpath;
    *{ $caller . '::unlike_xpath' } = \&unlike_xpath;
    *{ $caller . '::is_xpath' }     = \&is_xpath;

    $Test->exported_to( $caller );
    $Test->plan( @_ );
}

#---------------------------------------------------------------------
# Tool.
#---------------------------------------------------------------------

sub like_xpath {
    my ($input, $statement, $test_name) = @_;
    croak "usage: like_xpath(xml,xpath[,name])"
      unless $input && $statement;
    my $ok = eval {
        my $xp = XML::XPath->new( xml => $input );
        return $xp->exists( $statement );
    };
    if ($@) {
        $Test->ok( 0, $test_name );
        $Test->diag( "  Parse Failure: $@" );
        return 0;
    } else {
        ok( $ok, $test_name );
        unless ( $ok ) {
            diag ( "           input: $input" );
            diag ( "  does not match: $statement" );
        }
        return $ok;
    }
}

sub unlike_xpath {
    my ($input, $statement, $test_name) = @_;
    croak "usage: unlike_xpath(xml,xpath[,name])"
      unless $input && $statement;
    my $ok = eval {
        my $xp = XML::XPath->new( xml => $input );
        return ! $xp->exists( $statement );
    };
    if ($@) {
        $Test->ok( 0, $test_name );
        $Test->diag( "  Parse Failure: $@" );
        return 0;
    } else {
        ok( $ok, $test_name );
        unless ( $ok ) {
            diag ( "       input: $input" );
            diag ( "  does match: $statement" );
        }
        return $ok;
    }
}

sub is_xpath {
    my ($input, $statement, $expected, $test_name) = @_;
    croak "usage: is_xpath(xml,xpath,expected[,name])"
      unless $input && $statement && $expected;
    my $got = eval {
        my $xp = XML::XPath->new( xml => $input );
        $xp->findvalue( $statement );
    };
    if ($@) {
        $Test->ok( 0, $test_name );
        $Test->diag( "  Parse Failure: $@" );
        return 0;
    } else {
        my $retval = $Test->is_eq( $got, $expected, $test_name );
        unless ( $retval ) {
            diag( "  evaluating: $statement" );
            diag( "     against: $input" );
        }
        return $retval;
    }
}

1;
__END__

=head1 NAME

Test::XML::XPath - Test XPath assertions

=head1 SYNOPSIS

  use Test::XML::XPath tests => 3;
  like_xpath( '<foo />', '/foo' );   # PASS
  like_xpath( '<foo />', '/bar' );   # FAIL
  unlike_xpath( '<foo />', '/bar' ); # PASS

  is_xpath( '<foo>bar</foo>', '/foo', 'bar' ); # PASS
  is_xpath( '<foo>bar</foo>', '/bar', 'foo' ); # FAIL

  # More interesting examples of xpath assertions.
  my $xml = '<foo attrib="1"><bish><bosh args="42">pub</bosh></bish></foo>';

  # Do testing for attributes.
  like_xpath( $xml, '/foo[@attrib="1"]' ); # PASS
  # Find an element anywhere in the document.
  like_xpath( $xml, '//bosh' ); # PASS
  # Both.
  like_xpath( $xml, '//bosh[@args="42"]' ); # PASS

=head1 DESCRIPTION

This module allows you to assert statements about your XML in the form
of XPath statements.  You can say that a piece of XML must contain
certain tags, with so-and-so attributes, etc.

B<NB>: Normally in XPath processing, the statement occurs from a
I<context> node.  In the case of like_xpath(), the context node will
always be the root node.  In practice, this means that these two
statements are identical:

   # Absolute path.
   like_xpath( '<foo/>', '/foo' );
   # Path relative to root.
   like_xpath( '<foo/>', 'foo' );

It's probably best to use absolute paths everywhere in order to keep
things simple.

B<NB>: Beware of specifying attributes.  Because they use an @-sign,
perl will complain about trying to interpolate arrays if you don't
escape them or use single quotes.

=head1 FUNCTIONS

=over 4

=item like_xpath ( XML, XPATH [, NAME ] )

Assert that XML (a string containing XML) matches the statement
XPATH.  NAME is the name of the test.

Returns true or false depending upon test success.

=item unlike_xpath ( XML, XPATH [, NAME ] )

This is the reverse of like_xpath().  The test will only pass if XPATH
I<does not> generates any matches in XML.

Returns true or false depending upon test success.

=item is_xpath ( XML, XPATH, EXPECTED [, NAME ] )

Evaluates XPATH against XML, and pass the test if the is EXPECTED.  Uses
findvalue() internally.

Returns true or false depending upon test success.

=back

In all cases, XML must be well formed, or the test will fail.

=head1 SEE ALSO

L<Test::XML>.

L<XML::XPath>, which is the basis for this module.

If you are not conversant with XPath, there are many tutorials
available on the web.  Google will point you at them.  The first one
that I saw was: L<http://www.zvon.org/xxl/XPathTutorial/>, which
appears to offer interactive XPath as well as the tutorials.

=head1 AUTHOR

Dominic Mitchell E<lt>cpan@semantico.comE<gt>

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
