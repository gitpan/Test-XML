# @(#) $Id: whitespace.t,v 1.1 2003/03/14 16:24:26 dom Exp $
use strict;

use Test::More tests => 1;
use Test::XML;

{
    local $TODO = 'make whitespace significant';
    isnt_xml(
        '<p>foo</p>',
        '<p>  foo  </p>',
        'whitespace is significant',
    );
}

# Local Variables:
# mode: cperl
# cperl-indent-level: 4
# indent-tabs-mode: nil
# End:
# vim: set ai et sw=4 syntax=perl :
