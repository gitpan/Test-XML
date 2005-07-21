# @(#) $Id: whitespace.t,v 1.2 2005/07/21 20:10:17 dom Exp $
use strict;
use warnings;

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
