# @(#) $Id: basic.t,v 1.1.1.1 2003/03/14 15:01:51 dom Exp $

use strict;

use Test::More tests => 3;
use Test::XML;

eval { is_xml() };
like( $@, qr/^usage: /, 'is_xml() no args failure' );

eval { is_xml( '<foo/>' ) };
like( $@, qr/^usage: /, 'is_xml() 1 args failure' );

is_xml( '<foo />', '<foo></foo>', 'first usage example' );

# Local Variables:
# mode: cperl
# cperl-indent-level: 4
# indent-tabs-mode: nil
# End:
# vim: set ai et sw=4 syntax=perl :
