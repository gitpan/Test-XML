# @(#) $Id: basic.t,v 1.2 2003/03/14 16:22:31 dom Exp $

use strict;

use Test::More tests => 6;
use Test::XML;

eval { is_xml() };
like( $@, qr/^usage: /, 'is_xml() no args failure' );

eval { is_xml( '<foo/>' ) };
like( $@, qr/^usage: /, 'is_xml() 1 args failure' );

is_xml( '<foo />', '<foo></foo>', 'first usage example' );

#---------------------------------------------------------------------

eval { isnt_xml() };
like( $@, qr/^usage: /, 'isnt_xml() no args failure' );

eval { isnt_xml( '<foo/>' ) };
like( $@, qr/^usage: /, 'isnt_xml() 1 args failure' );

isnt_xml( '<foo />', '<bar />', 'isnt_xml() works' );

# Local Variables:
# mode: cperl
# cperl-indent-level: 4
# indent-tabs-mode: nil
# End:
# vim: set ai et sw=4 syntax=perl :
